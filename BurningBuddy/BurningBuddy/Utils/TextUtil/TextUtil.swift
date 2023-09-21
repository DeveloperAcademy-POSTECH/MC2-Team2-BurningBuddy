//
//  TextLimitter.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/08/21.
//

import Foundation

class TextLimiter: ObservableObject {
    private let limit: Int
    init(limit: Int) {
        self.limit = limit
    }
    
    @Published var value = "" {
        didSet {
            if value.count > self.limit {
                value = String(value.prefix(self.limit))
                self.hasReachedLimit = true
            } else {
                self.hasReachedLimit = false
            }
        }
    }
    @Published var hasReachedLimit = false
}


struct TextUtil {
    func calculateLineSpacing(_ fontsize: Int, _ percent: Double) -> CGFloat {
        return CGFloat(Double(fontsize) * (percent / Double(100)) - Double(fontsize))
    }
}
