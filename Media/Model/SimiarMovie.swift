//
//  SimiarMovie.swift
//  Media
//
//  Created by 김윤우 on 6/24/24.
//

import Foundation

struct SimiarMovie: Decodable {
    let page: Int
    let results: [Results]
}

struct Results: Decodable {
    
    let poster_path: String
    
}

