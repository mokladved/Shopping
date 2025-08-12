//
//  ShoppingViewModel.swift
//  Shopping
//
//  Created by Youngjun Kim on 8/12/25.
//

import Foundation

final class HomeViewModel {
    let inputSearchQuery: Observable<String?> = Observable(nil)
    let outputShoppingItems: Observable<[Item]> = Observable([])
    let outputKeyword: Observable<String> = Observable("")
    let outputTotal: Observable<Int> = Observable(0)

    let outputErrorMessage: Observable<String?> = Observable(nil)
    
    let pushTrigger: Observable<Void?> = Observable(nil)
    
    init() {
        inputSearchQuery.bind { [weak self] in
            guard let self = self else {
                return
            }
            guard let query = self.inputSearchQuery.value else {
                return
            }
            self.searchButtonTapped(text: query)
        }
    }
    
    
    
    func searchButtonTapped(text: String?) {
        guard let text = text,
                !text.trimmingCharacters(in: .whitespaces).isEmpty,
                text.count >= 2 else {
            outputErrorMessage.value = "두 글자 이상 입력해 주세요"
            return
        }
        
        let target = URLs.shopping(for: text, display: Constants.API.paginationStandards)
        
        NetworkManager.shared.callShopItemRequest(
            target: target,
            success: { [weak self] shopItem in
                guard let self = self else { return }
                
                self.outputShoppingItems.value = shopItem.items
                self.outputKeyword.value = text
                self.outputTotal.value = shopItem.total
                
                self.pushTrigger.value = ()
                
            },
            failure: { [weak self] error in
                self?.outputErrorMessage.value = error.errorMessage
            }
        )
    }
}
