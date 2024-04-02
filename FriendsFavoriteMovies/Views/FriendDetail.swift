//
//  FriendDetail.swift
//  FriendsFavoriteMovies
//
//  Created by Mohit Arora on 2024-04-02.
//

import SwiftUI
import SwiftData

struct FriendDetail: View {
    
    @Bindable var friend: Friend
    let isNew: Bool
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \Movie.title) private var movies: [Movie]
    
    init(friend: Friend, isNew: Bool = false) {
        self.friend = friend
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $friend.name)
                .autocorrectionDisabled()
            
            Picker("Favorite Movie", selection: $friend.favoriteMovie) {
                Text("None")
                    .tag(nil as Movie?)
                ForEach(movies) { movie in
                    Text(movie.title)
                        .tag(movie as Movie?)
                }
            }
        }
        .navigationTitle(isNew ? "New Friend" : "Friend")
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(friend)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FriendDetail(friend: SampleData.sharedData.friend)
    }
    .modelContainer(SampleData.sharedData.modelContainer)
}

#Preview("New Friend") {
    NavigationStack {
        FriendDetail(friend: SampleData.sharedData.friend, isNew: true)
            .navigationBarTitleDisplayMode(.inline)
    }
    .modelContainer(SampleData.sharedData.modelContainer)
}
