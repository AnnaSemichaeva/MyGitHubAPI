//
//  Repository.swift
//  MyGitHubAPI
//
//  Created by macuser on 11/13/22.
//

import UIKit

struct Repository: Decodable{
    var id: Int
    var name: String
    var owner: RepositoryOwner
    var description: String?
    var html_url: String
}

