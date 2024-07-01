//
//  MovieTrailer.swift
//  Media
//
//  Created by 김윤우 on 7/1/24.
//

import Foundation

struct MovieTrailer: Decodable {
    let results: [MovieTrailerResult]
    
}

struct MovieTrailerResult: Decodable {
    let key: String
}
