//
//  SearchResultDetailMovie.swift
//  Media
//
//  Created by 김윤우 on 6/26/24.
//

import Foundation
import Alamofire

struct RelatedMovie:Decodable {
    let results:[result]
}

struct SearchDetailMovieresult:Decodable {
    let poster_path: String
}

