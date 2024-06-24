//
//  MoviePoster.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import Foundation

struct MoviePoster: Decodable {
    
    let backdrops: [Poster]
    
}

struct Poster: Decodable {
    
    let file_path: String
    
}
