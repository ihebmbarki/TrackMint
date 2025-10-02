//
//  Trade.swift
//  TrackMint
//
//  Created by Iheb Mbarki on 24/9/2025.
//

import Foundation

enum TradeType {
    case long
    case short
}

struct Trade {
    let coin: String
    let entry: Double
    let exit: Double
    let quantity: Double
    let date: Date
    let type: TradeType
    let notes: String?
    
    var percentageChange: Double {
          let change = ((exit - entry) / entry) * 100
          return type == .long ? change : -change
      }
    
    var profitLoss: Double {
        let diff = (exit - entry) * quantity
        return type == .long ? diff : -diff
    }
}
