//
//  MovieData.swift
//  Media
//
//  Created by 김윤우 on 6/10/24.
//

import Foundation

struct Movie:Decodable {
    
    let results:[result]
    
    
}

struct result:Decodable {
    
    let overview: String
    let poster_path: String
    let title: String
    let release_date: String
    let genre_ids: [Int]
    let id: Int
}

struct Genre: Decodable{
    
    let genres: [Genres]
    
}

struct Genres: Decodable {
    
    let id: Int
    let name: String
    
    
}


