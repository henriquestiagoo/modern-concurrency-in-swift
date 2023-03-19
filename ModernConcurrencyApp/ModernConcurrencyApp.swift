//
//  ModernConcurrencyAppApp.swift
//  ModernConcurrencyApp
//
//  Created by Tiago Henriques on 18/03/2023.
//

import SwiftUI

@main
struct ModernConcurrencyApp: App {
    var body: some Scene {
        WindowGroup {
            PostsView(model: PostsRequestModel())
        }
    }
}
