//
//  Card.swift
//  Memorize
//
//  Created by AB027CJ on 2023/01/29.
//
import UIKit

struct Card: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let image: Image
}

struct Image: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let image: UIImage
}


#if DEBUG
extension Card {
    static func sampleData() -> [Card] {
        let  images = [
            Image(image: UIImage(systemName: "plus")!),
            Image(image: UIImage(systemName: "phone.fill")!),
            Image(image: UIImage(systemName: "circle.fill")!),
            Image(image: UIImage(systemName: "square.fill")!),
            Image(image: UIImage(systemName: "heart.fill")!),
            Image(image: UIImage(systemName: "camera.fill")!),
        ]
        return [
            Card(image: images[0]), Card(image: images[1]), Card(image: images[2]), Card(image: images[3]),
            Card(image: images[4]), Card(image: images[2]), Card(image: images[0]), Card(image: images[3]),
            Card(image: images[5]), Card(image: images[4]), Card(image: images[5]), Card(image: images[1])
        ]
    }
}
#endif

