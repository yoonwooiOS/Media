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
    
    var movieData: result?
    
    var movieDetail: [Cast] = [] {
        
        didSet {
            
            tableView.reloadData()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequestCast()
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
            $0.height.equalTo(200)
            
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
            
            $0.top.equalTo(overViewBottomSeparator.snp.bottom).offset(20)
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
        guard let detailData = movieData else { return }

        navigationItem.title = "출연/제작"
        
        view.backgroundColor = .systemBackground
        
        let url = URL(string:  APIKey.imageURL + detailData.poster_path)
        moviewImage.kf.setImage(with: url)
        moviewImage.contentMode = .scaleToFill
        moviewImage.layer.cornerRadius = 5
        
        overViewTitleLabel.text = "OverView"
        overViewTitleLabel.primarySubTitleLabel(fontSize: 16)
        overViewLabel.text = detailData.overview
        underChevron.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        underChevron.tintColor = .black
    
        castTitleLabel.text = "Cast"
        castTitleLabel.primarySubTitleLabel(fontSize: 16)
        
        overViewTopSeparator.backgroundColor = .systemGray4
        overViewLabel.numberOfLines = 2
        
        overViewBottomSeparator.backgroundColor = .systemGray4
       
        castSeperator.backgroundColor = .systemGray4
        tableView.backgroundColor = .green
    }
    
    func setUpTableView() {
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CastListTableViewCell.self, forCellReuseIdentifier: CastListTableViewCell.identifier)
        
    }
    
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastListTableViewCell.identifier, for: indexPath) as! CastListTableViewCell
        let cast = movieDetail[indexPath.row]
        
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
                self.movieDetail = cast
            }
        }
        
        
        

        
//        let url = "https://api.themoviedb.org/3/movie/\(detailData.id)/credits"
//        let header: HTTPHeaders = [
//            "accept" : "application/json",
//            "Authorization" : APIKey.tmdbKey
//        ]
//        
//        AF.request(url, method: .get, headers: header)
//            .validate(statusCode: 200..<500)
//            .responseDecodable(of: MovieDetail.self) { response in
//                
//                print("STATUS: \(response.response?.statusCode ?? 0)")
//                
//                switch response.result {
//                case .success(let value):
//                    print("Success")
////                    dump(value)
//                    self.movieDetail = value.cast
////                    print(self.movieDetail)
//                case .failure(let error):
//                    print("Failed")
//                    print(error)
//                }
//            }
        
        
        
        
    }
}


extension UILabel {
    
    func primarySubTitleLabel(fontSize: CGFloat) {
        
        self.textColor = .systemGray
        self.font = .boldSystemFont(ofSize: fontSize)
        
    }
    
    
}
