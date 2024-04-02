//
//  Friend.swift
//  FriendsFavoriteMovies
//
//  Created by Mohit Arora on 2024-04-01.
//

import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    var favoriteMovie: Movie?
    
    init(name: String) {
        self.name = name
    }
    
    static let sampleData = [
        Friend(name: "mayur"),
        Friend(name: "mann"),
        Friend(name: "rahul"),
        Friend(name: "rakesh"),
        Friend(name: "rajesh"),
        Friend(name: "harkesh")
    ]
}
