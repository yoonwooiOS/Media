//
//  SearchResultDetailViewController2.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import UIKit
import SnapKit
import Alamofire

class SearchResultDetailViewController: BaseViewController {
    
    let mainView = SearchResultDetailView()
    var movieInfo: Result?
    var movieImageList:[[MoviePosterImage]] = [
        [MoviePosterImage](),
        [MoviePosterImage](),
        [MoviePosterImage]()
    ]
    
    let sectionNmae = ["비슷한 영화", "추천 영화", "포스터"]
    
    var moviePoster: [Poster] = []
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movieInfo = movieInfo else { return }
        print(movieInfo.id)
        callRequesetAPI()
    }
    
    override func setUpView() {
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
        cell.titleLabel.text = sectionNmae[indexPath.row]
        
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
        let urlString = URL(string: "https://image.tmdb.org/t/p/w500\(data.posterImage))" )
        cell.posterImageView.kf.setImage(with: urlString)
       
        return cell
    }
}

extension SearchResultDetailViewController {
    func callRequesetAPI() {
        
        guard let movieInfo = movieInfo else { return  }
        
        let group = DispatchGroup()
       
        group.enter()
        NetworkManager.shared.requestMovie(api: .similarMovie(query: movieInfo.id), model: SimiarRecommandMovie.self) { movieImage, error in
            
//            defer{
//                group.leave()
//            }
            if let error = error {
                print(error)
                print(self.movieImageList[0],"==================")
            } else if let movie = movieImage?.results {
                
                self.movieImageList[0] = movie
            }
            group.leave()
        }
        group.enter() 
        NetworkManager.shared.requestMovie(api: .recommandMovie(query: movieInfo.id), model: SimiarRecommandMovie.self) { movieImage, error in
            if let error = error {
                print(error)
            } else if let movie = movieImage?.results {
                self.movieImageList[1] = movie
                print(self.movieImageList[1])
            }
            group.leave()
        }
       
        group.enter()
        NetworkManager.shared.requestMovie(api: .moviePoster(query: movieInfo.id), model: MoviePoster.self) { posterImage, error in
            if let error = error {
                print(error)
            
            } else if let movie = posterImage?.backdrops {
                self.movieImageList[2] = movie
                
                print(movie, "backdrops")
            }
            group.leave()
            
        }
        group.notify(queue: .main) {
            print("End")
            self.mainView.tableView.reloadData()
        }
    }
    
}
