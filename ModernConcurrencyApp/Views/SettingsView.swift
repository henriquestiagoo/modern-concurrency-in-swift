//
//  SettingsView.swift
//  ModernConcurrencyApp
//
//  Created by Tiago Henriques on 18/03/2023.
//

import SwiftUI

struct SettingsView: View {
    let posts: [Post]
    @EnvironmentObject var model: PostsRequestModel
    @State var numberViews: Int = 0
    @State var isRequestInFlight: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        HStack {
                            Text("Total number of articles views:")
                            Spacer()
                            if isRequestInFlight {
                                ProgressView()
                            } else {
                                Text("\(numberViews)")
                            }
                        }
                    } header: {
                        Text("Analytics")
                    } footer: {
                        Text("The number of views for each article is being randomly generated.")
                    }

                }
            }
            .navigationBarTitle("Settings")
            .task {
                do {
                    isRequestInFlight = true
                    numberViews = try await model.calculateTotalNumberOfPostsViews(posts)
                } catch {}
                isRequestInFlight = false
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(posts: [Post.mock])
            .environmentObject(PostsRequestModel())
    }
}
