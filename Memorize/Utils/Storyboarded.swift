//
//  Storyboarded.swift
//  Memorize
//
//  Created by AB027CJ on 2023/01/28.
//

import Foundation
import UIKit

enum StoryboardName: String {
    case Main, Play
}

protocol Storyboarded {
    static func instantiate(from storyboard: StoryboardName) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(from storyboard: StoryboardName) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle(for: self))
        
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
}
