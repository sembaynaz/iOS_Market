//
//  ProductCard.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 13.11.2023.
//

import Foundation

struct ProductCard: Codable, Equatable {
    var image = "CardImage"
    var title = "BMW M4 Coupe: A Two-Door"
    var likeCount: Int = 0
    var description = "Безусловным лидером является BMW M4 CSL с впечатляющей мощностью в 551 л.с. и с 650 Нм крутящего момента. "
    var fullDescruption = "Безусловным лидером является BMW M4 CSL с впечатляющей мощностью в 551 л.с. и с 650 Нм крутящего момента. Уменьшение веса до 100 кг по сравнению с BMW M4 Competition Coupé, высокопроизводительный 6-цилиндровый рядный бензиновый двигатель M TwinPower Turbo и специально подобранные шины Ultra Track позволяют ощутить бескомпромиссную ДНК автоспорта в повседневной жизни."
    var cost = "23 000 $"
    var isFavorite = false 
    
    mutating func toggleFavorite() {
        isFavorite.toggle()
    }
    
    mutating func incrementLikeCount() -> Int{
        likeCount += 1
        return likeCount
    }
    
    mutating func decrementLikeCount() -> Int {
        likeCount -= 1
        if likeCount < 0 {
            likeCount = 0
        }
        return likeCount
    }
}
