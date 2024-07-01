//
//  SearchViewController.swift
//  Media
//
//  Created by 김윤우 on 6/11/24.
//

import UIKit
import SnapKit
import Alamofire

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
   
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        mainView.collectionView.prefetchDataSource = self
        mainView.searchBar.delegate = self
        setUpNavigationItem()
    }
    
    func setUpNavigationItem() {
    
        navigationItem.title = "영화 검색"
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainView.list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        let data = mainView.list.results[indexPath.row]
        cell.setUpCell(data: data)
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = SearchResultDetailViewController()
        vc.movieInfo = mainView.list.results[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function)
        for item in indexPaths {
//            print(page, list.total_pages)
            if mainView.list.results.count - 2 == item.row &&  mainView.page != mainView.list.total_pages  {
                mainView.page += 1
                guard let searchText = mainView.searchBar.text else { return }
                NetworkManager.shared.requestMovie(api: .search(query: searchText), model: SearchMovie.self) { value, error in
                    if let error = error {
                        print(error, "error")
                    } else if value != nil {
                        print("Success")
                        dump(value)
                        guard let value = value else { return }
                        
                        if self.mainView.page == 1 {
                
                            self.mainView.list = value
                        } else {
                            self.mainView.list.results.append(contentsOf: value.results)
                        }
                        if self.mainView.page == 1{
                            self.mainView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                        }
                    }
                }
                
                
                collectionView.reloadData()
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        mainView.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        mainView.searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        
        mainView.page = 1
//        callRequest(query: searchText)
        NetworkManager.shared.requestMovie(api: .search(query: searchText), model: SearchMovie.self) { value, error in
            if let error = error {
                print(error, "error")
            } else if value != nil {
                print("Success")
                dump(value)
                guard let value = value else { return }
                
                if self.mainView.page == 1 {
        
                    self.mainView.list = value
                } else {
                    self.mainView.list.results.append(contentsOf: value.results)
                }
                if self.mainView.page == 1{
                    self.mainView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                }
            }
        }
    }
}


