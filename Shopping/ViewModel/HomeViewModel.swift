//
//  ShoppingViewModel.swift
//  Shopping
//
//  Created by Youngjun Kim on 8/12/25.
//

import Foundation

final class HomeViewModel {
    struct Input {
        let searchQuery: Observable<String?> = Observable(nil)
    }
    
    struct Output {
        let shoppingItems: Observable<[Item]> = Observable([])
        let keyword: Observable<String> = Observable("")
        let total: Observable<Int> = Observable(0)
        let errorMessage: Observable<String?> = Observable(nil)
        let pushTrigger: Observable<Void?> = Observable(nil)
    }
    
    let input: Input
    let output: Output
    
    init() {
        input = Input()
        output = Output()
        
        input.searchQuery.bind { [weak self] in
            guard let self = self else {
                return
            }
            guard let query = self.input.searchQuery.value else {
                return
            }
            self.searchButtonTapped(text: query)
        }
    }
    
    
    func searchButtonTapped(text: String?) {
        guard let text = text,
                !text.trimmingCharacters(in: .whitespaces).isEmpty,
                text.count >= 2 else {
            output.errorMessage.value = "두 글자 이상 입력해 주세요"
            return
        }
        
        NetworkManager.shared.callRequest(
            api: .keyword(for: text, display: Constants.API.paginationStandards),
            type: ShopItem.self,
            success: { [weak self] value in
                guard let self = self else { return }
                
                self.output.shoppingItems.value = value.items
                self.output.keyword.value = text
                self.output.total.value = value.total
                
                self.output.pushTrigger.value = ()
                
            },
            failure: { [weak self] error in
                self?.output.errorMessage.value = error.errorMessage
            }
        )
    }
}
