//
//  FilteredFriendList.swift
//  FriendsFavoriteMovies
//
//  Created by Mohit Arora on 2024-04-02.
//

import SwiftUI

struct FilteredFriendList: View {
    var body: some View {
        NavigationSplitView {
            FriendList()
        } detail: {
            Text("Select a Friend")
                .navigationTitle("Friend")
        }
    }
}

#Preview {
    FilteredFriendList()
        .modelContainer(SampleData.sharedData.modelContainer)
}
