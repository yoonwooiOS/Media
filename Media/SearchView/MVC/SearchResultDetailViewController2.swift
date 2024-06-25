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
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func setUpView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.searchResultMovieTitleLabel.text = movieInfo?.title
    }
}



extension SearchResultDetailViewController2: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: SearchResultDetailTableViewCell.identifier, for: indexPath) as! SearchResultDetailTableViewCell
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(SearchResultDetailCollectionViewCell2.self, forCellWithReuseIdentifier: SearchResultDetailCollectionViewCell2.identifier)
       
        return cell
    }
}

extension SearchResultDetailViewController2: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultDetailCollectionViewCell2.identifier, for: indexPath) as! SearchResultDetailCollectionViewCell2
        
       
        return cell
    }
    
    
    
    
    
}
