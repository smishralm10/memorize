//
//  Card.swift
//  Memorize
//
//  Created by AB027CJ on 2023/01/29.
//
import UIKit

struct Card: Identifiable, Hashable {
    let id: String = UUID().uuidString
    
    var frontView: UIView {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }
    
    var backView: UIView {
        let view = UIView()
        view.backgroundColor = .systemMint
    return view
    }
}


#if DEBUG
extension Card {
    static func sampleData() -> [Card] {
        return [
            Card(), Card(), Card(), Card(),
            Card(), Card(), Card(), Card(),
            Card(), Card(), Card(), Card()
        ]
    }
}
#endif

