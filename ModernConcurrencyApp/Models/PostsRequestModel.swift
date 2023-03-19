//
//  PostsViewModel.swift
//  ModernConcurrencyApp
//
//  Created by Tiago Henriques on 18/03/2023.
//

import Foundation
import UIKit

class PostsRequestModel: ObservableObject {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "\(API.baseUrl)/api/posts") else { throw "Could not create the URL." }
        let (data, response) = try await session.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw "The server responded with an error." }
        guard let list = try? JSONDecoder.snakeCaseDecoder.decode([Post].self, from: data) else { throw "The server response was not recognized." }
        return list.reversed()
    }
    
    func fetchPostDetail(_ post: Post) async throws -> Post {
        guard let url = URL(string: "\(API.baseUrl)/api/post/data/\(post.id)") else { throw "Could not create the URL." }
        let (data, response) = try await session.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw "The server responded with an error." }
        guard let post = try? JSONDecoder.snakeCaseDecoder.decode(Post.self, from: data) else { throw "The server response was not recognized." }
        return post
    }
    
    func image(_ imageUrl: String) async throws -> UIImage {
        guard let url = URL(string: imageUrl) else { throw "Could not create the download URL." }
        let (data, response) = try await session.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw "The server responded with an error." }
        guard let image = UIImage(data: data) else { throw "Could not get image from data." }
        return image
    }
    
    func calculateTotalNumberOfPostReads(_ posts: [Post]) async throws -> Int {
        try await withThrowingTaskGroup(
            of: Post.self,
            returning: Int.self
        ) { group in
            for post in posts {
                group.addTask { try await self.fetchPostDetail(post) }
            }
            return try await group.reduce(into: 0) { result, post in
                if let numberViews = post.numberViews {
                    result += numberViews
                }
            }
        }
    }
}
