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

    let moviewImage = UIImageView()
    let overViewTitleLabel = UILabel()
    let overViewTopSeparator = UIView()
    let overViewLabel = UILabel()
    let underChevron = UIButton()
    let overViewBottomSeparator = UIView()
    let castTitleLabel = UILabel()
    let castSeperator = UIView()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUphrierachy()
        setUpLayout()
        setUpUi()
    }
    
    func setUphrierachy() {
        
        view.addSubview(moviewImage)
        view.addSubview(overViewTitleLabel)
        view.addSubview(overViewTopSeparator)
        view.addSubview(overViewLabel)
        view.addSubview(underChevron)
        view.addSubview(overViewBottomSeparator)
        view.addSubview(castTitleLabel)
        view.addSubview(castSeperator)
        view.addSubview(tableView)
        
    }
    
    func setUpLayout() {
        
        moviewImage.snp.makeConstraints {
            
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(180)
            
        }
        
        overViewTitleLabel.snp.makeConstraints {
            
            $0.top.equalTo(moviewImage.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(100)
            $0.height.equalTo(28)
        }
        
        overViewTopSeparator.snp.makeConstraints {
            
            $0.top.equalTo(overViewTitleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(1)
        }
        
        overViewLabel.snp.makeConstraints {
            
            $0.top.equalTo(overViewTopSeparator.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(60)
            
        }
        
        underChevron.snp.makeConstraints {
            
            $0.top.equalTo(overViewLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(overViewLabel)
            $0.size.equalTo(36)
            
        }
        
        overViewBottomSeparator.snp.makeConstraints {
            
            $0.top.equalTo(underChevron.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(1)
        }
        
        castTitleLabel.snp.makeConstraints {
            
            $0.top.equalTo(overViewBottomSeparator.snp.bottom).offset(32)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(60)
            $0.height.equalTo(28)
            
        }
        
        castSeperator.snp.makeConstraints {
            
            $0.top.equalTo(castTitleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(1)
            
        }
        
        tableView.snp.makeConstraints {
            
            $0.top.equalTo(castSeperator.snp.bottom).offset(4)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
    
    func setUpUi() {
        navigationItem.title = "출연/제작"
        view.backgroundColor = .systemBackground
        moviewImage.backgroundColor = .blue
        overViewTitleLabel.backgroundColor = .gray
        overViewTopSeparator.backgroundColor = .systemGray4
        overViewLabel.backgroundColor = .cyan
        underChevron.backgroundColor = .brown
        overViewBottomSeparator.backgroundColor = .systemGray4
        castTitleLabel.backgroundColor = .gray
        castSeperator.backgroundColor = .systemGray4
        tableView.backgroundColor = .green
    }
    
    func setUpTableView() {
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CastListTableViewCell.self, forCellReuseIdentifier: CastListTableViewCell.identifier)
        
    }
    
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastListTableViewCell.identifier, for: indexPath) as! CastListTableViewCell
        
        return cell
    }
    
    
    
    
    
    
}


extension MovieDetailViewController {
    
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
                    
                    
                case .failure(let error):
                    print("Failed")
                    print(error)
                }
            }
        
        
        
        
    }
}


