//
//  MovieTrailerViewController.swift
//  Media
//
//  Created by 김윤우 on 7/1/24.
//

import UIKit
import WebKit

class MovieTrailerViewController: BaseViewController {
    
    let mainView = MovieTrailerView()
    var movieID: Int?
    var videoURL = "https://www.youtube.com/watch?v="
    
    
    override func loadView() {
        view = mainView
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let id = movieID else { return }
        NetworkManager.shared.requestMovie(api: .video(query: id), model: MovieTrailer.self) { value, error in
            if let error = error {
                print("error")
            } else {
                guard let key = value?.results[0].key else { return }
                print(key)
                self.videoURL += key
                print(self.videoURL)
                self.setUpWebView()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setUpWebView()
    }
    private func setUpWebView() {
        let url = URL(string: self.videoURL)
        guard let urlsString = url else { return }
        let request = URLRequest(url: urlsString)
        self.mainView.webView.load(request)
        
    }
   
}
