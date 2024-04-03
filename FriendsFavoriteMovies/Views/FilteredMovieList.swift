//
//  FilteredMovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Mohit Arora on 2024-04-02.
//

import SwiftUI

struct FilteredMovieList: View {
    
    @State private var searchText = ""
    @State private var sortByReleaseDate = false
    
    var body: some View {
        NavigationSplitView {
            MovieList(titleFilter: searchText, sortByReleaseDate: sortByReleaseDate)
                .searchable(text: $searchText)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Toggle(isOn: $sortByReleaseDate) {
                            Text("Sort by Release Date")
                        }.toggleStyle(.switch)
                    }
                }
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
