//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by Mohit Arora on 2024-04-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FilteredMovieList()
                .tabItem {
                    Label("Movie", systemImage: "film.stack")
                }
            
            FilteredFriendList()
                .tabItem {
                    Label("Friends", systemImage: "person.and.person")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.sharedData.modelContainer)
}
