//
//  NetworkManager.swift
//  Media
//
//  Created by 김윤우 on 6/24/24.
//

import UIKit
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
     func callSimilarMovieAPIRequest(movieId: Int, complitionHanlder: @escaping ([result]) -> Void  ) {
        
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/similar"
        let header: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization" : APIKey.tmdbKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RelatedMovie.self) { response in
                
                print("STATUS: \(response.response?.statusCode ?? 0)")
                
            switch response.result {
            case .success(let value):
                print("Success")
                dump(value)
                complitionHanlder(value.results)
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
        
    }
    
    
     func callRecommandMovieAPIRequest(movieId: Int, complitionHanlder: @escaping ([result]) -> Void  ) {
        
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/recommendations"
        let header: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization" : APIKey.tmdbKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RelatedMovie.self) { response in
                
                print("STATUS: \(response.response?.statusCode ?? 0)")
                
            switch response.result {
            case .success(let value):
                print("Success")
                dump(value)
                complitionHanlder(value.results)
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
        
    }
    
    
     func callMoviePosterPIRequest(movieId: Int, complitionHanlder: @escaping ([Poster]) -> ()  ) {
        
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
                complitionHanlder(value.backdrops)
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
        
    }
    
    
}
