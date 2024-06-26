//
//  SearchResultDetailViewController2.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import UIKit
import SnapKit

class SearchResultDetailViewController2: BaseViewController {
    
    let mainView = SearchResultDetailView()
    var movieInfo: Result?
    var movieImageList:[[result]] = [
        [result](),
        [result](),
        [result]()
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
            NetworkManager.shared.callRecommandMovieAPIRequest(movieId: movieInfo.id) { value in
                self.movieImageList[0] = value
                group.leave()
            }
            
        }
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callSimilarMovieAPIRequest(movieId: movieInfo.id) { value in
                self.movieImageList[1] = value
                group.leave()
            }
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



extension SearchResultDetailViewController2: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieImageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: SearchResultDetailTableViewCell.identifier, for: indexPath) as! SearchResultDetailTableViewCell
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(SearchResultDetailCollectionViewCell2.self, forCellWithReuseIdentifier: SearchResultDetailCollectionViewCell2.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        return cell
    }
}

extension SearchResultDetailViewController2: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieImageList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultDetailCollectionViewCell2.identifier, for: indexPath) as! SearchResultDetailCollectionViewCell2
        let data = movieImageList[collectionView.tag][indexPath.item]
        let urlString = URL(string: "https://image.tmdb.org/t/p/w500\(data.poster_path))" )
        cell.posterImageView.kf.setImage(with: urlString)
        
        return cell
    }
    
    
    
    
    
}
