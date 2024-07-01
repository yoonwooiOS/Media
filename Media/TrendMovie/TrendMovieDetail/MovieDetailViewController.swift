//
//  MovieDetailViewController.swift
//  Media
//
//  Created by 김윤우 on 6/12/24.
//

import UIKit
import SnapKit
import Alamofire

class MovieDetailViewController: BaseViewController {
    
   let mainView = MovieDetailView()
    var movieData: result?
    
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequestCast()
        setUpTableView()
        setUpgesture()
        
        setUpNavigationItem()
    }
    
   
    override func setUpView() {
        guard let detailData = movieData else { return }

        navigationItem.title = "출연/제작"
        
        let url = URL(string:  APIKey.imageURL + detailData.poster_path)
        mainView.moviewImage.kf.setImage(with: url)
       
        mainView.overViewLabel.text = detailData.overview
       
    }
    func setUpgesture() {
        mainView.moviewImage.isUserInteractionEnabled = true
        mainView.moviewImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageClicked)))
    }
    func setUpTableView() {
       
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    func setUpNavigationItem() {
        navigationItem.backBarButtonItem?.tintColor = .black
        let blackBackButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        blackBackButton.tintColor = .black
        navigationItem.backBarButtonItem = blackBackButton
    }
    @objc func imageClicked() {
        print(#function)
        let vc = MovieTrailerViewController()
        guard let movieId = movieData?.id else { return }
        vc.movieID = movieId
        navigationController?.pushViewController(vc, animated: true)
        
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
