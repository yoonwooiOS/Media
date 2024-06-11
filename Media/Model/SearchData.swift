//
//  SearchData.swift
//  Media
//
//  Created by 김윤우 on 6/11/24.
//

import Foundation

struct SearchMovie: Decodable {
    
    let page: Int
    var results: [Result]
    let total_pages: Int
    let total_results: Int
    
    func getPage() -> Int{
        return self.page
    }
}

struct Result: Decodable {
    
    let title: String
    let poster_path: String?
    let vote_average: Double
    
    
}
