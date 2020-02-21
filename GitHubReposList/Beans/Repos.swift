//
//  Repos.swift
//  GitHubReposList
//
//  Created by Luiz Zenha on 17/02/20.
//  Copyright © 2020 Zenha. All rights reserved.
//

import Foundation

struct RootRepos : Decodable{
    var items: [Repos]
}

struct Repos : Decodable {
    var full_name: String!
    var name: String!
    var stargazers_count: Int!
    var owner: Author!
}
struct Author : Decodable {
    var login: String!
    var avatar_url: String!
    var url: String!
}
