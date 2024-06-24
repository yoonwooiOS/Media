//
//  RecommandMovie.swift
//  Media
//
//  Created by 김윤우 on 6/24/24.
//

import Foundation

struct RecommandMovie: Decodable {
    
    let page: Int
    let results: [RecommandMovieResult]
    
}

struct RecommandMovieResult: Decodable {
    
    let poster_path: String
    
}
