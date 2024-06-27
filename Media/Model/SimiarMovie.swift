//
//  SimiarMovie.swift
//  Media
//
//  Created by 김윤우 on 6/24/24.
//

import Foundation

struct SRMovie: Decodable {
//    let page: Int
    let results: [Results]
}

struct Results: Decodable, MoviePosterImage {
    let posterImage: String
    
    enum CodingKeys: String, CodingKey {
        case posterImage = "poster_path"
    }
}

//let a: [MoviePosterImage] = [Results(posterImage: ""), Poster(posterImage: "")]

//for movie in a {
//    movie.posterImage
//}
