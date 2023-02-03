//
//  PlayViewModel.swift
//  Memorize
//
//  Created by AB027CJ on 2023/01/28.
//

import Foundation
import UIKit


final class PlayViewModel {
    weak var coordinator: PlayCoordinator?
    var cards = Card.sampleData()
    private var buffer: (Image.ID, IndexPath)? = nil
    private var matches = [IndexPath]()
    var score = 0
    
    func shouldMatchCard(with indexPath: IndexPath) -> (Bool, [IndexPath]) {
        let card = card(for: indexPath)
        guard let buffer = buffer else {
            buffer = (card.image.id, indexPath)
            return (false, [])
        }
        if buffer.0 == card.image.id {
            score += 20
            self.buffer = nil
            return (true, [buffer.1, indexPath])
        } else {
            score -= 10
            self.buffer = nil
            return (false, [buffer.1, indexPath])
        }
    }
    
    private func card(for indexPath: IndexPath) -> Card {
        return cards[indexPath.row]
    }
}
