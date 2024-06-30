//
//  MoviePoster.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import Foundation

protocol MoviePosterImage {
    var posterImage: String { get }
}


struct MoviePoster: Decodable {
    
    
    let backdrops: [Poster]?
    
}

struct Poster: Decodable, MoviePosterImage {
    let posterImage: String
    
    enum CodingKeys: String, CodingKey {
        case posterImage = "file_path"
    }
}


