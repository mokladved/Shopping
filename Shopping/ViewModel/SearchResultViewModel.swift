//
//  SearchResultViewModel.swift
//  Shopping
//
//  Created by Youngjun Kim on 8/13/25.
//

import Foundation

final class SearchResultViewModel {
    
    let outputShoppingItems: Observable<[Item]> = Observable([])
    let outputRecommendedItems: Observable<[Item]> = Observable([])
    let outputTotalCountText: Observable<String?> = Observable(nil)
    let outputSelectedSortOption: Observable<Sorting> = Observable(.sim)
    let outputErrorMessage: Observable<String?> = Observable(nil)
    let scrollTrigger: Observable<Void?> = Observable(nil)
    let lastPageTrigger: Observable<Int?> = Observable(nil)
    let ouputTitle: Observable<String?> = Observable(nil)
    let sortOptionTrigger: Observable<Sorting?> = Observable(nil)
    
    private let keyword: String
    private var total: Int
    private var start = 1
    
    init(keyword: String, initialItems: [Item], total: Int) {
        self.keyword = keyword
        self.outputShoppingItems.value = initialItems
        self.total = total
        
        self.outputTotalCountText.value = "\(total.formatted())개의 검색 결과"
        self.ouputTitle.value = keyword
        bindTriggers()
    }
    
    func viewDidLoad() {
        callRecommendRequest()
    }
    
    func changeSortOption(to newOption: Sorting) {
        guard outputSelectedSortOption.value != newOption else {
            return
        }
        
        outputSelectedSortOption.value = newOption
        start = 1
        outputShoppingItems.value.removeAll()
        callRequest(sort: newOption)
    }
    
    func bindTriggers() {
        lastPageTrigger.lazyBind { [weak self] in
            guard let self = self else {
                return
            }
            guard let row = self.lastPageTrigger.value else {
                return
            }
            
            let shouldLoadNextPage = (row == self.outputShoppingItems.value.count - 3) && (self.outputShoppingItems.value.count < self.total)
            
            if shouldLoadNextPage {
                self.callRequest(sort: self.outputSelectedSortOption.value)
            }
        }
        
        sortOptionTrigger.lazyBind { [weak self] in
            guard let self = self else {
                return
            }
        
            guard let newOption = self.sortOptionTrigger.value,
                  self.outputSelectedSortOption.value != newOption else {
                return
            }
            
            self.outputSelectedSortOption.value = newOption
            self.start = 1
            self.outputShoppingItems.value.removeAll()
            self.callRequest(sort: newOption)
        }
    }

    private func callRequest(sort: Sorting) {
        let target = URLs.shopping(for: keyword, display: Constants.API.paginationStandards, sort: sort, start: start)
        
        NetworkManager.shared.callShopItemRequest(
            target: target,
            success: { [weak self] shopItem in
                guard let self = self else { return }
                self.total = shopItem.total
                self.outputShoppingItems.value.append(contentsOf: shopItem.items)
                self.start += shopItem.items.count
                self.outputTotalCountText.value = "\(shopItem.total.formatted()) 개의 검색 결과"
                
                if self.start == 1 && !shopItem.items.isEmpty {
                    self.scrollTrigger.value = ()
                }
            },
            failure: { [weak self] error in
                self?.outputErrorMessage.value = error.errorMessage
            }
        )
    }
    
    private func callRecommendRequest() {
        let target = URLs.shopping(for: Constants.Title.recommendKeyword, display: Constants.API.maxDisplayRecommendItem)
        
        NetworkManager.shared.callShopItemRequest(
            target: target,
            success: { [weak self] shopItem in
                self?.outputRecommendedItems.value = shopItem.items
            },
            failure: { [weak self] error in
                self?.outputErrorMessage.value = error.errorMessage
            }
        )
    }
}
