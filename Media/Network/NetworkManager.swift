//
//  NetworkManager.swift
//  Media
//
//  Created by 김윤우 on 6/24/24.
//

import UIKit
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }

    func requestMovie<T: Decodable> (api: TMDBAPI,model: T.Type, requestMovieComplitionHandler: @escaping (T?, Error?) -> Void  ) {
        
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: T.self) { response in
            
            print("STATUS: \(response.response?.statusCode ?? 0)")
            
            switch response.result {
            case .success(let value):
                print("Success")
                //  dump(value)
                requestMovieComplitionHandler(value, nil)
            case .failure(let error):
                print("Failed")
                print(error)
                requestMovieComplitionHandler(nil, error)
            }
        }
    }
}


