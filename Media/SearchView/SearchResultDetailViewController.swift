//
//  SearchResultDetailViewController.swift
//  Media
//
//  Created by 김윤우 on 6/24/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchResultDetailViewController: UIViewController {
    
    let searchResultMovieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    let similarMovieLabel = WhiteTextColorLabel(text: "비슷한 영화")
    let recommandLabel = WhiteTextColorLabel(text: "추천 영화")
    let posterLabel = WhiteTextColorLabel(text: "포스터")
    let similarMovieColletionView = UICollectionView(frame: .zero, collectionViewLayout: SearchResultDetailViewController.collectionViewLayout())
    let recommandColletionView = UICollectionView(frame: .zero, collectionViewLayout: SearchResultDetailViewController.collectionViewLayout())
    let posterColletionView = UICollectionView(frame: .zero, collectionViewLayout: SearchResultDetailViewController.collectionViewLayout())
    
    var similarMovieList: SimiarMovie = SimiarMovie(page: 0, results: []) {
        didSet {
            similarMovieColletionView.reloadData()
        }
    }
    
    var recommandMovieList:  RecommandMovie = RecommandMovie(page: 0, results: []) {
        didSet {
            recommandColletionView.reloadData()
        }
    }
    var movieInfo: Result?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpHierarchy()
        setUpLayout()
        setUPColletcionView()
        
        callSimiarMovieAPIRequest()
        callRecommandMovieAPIRequest()
    }
    private func setUpHierarchy() {
        view.addSubview(searchResultMovieTitleLabel)
        view.addSubview(similarMovieLabel)
        view.addSubview(recommandLabel)
        view.addSubview(posterLabel)
        view.addSubview(similarMovieColletionView)
        view.addSubview(recommandColletionView)
        view.addSubview(posterColletionView)
    }
    
    private func setUpLayout() {
        
        searchResultMovieTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
        similarMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(searchResultMovieTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(30)
        }
        
        similarMovieColletionView.snp.makeConstraints { make in
            make.top.equalTo(similarMovieLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(150)
        }
        
        recommandLabel.snp.makeConstraints { make in
            make.top.equalTo(similarMovieColletionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(30)
        }
        
        recommandColletionView.snp.makeConstraints { make in
            make.top.equalTo(recommandLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(150)
        }
        
        posterLabel.snp.makeConstraints { make in
            make.top.equalTo(recommandColletionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(30)
        }
        
        posterColletionView.snp.makeConstraints { make in
            make.top.equalTo(posterLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(150)
        }
        
       
        
    }
    
    func setUPColletcionView() {
        similarMovieColletionView.delegate = self
        similarMovieColletionView.dataSource = self
        similarMovieColletionView.register(SearchResultDetailCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultDetailCollectionViewCell.identifier)
        
        recommandColletionView.delegate = self
        recommandColletionView.dataSource = self
        recommandColletionView.register(SearchResultDetailCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultDetailCollectionViewCell.identifier)
        
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        let height = UIScreen.main.bounds.height - 24
        // cell 크기
        layout.itemSize = CGSize(width: width / 3.3 , height:  height / 5 )
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
        
        
    }
    
    func callSimiarMovieAPIRequest() {
        print( movieInfo?.id,"callreq")
        guard let id = movieInfo?.id else { return }
        print(id,"gaurldnet")
        NetworkManager.callSimilarMovieAPIRequest(movieId: id) { value in
            self.similarMovieList = value
            self.searchResultMovieTitleLabel.text = self.movieInfo?.title
        }
    }
    
    func callRecommandMovieAPIRequest() {
        
        guard let id = movieInfo?.id else { return }
        NetworkManager.callRecommandMovieAPIRequest(movieId: id) { value in
            self.recommandMovieList = value
            self.searchResultMovieTitleLabel.text = self.movieInfo?.title
        }
        
        
    }
}


extension SearchResultDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == similarMovieColletionView {
            return similarMovieList.results.count
        } else if collectionView == recommandColletionView {
            return recommandMovieList.results.count
        } else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultDetailCollectionViewCell.identifier, for: indexPath) as! SearchResultDetailCollectionViewCell
                
                if collectionView == similarMovieColletionView {
                    let movie = similarMovieList.results[indexPath.row]
                    let imageUrl = APIKey.imageURL + movie.poster_path
                    cell.setUpSimilarCell(imageString: imageUrl)
                } else if collectionView == recommandColletionView {
                    let movie = recommandMovieList.results[indexPath.row]
                    let imageUrl = APIKey.imageURL + movie.poster_path
                    cell.setUpRecommandCell(imageString: imageUrl)
                }
                
                return cell
    }
}
