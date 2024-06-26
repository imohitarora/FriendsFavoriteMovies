//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by Mohit Arora on 2024-04-01.
//

import SwiftUI
import SwiftData

struct MovieList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var movies: [Movie]
    
    @State private var newMovie: Movie?
    
    @State private var titleSort = SortDescriptor(\Movie.title)
    @State private var releaseDateSort = SortDescriptor(\Movie.releaseDate)
    
    init(titleFilter: String = "", sortByReleaseDate: Bool = false) {
        let predicate = #Predicate<Movie> { movie in
            titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
        }
        
        let sortOrder = sortByReleaseDate ? releaseDateSort : titleSort
        
        _movies = Query(filter: predicate, sort: [sortOrder])
    }
    
    
    var body: some View {
        
        Group {
            if !movies.isEmpty {
                List {
                    ForEach(movies) { movie in
                        NavigationLink {
                            MovieDetail(movie: movie)
                        } label: {
                            Text(movie.title)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            } else {
                ContentUnavailableView {
                    Label("No Movies", systemImage: "film.stack")
                }
            }
        }
        .navigationTitle("Movies")
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addMovie) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(item: $newMovie) { movie in
            NavigationStack {
                MovieDetail(movie: movie, isNew: true)
            }
            .interactiveDismissDisabled()
        }
        
    }
    
    private func addMovie() {
        withAnimation {
            let newItem = Movie(title: "", releaseDate: Date())
            modelContext.insert(newItem)
            newMovie = newItem
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(movies[index])
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieList()
            .modelContainer(SampleData.sharedData.modelContainer)
    }
}


#Preview("Empty List") {
    NavigationStack {
        MovieList()
            .modelContainer(for: Movie.self, inMemory: true)
    }
}


#Preview("Filtered") {
    NavigationStack {
        MovieList(titleFilter: "tr")
            .modelContainer(SampleData.sharedData.modelContainer)
    }
}
