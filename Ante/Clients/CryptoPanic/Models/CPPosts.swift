//
//  CPPosts.swift
//  Ante
//
//  Created by Zameer Andani on 5/22/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct CPPostCurrency: Decodable {
   let code: String
   let title: String
   let slug: String
   let url: String

   enum CodingKeys: String, CodingKey {
      case code
      case title
      case slug
      case url
   }
}

struct CPPostSource: Decodable {
   let domain: String
   let title: String
   let path: String?
   
   enum CodingKeys: String, CodingKey {
      case domain
      case title
      case path
   }
}

struct CPPostVotes: Decodable {
   let negative: Int
   let positive: Int
   let important: Int
   let disliked: Int
   let lol: Int
   let toxic: Int
   let saved: Int
   
   enum CodingKeys: String, CodingKey {
      case negative
      case positive
      case important
      case disliked
      case lol
      case toxic
      case saved
   }
}

struct CPPost: Decodable {
   let id: Int
   let createdAt: Date
   let domain: String
   let title: String
   let publishedAt: Date
   let slug: String
   let url: String
   
   let currencies: [CPPostCurrency]
   let source: CPPostSource
   let votes: CPPostVotes
   
   enum CodingKeys: String, CodingKey {
      case id
      case createdAt = "created_at"
      case domain
      case title
      case publishedAt = "published_at"
      case slug
      case url
      case currencies
      case source
      case votes
   }
}

struct CPPosts: AnteModel {
   let source: AnteDataSource = .cryptopanic
   
   let count: Int
   let next: String
   let prev: String?
   let results: [CPPost]
   
   enum CodingKeys: String, CodingKey {
      case count
      case next
      case prev
      case results
   }
}
