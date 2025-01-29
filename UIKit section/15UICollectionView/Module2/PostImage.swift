//
//  PostImage.swift
//  UIKit section
//
//  Created by murad on 28.01.2025.
//

import Foundation

// MARK: - PostImage

//https://jsonplaceholder.typicode.com/photos/
//struct PostImage: Codable {
//    let albumID, id: Int
//    let title: String
//    let url, thumbnailURL: String
//    
//    enum CodingKeys: String, CodingKey {
//        case albumID = "albumId"
//        case id, title, url
//        case thumbnailURL = "thumbnailUrl"
//    }
//}

//https://picsum.photos/v2/list
struct PostImage: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
