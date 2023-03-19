//
//  Extensions.swift
//  ModernConcurrencyApp
//
//  Created by Tiago Henriques on 18/03/2023.
//

import Foundation

extension JSONDecoder {
    static let snakeCaseDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
