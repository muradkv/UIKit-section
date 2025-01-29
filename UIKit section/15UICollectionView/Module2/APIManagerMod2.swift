//
//  APIManagerMod2.swift
//  UIKit section
//
//  Created by murad on 28.01.2025.
//
import UIKit

class APIManagerMod2 {
    func loadImage(id: Int, completion: @escaping ((UIImage?) -> Void)) {
        let urlString = "https://picsum.photos/id/\(id)/info"
        let url = URL(string: urlString)!
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data, let postImage = try? JSONDecoder().decode(PostImage.self, from: data) {
                print(postImage.url)
                self.loadImageContent(url: postImage.downloadURL, completion: completion)
            }
        }
        task.resume()
    }
    
    private func loadImageContent(url: String, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data, let image = UIImage(data: data) {
                print("Loaded image")
                completion(image)
            } else {
                print("Fail")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    //private let urlString = "https://jsonplaceholder.typicode.com/photos/"
    //private let urlString = "https://picsum.photos/v2/list"
    private let urlString = "https://picsum.photos/id/0/info"
}

//jsonplaceholder
//    func loadImage(id: Int, completion: @escaping ((UIImage?) -> Void)) {
//        let url = URL(string: urlString + "\(id)")!
//
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data, let postImage = try? JSONDecoder().decode(PostImage.self, from: data) {
//                print(postImage.url)
//                self.loadImageContent(url: postImage.url, completion: completion)
//            }
//        }
//        task.resume()
//    }

//Метод для временной локальной проверки
//func loadImage(completion: @escaping (([UIImage?]) -> Void)) {
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//        completion([
//            UIImage(systemName: "star"),
//            UIImage(systemName: "star"),
//            UIImage(systemName: "star")])
//    }
//}
