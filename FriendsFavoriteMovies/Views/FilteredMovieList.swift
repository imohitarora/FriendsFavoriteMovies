//
//  FilteredMovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Mohit Arora on 2024-04-02.
//

import SwiftUI

struct FilteredMovieList: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationSplitView {
            MovieList(titleFilter: searchText)
                .searchable(text: $searchText)
        } detail: {
            Text("Select a movie")
                .navigationTitle("Movie")
        }
    }
}

#Preview {
    FilteredMovieList()
            .modelContainer(SampleData.sharedData.modelContainer)
}
