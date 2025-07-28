//
//  String+Extension.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/28/25.
//

import Foundation

extension String {
    var removedTags: String {
        return self.replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
    }
}
