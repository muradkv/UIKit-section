//
//  Source.swift
//  UIKit section
//
//  Created by murad on 25.01.2025.
//

import UIKit

struct Source {
    static func allPhotos() -> [Photo] {
        return [
            Photo(id: 1, imageName: "shpic1"),
            Photo(id: 2, imageName: "shpic2"),
            Photo(id: 3, imageName: "shpic3"),
            Photo(id: 4, imageName: "shpic4"),
            Photo(id: 5, imageName: "shpic5"),
            Photo(id: 6, imageName: "shpic6"),
            Photo(id: 7, imageName: "shpic7"),
            Photo(id: 8, imageName: "shpic8"),
            Photo(id: 9, imageName: "shpic9"),
            Photo(id: 10, imageName: "shpic10"),
            Photo(id: 11, imageName: "shpic11"),
        ]
    }

    static func randomPhotos(with count: Int) -> [Photo] {
        return (0..<count).map { _ in allPhotos().randomElement()! }
    }
}

struct Photo {
    let id: Int
    let imageName: String
}

struct SectionPhoto {
    let sectionName: String
    var photos: [Photo]
}
