//
//  FriendList.swift
//  FriendsFavoriteMovies
//
//  Created by Mohit Arora on 2024-04-01.
//

import SwiftUI
import SwiftData

struct FriendList: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Friend.name) private var friends: [Friend]
    
    @State private var newFriend: Friend?
    
    init(titleFilter: String = "") {
        let predicate = #Predicate<Friend> { friend in
            titleFilter.isEmpty || friend.name.localizedStandardContains(titleFilter)
        }
        
        _friends = Query(filter: predicate, sort: \Friend.name)
    }
    
    var body: some View {
        NavigationSplitView {
            Group {
                if !friends.isEmpty {
                    List {
                        ForEach(friends) { friend in
                            NavigationLink {
                                FriendDetail(friend: friend)
                            } label: {
                                Text(friend.name)
                            }
                        }
                        .onDelete(perform: deleteFriends)
                    }
                } else {
                    ContentUnavailableView {
                        Label("No Friends", systemImage: "person.and.person")
                    }
                }
            }
            .navigationTitle("Friends")
            .toolbar {
                ToolbarItem {
                    Button(action: addFriend) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(item: $newFriend) { friend in
                NavigationStack {
                    FriendDetail(friend: friend, isNew: true)
                }
                .interactiveDismissDisabled()
            }
        } detail: {
            Text("Select a Friend")
                .navigationTitle("Friend")
        }
    }
    
    private func addFriend() {
        withAnimation {
            let newItem = Friend(name: "")
            modelContext.insert(newItem)
            newFriend = newItem
        }
    }
    
    private func deleteFriends(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(friends[index])
            }
        }
    }
}

#Preview {
    FriendList()
        .modelContainer(SampleData.sharedData.modelContainer)
}
