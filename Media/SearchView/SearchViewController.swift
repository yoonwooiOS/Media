//
//  SearchViewController.swift
//  Media
//
//  Created by 김윤우 on 6/11/24.
//

import UIKit
import SnapKit
import Alamofire

class SearchViewController: UIViewController {
    
    
    let searchBar = UISearchBar()
    
    let colletciontView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    var list = SearchMovie(page: 0, results: [], total_pages: 0, total_results: 0) {
        
        didSet {
            
            colletciontView.reloadData()
            
        }
        
    }
    
    var page = 1
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        let height = UIScreen.main.bounds.height - 24
        // cell 크기
        layout.itemSize = CGSize(width: width / 3, height:  height / 5 )
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colletciontView.dataSource = self
        colletciontView.delegate = self
        colletciontView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        colletciontView.prefetchDataSource = self
        searchBar.delegate = self
        setUpHriearchy()
        setUpLayout()
        setUpUI()
        
    }
    
    func setUpHriearchy() {
        
        view.addSubview(searchBar)
        view.addSubview(colletciontView)
        
    }
    
    // escaping closure
    func setUpLayout() {
        searchBar.snp.makeConstraints {
            
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        colletciontView.snp.makeConstraints {
            
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
        
    }
    
    func setUpUI() {
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "영화 검색"
    }
    
    
    func callRequest(query: String) {
        print("텅신")
        let url = APIURL.tmdb_Search + "?query=\(query)&page=\(page)"
        let header: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization" : APIKey.tmdbKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: SearchMovie.self) { response in
                
                print("STATUS: \(response.response?.statusCode ?? 0)")
                
                switch response.result {
                case .success(let value):
                    print("Success")
                    dump(value)
                    
                    if self.page == 1 {
                        self.list = value
                    } else {
                        self.list.results.append(contentsOf: value.results)
                    }
                   
                    if self.page == 1{
                        
                        self.colletciontView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                        
                    }
                    
                case .failure(let error):
                    print("Failed")
                    print(error)
                }
            }
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        let data = list.results[indexPath.row]
        cell.setUpCell(data: data)
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = SearchResultDetailViewController2()
        vc.movieInfo = list.results[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function)
        for item in indexPaths {
            print(page, list.total_pages)
            if list.results.count - 2 == item.row &&  page != list.total_pages  {
                page += 1
                
                callRequest(query: searchBar.text!)
                collectionView.reloadData()
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let searchText = searchBar.text else { return }
        
        page = 1
        callRequest(query: searchText)
    }
}


