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
    private var buffer = [Image.ID]()
    private var matches = [IndexPath]()
    
    
    private func card(for indexPath: IndexPath) -> Card {
        return cards[indexPath.row]
    }
}
