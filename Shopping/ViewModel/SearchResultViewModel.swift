//
//  SearchResultViewModel.swift
//  Shopping
//
//  Created by Youngjun Kim on 8/13/25.
//

import Foundation

final class SearchResultViewModel {
    struct Input {
        let lastPageTrigger: Observable<Int?> = Observable(nil)
        let sortOptionTrigger: Observable<Sorting?> = Observable(nil)
    }
    
    struct Output {
        let shoppingItems: Observable<[Item]> = Observable([])
        let recommendedItems: Observable<[Item]> = Observable([])
        let totalCountText: Observable<String?> = Observable(nil)
        let selectedSortOption: Observable<Sorting> = Observable(.sim)
        let errorMessage: Observable<String?> = Observable(nil)
        let title: Observable<String?> = Observable(nil)
        let scrollTrigger: Observable<Void?> = Observable(nil)
    }
    
    let output: Output
    let input: Input
    
    private let keyword: String
    private var total: Int
    private var start = 1
    
    init(keyword: String, initialItems: [Item], total: Int) {
        input = Input()
        output = Output()
        
        self.keyword = keyword
        self.output.shoppingItems.value = initialItems
        self.total = total
        
        self.output.totalCountText.value = "\(total.formatted())개의 검색 결과"
        self.output.title.value = keyword
        bindTriggers()
    }
    
    func viewDidLoad() {
        callRecommendRequest()
    }
    
    func changeSortOption(to newOption: Sorting) {
        guard output.selectedSortOption.value != newOption else {
            return
        }
        
        output.selectedSortOption.value = newOption
        start = 1
        output.shoppingItems.value.removeAll()
        callRequest(sort: newOption)
    }
    
    func bindTriggers() {
        input.lastPageTrigger.lazyBind { [weak self] in
            guard let self = self else {
                return
            }
            guard let row = self.input.lastPageTrigger.value else {
                return
            }
            
            let shouldLoadNextPage = (row == self.output.shoppingItems.value.count - 3) && (self.output.shoppingItems.value.count < self.total)
            
            if shouldLoadNextPage {
                self.callRequest(sort: self.output.selectedSortOption.value)
            }
        }
        
        input.sortOptionTrigger.lazyBind { [weak self] in
            guard let self = self else {
                return
            }
        
            guard let newOption = self.input.sortOptionTrigger.value,
                  self.output.selectedSortOption.value != newOption else {
                return
            }
            
            self.output.selectedSortOption.value = newOption
            self.start = 1
            self.output.shoppingItems.value.removeAll()
            self.callRequest(sort: newOption)
        }
    }

    private func callRequest(sort: Sorting) {
        NetworkManager.shared.callRequest(
            api: .keyword(for: keyword, display: Constants.API.paginationStandards, sort: sort, start: start),
            type: ShopItem.self,
            success: { [weak self] value in
                guard let self = self else { return }
                self.total = value.total
                self.output.shoppingItems.value.append(contentsOf: value.items)
                self.start += value.items.count
                self.output.totalCountText.value = "\(value.total.formatted()) 개의 검색 결과"
                
                if self.start == 1 && !value.items.isEmpty {
                    self.output.scrollTrigger.value = ()
                }
            },
            failure: { [weak self] error in
                self?.output.errorMessage.value = error.errorMessage
            }
        )
    }
    
    private func callRecommendRequest() {
        NetworkManager.shared.callRequest(
            api: .keyword(for: Constants.Title.recommendKeyword, display: Constants.API.maxDisplayRecommendItem),
            type: ShopItem.self,
            success: { [weak self] value in
                self?.output.recommendedItems.value = value.items
            },
            failure: { [weak self] error in
                self?.output.errorMessage.value = error.errorMessage
            }
        )
    }
}
