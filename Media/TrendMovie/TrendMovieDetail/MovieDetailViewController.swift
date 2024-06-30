//
//  MovieDetailViewController.swift
//  Media
//
//  Created by 김윤우 on 6/12/24.
//

import UIKit
import SnapKit
import Alamofire

class MovieDetailViewController: UIViewController {
    
   let mainView = MovieDetailView()
    
    var movieData: result?
    
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequestCast()
        setUpTableView()
       
        setUpUi()
        
    }
    
   
    
    func setUpUi() {
        guard let detailData = movieData else { return }

        navigationItem.title = "출연/제작"
        
        let url = URL(string:  APIKey.imageURL + detailData.poster_path)
        mainView.moviewImage.kf.setImage(with: url)
       
        mainView.overViewLabel.text = detailData.overview
       
    }
    
    func setUpTableView() {
       
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        
    }
    
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainView.movieDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastListTableViewCell.identifier, for: indexPath) as! CastListTableViewCell
        let cast = mainView.movieDetail[indexPath.row]
        
        cell.setUpCell(data: cast)
        
        
        return cell
    }
}

extension MovieDetailViewController {
    
    func callRequestCast() {
        guard let movieData = movieData else { return }
        NetworkManager.shared.requestMovie(api: .cast(query: movieData.id), model: MovieDetail.self) { value, error in
            if let error = error {
                print(error, "Cast Error")
            } else {
                guard let cast = value?.cast else { return }
                self.mainView.movieDetail = cast
            }
        }
    }
}


extension UILabel {
    
    func primarySubTitleLabel(fontSize: CGFloat) {
        
        self.textColor = .systemGray
        self.font = .boldSystemFont(ofSize: fontSize)
        
    }
    
    
}
