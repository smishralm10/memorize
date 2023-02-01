//
//  PlayCollectionViewCell.swift
//  Memorize
//
//  Created by AB027CJ on 2023/02/01.
//

import UIKit

class PlayCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "cardCellReuseIdentifier"
    
    var isFlipped: Bool = false
    
    @IBOutlet weak var cardImageView: UIImageView!
}
