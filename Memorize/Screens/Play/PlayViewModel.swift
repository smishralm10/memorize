//
//  PlayViewModel.swift
//  Memorize
//
//  Created by AB027CJ on 2023/01/28.
//

import Foundation
import UIKit
import Combine


final class PlayViewModel {
    
    weak var coordinator: PlayCoordinator?
    
    var cards = Card.sampleData()
    
    let timeLeftPublisher = PassthroughSubject<Int, Never>()
    
    private var buffer: (Image.ID, IndexPath)? = nil
    
    var timer: Timer?
    
    var score = 0
    var timeLeft = 0
    
    var hasGameStarted = false
    
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
    
    func prepareForGame() {
        timeLeft = 5
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(countDown),
            userInfo: nil,
            repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    @objc func countDown() {
        timeLeftPublisher.send(timeLeft)
        if timeLeft > 0 {
            timeLeft -= 1
        } else {
            timer?.invalidate()
        }
    }
    
    private func card(for indexPath: IndexPath) -> Card {
        return cards[indexPath.row]
    }
}
