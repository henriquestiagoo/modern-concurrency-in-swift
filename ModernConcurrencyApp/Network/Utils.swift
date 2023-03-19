//
//  Utils.swift
//  ModernConcurrencyApp
//
//  Created by Tiago Henriques on 19/03/2023.
//

import Foundation

struct API {
    static let baseUrl: String = "https://tiagohenriques.vercel.app"
}

/// Easily throw generic errors with a text description.
extension String: LocalizedError {
    public var errorDescription: String? {
        return self
    }
}
