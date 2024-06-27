//
//  MovieDetail.swift
//  Media
//
//  Created by 김윤우 on 6/12/24.
//

import Foundation

struct MovieDetail: Decodable {
    
    let id: Int
    let cast: [Cast]
    
}

struct Cast: Decodable {
    
    let original_name: String
    let profile_path: String?
    let character: String
}
