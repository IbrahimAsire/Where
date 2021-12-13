//
//  NewsPosts.swift
//  Where
//
//  Created by ibrahim asiri on 09/05/1443 AH.
//

import Foundation

struct NewPosts: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let url: String
}
