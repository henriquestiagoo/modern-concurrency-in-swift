//
//  Post.swift
//  ModernConcurrencyApp
//
//  Created by Tiago Henriques on 18/03/2023.
//

import Foundation

struct Post: Codable, Equatable, Identifiable {
    let id: Int
    let name: String
    let summary: String
    let publishedAt: String
    let postUrl: String
    var githubUrl: String?
    var imageUrl: String?
    var numberViews: Int?
}

extension Post {
    static let mock = Self(
        id: 2,
        name: "A Tour of The Composable Architecture with the SpaceX API 🚀",
        summary: "Learn how to structure your iOS App with declarative state changes using The Composable Architecture library.",
        publishedAt: "2021-11-06",
        postUrl: "https://tiagohenriques.vercel.app/blog/spacex-composable-architecture",
        githubUrl: "https://github.com/henriquestiagoo/spacex-tca",
        imageUrl: "https://tiagohenriques.vercel.app/static/images/blog/composable-architecture-spacex/favorite_launches.jpeg"
    )
    
    static let emptyImageMock = Self(
        id: 2,
        name: "A Tour of The Composable Architecture with the SpaceX API 🚀",
        summary: "Learn how to structure your iOS App with declarative state changes using The Composable Architecture library.",
        publishedAt: "2021-11-06",
        postUrl: "https://tiagohenriques.vercel.app/blog/spacex-composable-architecture",
        githubUrl: "https://github.com/henriquestiagoo/spacex-tca"
    )
}
