//
//  PostDetailView.swift
//  ModernConcurrencyApp
//
//  Created by Tiago Henriques on 18/03/2023.
//

import SwiftUI

struct PostDetailView: View {
    @EnvironmentObject var model: PostsRequestModel
    @State var post: Post
    @State var image: UIImage?
    @State var isRequestInFlight: Bool = false
    /// The latest error message.
    @State var lastErrorMessage = "None" {
        didSet {
            isDisplayingError = true
        }
    }
    @State var isDisplayingError = false

    var body: some View {
        VStack {
            if isRequestInFlight {
                  ProgressView("Loading...")
                
            } else {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                } else {
                    Text("No preview available")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(.white)
                        .background(.gray)
                }
                Text(post.name)
                    .font(.headline)
                    .padding(.top, 20)
                
                if let numberViews = post.numberViews {
                    Text("\(numberViews) views")
                        .font(.body)
                        .padding(.top, 6)
                }
            }
        }
        .padding()
        .alert("Error", isPresented: $isDisplayingError, actions: {
            Button("Close", role: .cancel) { }
        }, message: {
            Text(lastErrorMessage)
        })
        .task {
            self.isRequestInFlight = true
            do {
                async let postDetail = try model.fetchPostDetail(post)
                async let image = try model.image(post.imageUrl)
                let (postResult, imageResult) = try await (postDetail, image)
                self.post = postResult
                self.image = imageResult
            
            } catch {
                lastErrorMessage = error.localizedDescription
            }
            self.isRequestInFlight = false
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: Post.mock)
            .environmentObject(PostsRequestModel())
    }
}
