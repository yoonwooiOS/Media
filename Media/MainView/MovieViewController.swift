//
//  MovieViewController.swift
//  Media
//
//  Created by 김윤우 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire

class MovieViewController: UIViewController {
    
    let tableView = UITableView()
    var movieList:[result] = [] {
    
        didSet {
            
            tableView.reloadData()
            
        }
        
    }
    
    var moiveGenreList:[Genres] = [] {
        didSet {
            tableView.reloadData()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        setUphriearchy()
        setUpLayout()
        setUpUI()
        callRequestMovie()
        
    }
    
    func setUphriearchy() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieInfoTableViewCell.self, forCellReuseIdentifier: MovieInfoTableViewCell.identifier)
        tableView.rowHeight = 480
    }
    
   
    
    func setUpLayout() {
       
        tableView.snp.makeConstraints {
            
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setUpUI() {
        
        navigationItem.backBarButtonItem?.tintColor = .black
        let blackBackButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        blackBackButton.tintColor = .black
        navigationItem.backBarButtonItem = blackBackButton
        
        view.backgroundColor = .white
        navigationItem.title = "Daily Movie"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked))
        
    }
    
    func callRequestMovie() {
        let group = DispatchGroup()
        
//        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.requestMovie(api: .trendingMovie, model: Movie.self) { value, error in
                if let error {
                    print(error, "트렌드 무비 통신에러")
                } else {
                    guard let movie = value?.results else { return }
                    self.movieList = movie
                    print(movie,"dsfadsadasdsadas")
                }
//                group.leave()
            }
        }
        
//        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.requestMovie(api: .genres, model: Genre.self) { value, error in
                if let error {
                    print(error,"장르 통신 에러")
                } else {
                    guard let genres = value?.genres else { return }
                    self.moiveGenreList = genres
                    print(genres, "12312312321321321312312321321312")
                }
//                group.leave()
                
            }
            group.notify(queue: .main) {
                print("notify")
                self.tableView.reloadData()
            }
        }
    }
   
    @objc func listButtonClicked() {
        
        
    }
    
    @objc func searchButtonClicked() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier, for: indexPath) as! MovieInfoTableViewCell
        let data = movieList[indexPath.row]
        cell.setUpCell(data: data)
        
        
        guard let firstGenreID = data.genre_ids.first else {
            cell.genreLabel.text = "장르 없음"
            return cell
        }

        if let genre = moiveGenreList.first(where: { $0.id == firstGenreID }) {
            cell.genreLabel.text = "#" + genre.name
        } else {
            cell.genreLabel.text = "장르 없음"
        }
        cell.genreLabel.font = .boldSystemFont(ofSize: 18)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = MovieDetailViewController()
        vc.movieData = movieList[indexPath.row]
        navigationController?.pushViewController(vc, animated: false)

    }
}

