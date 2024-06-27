//
//  SearchResultDetailViewController2.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import UIKit
import SnapKit

class SearchResultDetailViewController: BaseViewController {
    
    let mainView = SearchResultDetailView()
    var movieInfo: Result?
    var movieImageList:[[MoviePosterImage]] = [
        [MoviePosterImage](),
        [MoviePosterImage](),
        [MoviePosterImage]() // 코딩키 ,
    ]
    
    
    var moviePoster: [Poster] = []
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movieInfo = movieInfo else { return  }
        
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.tmdbRelativeMovieAPI(api: .similarMovie(query: movieInfo.id)) { movie, error in
                if let error = error {
                    print(error)
                } else {
                    guard let movie = movie else {
                        group.leave()
                        return }
                    self.movieImageList[0] = movie
                }
                print(Thread.isMainThread)
                print("안임")
                group.leave()
            }
            print(Thread.isMainThread)
            print("밖임")
            
        }
        group.enter()
        DispatchQueue.global().async(group: group) {
            
            NetworkManager.shared.tmdbRelativeMovieAPI(api: .recommandMovie(query: movieInfo.id)) { movie, error in
                if let error = error {
                    print(error)
                } else {
                    guard let movie = movie else { return }
                    self.movieImageList[1] = movie
                    
                }
                print(Thread.isMainThread)
                print("안임")
                group.leave()
            }
            print(Thread.isMainThread)
            print("밖임")
        }
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.tmdbMoviePosterAPI(api: .moviePoster(query: movieInfo.id)) { poster, error in
                if let error = error {
                    print(error)
                } else {
                    guard let movie = poster else { return }
                    self.movieImageList[2] = movie
                    dump(movie)
                }
                print(Thread.isMainThread)
                print("안임")
                group.leave()
            }
            print("밖")
        }
        group.notify(queue: .main) {
            self.mainView.tableView.reloadData()
        }
    }
    
    override func setUpView() {
//        view.backgroundColor = .white
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        guard let movieInfo = movieInfo else { return  }
        mainView.searchResultMovieTitleLabel.text = "\(movieInfo.title)"
    }
}



extension SearchResultDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieImageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: SearchResultDetailTableViewCell.identifier, for: indexPath) as! SearchResultDetailTableViewCell
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(SearchResultDetailCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultDetailCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        return cell
    }
}

extension SearchResultDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieImageList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultDetailCollectionViewCell.identifier, for: indexPath) as! SearchResultDetailCollectionViewCell
        let data = movieImageList[collectionView.tag][indexPath.item]
//        let posterData = poster
        let urlString = URL(string: "https://image.tmdb.org/t/p/w500\(data.posterImage))" )
        cell.posterImageView.kf.setImage(with: urlString)
        
        return cell
    }
    
    
    
    
    
}
