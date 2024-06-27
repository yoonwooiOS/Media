//
//  TMDBAPI.swift
//  Media
//
//  Created by 김윤우 on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBAPI {
    case trendingMovie
    case search(query: String)
    case similarMovie(query: Int)
    case recommandMovie(query: Int)
    case moviePoster(query: Int)
    case genres
    case cast(query: Int)
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endPoint: URL {
        switch self {
        case .trendingMovie:
            return URL(string: baseURL + "trending/movie/day?")!
        case .similarMovie(let movieId):
            return URL(string: baseURL + "movie/\(movieId)/similar")!
        case .recommandMovie(let movieId):
            return URL(string: baseURL + "movie/\(movieId)/recommendations")!
        case .search:
            return URL(string: baseURL + "search/movie?")!
        case .moviePoster(query: let movieId):
            return URL(string: baseURL + "movie/\(movieId)/images")!
        case .genres:
            return URL(string: baseURL + "genre/movie/list")!
        case .cast(query: let query):
            return URL(string: baseURL + "movie/\(query)/credits")!
        }
    }
    var header: HTTPHeaders {
        return ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOWU1NzBhYWZmMDg1Y2Y0MjMyODczODljZDAyYmU3MiIsInN1YiI6IjY2NjE4MmI4MWVhMjUxMzEzZjQ0N2Y5YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lyHketTZ0Z_JlzqK1KZr0x7ktadHXe2Xxu3kUCHO7_o",
                "accept" : "application/json"
        ]
    }
    var method: HTTPMethod {
        return .get
    }
    var parameter: Parameters {
        switch self {
        case .trendingMovie:
            return ["language" : "ko-KR"]
        case .similarMovie(query: let movieId):
            return ["query" : movieId,
                    "language" : "ko-KR"
            ]
        case .recommandMovie(query: let movieId):
            return ["query" : movieId,
                    "language" : "ko-KR"
            ]
        case .search(query: let movie):
            return ["query" : movie,
                    "language" : "ko-KR"
            ]
        case .moviePoster(query: let movieId):
            return ["query" : movieId,
                    "language" : "ko-KR"]
        case .genres:
            return ["language" : "ko-KR"]
        case .cast(query: let movieId):
            return ["query" : movieId,
                    "language" : "ko-KR"]
        }
    }
}


// 네트워크 통신이 끝난 후 담아주면? -> codingKey + Protocol
