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
        callRequest()
        callRequestgenres()
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
        view.backgroundColor = .white
        navigationItem.title = "Daily Movie"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked))
        
    }
    
    func callRequest() {
    
        let url = APIURL.tmdb
        let header: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization" : APIKey.tmdbKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Movie.self) { response in
                
                print("STATUS: \(response.response?.statusCode ?? 0)")
                
            switch response.result {
            case .success(let value):
                print("Success")
                print(value)
                self.movieList = value.results
                
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
    }
    func callRequestgenres() {
    
        let url = APIURL.tmdb_genres
        let header: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization" : APIKey.tmdbKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Genre.self) { response in
                
                print("STATUS: \(response.response?.statusCode ?? 0)")
                
            switch response.result {
            case .success(let value):
                print("Success")
                print(value)
                self.moiveGenreList = value.genres
                
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
    }
    @objc func listButtonClicked() {
        
        
    }
    
    @objc func searchButtonClicked() {
        
        
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
    
    
}

