//
//  PlayCollectionViewCell.swift
//  Memorize
//
//  Created by AB027CJ on 2023/02/01.
//

import UIKit

class PlayCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "cardCellReuseIdentifier"
    
    var imageIdentifier: String?
    
    @IBOutlet weak var cardImageView: UIImageView!
}
