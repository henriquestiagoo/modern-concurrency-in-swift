//
//  ContentView.swift
//  ModernConcurrencyApp
//
//  Created by Tiago Henriques on 18/03/2023.
//

import SwiftUI

struct PostsView: View {
    let model: PostsRequestModel
    @State var posts: [Post] = []
    /// The latest error message.
    @State var lastErrorMessage = "None" {
      didSet {
        isDisplayingError = true
      }
    }
    @State var isDisplayingError = false
    @State var isPresentingSettings = false

    var body: some View {
        NavigationView {
            VStack {
                List(posts) { post in
                    NavigationLink {
                        PostDetailView(post: post)
                            .environmentObject(model)
                    } label: {
                        PostRowView(post: post)
                    }
                }
                .navigationBarTitle("Latest Articles")
            }
            .alert("Error", isPresented: $isDisplayingError, actions: {
                Button("Close", role: .cancel) { }
            }, message: {
                Text(lastErrorMessage)
            })
            .sheet(isPresented: $isPresentingSettings) {
                SettingsView(posts: posts)
                    .environmentObject(model)
            }
            .toolbar {
                Button("Settings") {
                    isPresentingSettings = true
                }
                .disabled(posts.isEmpty)
            }
            .task {
                guard posts.isEmpty else { return }
                do {
                    posts = try await model.fetchPosts()
                } catch {
                    lastErrorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct PostRowView: View {
    private let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(post.name).bold()
                Spacer()
                Text(post.publishedAt)
                    .foregroundColor(Color.gray)
            }
            Text(post.summary)
        }
        .padding()
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView(model: PostsRequestModel())
    }
}
