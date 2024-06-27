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
    
    typealias RelativeMovieComplitionHandler = ([MoviePosterImage]?, String?) -> Void
    func tmdbRelativeMovieAPI(api: TMDBAPI, RelativeMovieComplitionHandler: @escaping RelativeMovieComplitionHandler  ) {
        
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header)
           .validate(statusCode: 200..<500)
           .responseDecodable(of: SRMovie.self) { response in
               
               print("STATUS: \(response.response?.statusCode ?? 0)")
               
           switch response.result {
           case .success(let value):
               print("Success")
//                dump(value)
               RelativeMovieComplitionHandler(value.results, nil)
           case .failure(let error):
               print("Failed")
               print(error)
               RelativeMovieComplitionHandler(nil, "잠시후 다시 시도해주세요")
           }
       }
       
   }
    
    typealias PosterComplitionHandler = ([Poster]?, String?) -> Void
    func tmdbMoviePosterAPI(api: TMDBAPI, PosterComplitionHandler: @escaping PosterComplitionHandler  ) {
        
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header)
           .validate(statusCode: 200..<500)
           .responseDecodable(of: MoviePoster.self) { response in
               
               print("STATUS: \(response.response?.statusCode ?? 0)")
               
           switch response.result {
           case .success(let value):
               print("Success")
    //                dump(value)
               PosterComplitionHandler(value.backdrops, nil)
           case .failure(let error):
               print("Failed")
               print(error)
               PosterComplitionHandler(nil, "잠시후 다시 시도해주세요")
           }
       }
       
    }
    
    func trendingMovie() {
        
        
        
        
        
    }
    
    
}


