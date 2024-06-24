//
//  NetworkManager.swift
//  Media
//
//  Created by 김윤우 on 6/24/24.
//

import UIKit
import Alamofire

class NetworkManager {
    
    
    
    
    
    static func callSimilarMovieAPIRequest(movieId: Int, complitionHanlder: @escaping (SimiarMovie) -> ()  ) {
        
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/similar"
        let header: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization" : APIKey.tmdbKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: SimiarMovie.self) { response in
                
                print("STATUS: \(response.response?.statusCode ?? 0)")
                
            switch response.result {
            case .success(let value):
                print("Success")
                dump(value)
                complitionHanlder(value)
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
        
    }
    
    
    static func callRecommandMovieAPIRequest(movieId: Int, complitionHanlder: @escaping (RecommandMovie) -> ()  ) {
        
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/recommendations"
        let header: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization" : APIKey.tmdbKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RecommandMovie.self) { response in
                
                print("STATUS: \(response.response?.statusCode ?? 0)")
                
            switch response.result {
            case .success(let value):
                print("Success")
                dump(value)
                complitionHanlder(value)
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
        
    }
    
    
    static func callMoviePosterPIRequest(movieId: Int, complitionHanlder: @escaping (MoviePoster) -> ()  ) {
        
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/images"
        let header: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization" : APIKey.tmdbKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: MoviePoster.self) { response in
                
                print("STATUS: \(response.response?.statusCode ?? 0)")
                
            switch response.result {
            case .success(let value):
                print("Success")
                dump(value)
                complitionHanlder(value)
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
        
    }
    
    
}
