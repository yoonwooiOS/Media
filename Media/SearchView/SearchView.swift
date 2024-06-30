//
//  SearchView.swift
//  Media
//
//  Created by 김윤우 on 6/30/24.
//

import UIKit

class SearchView: BaseView {
    let searchBar = UISearchBar()
    
    let collectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: SearchView.collectionViewLayout()
        )
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        return view
        
    }()
    
    var list = SearchMovie(page: 0, results: [], total_pages: 0, total_results: 0) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var page = 1
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
            
            let layout = UICollectionViewFlowLayout()
        let width = CollectionVewResource.SearchCollectionViewLayout.itemWidth
        let height = CollectionVewResource.SearchCollectionViewLayout.itemHeight
            // cell 크기
            layout.itemSize = CGSize(width: width / 3, height:  height / 5 )
            layout.scrollDirection = .vertical
        layout.minimumLineSpacing = CollectionVewResource.SearchCollectionViewLayout.minimumInteritemSpacing
        layout.minimumInteritemSpacing = CollectionVewResource.SearchCollectionViewLayout.minimumInteritemSpacing
            layout.sectionInset = UIEdgeInsets(
                top: CollectionVewResource.SearchCollectionViewLayout.insetTop,
                left: CollectionVewResource.SearchCollectionViewLayout.insetLeft,
                bottom: CollectionVewResource.SearchCollectionViewLayout.insetBottom,
                right: CollectionVewResource.SearchCollectionViewLayout.insetRight)
            return layout
        }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizer()
    }
    override func setUpHierarchy() {
       addSubview(searchBar)
       addSubview(collectionView)
    }
    
    override func setUpLayout() {
        searchBar.snp.makeConstraints {
            
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            
        }
        
        collectionView.snp.makeConstraints {
            
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            
        }
    }
    override func setUpView() {
        backgroundColor = .white
    }
    func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
            tapGesture.cancelsTouchesInView = false // 다른 터치 이벤트가 그대로 동작
            addGestureRecognizer(tapGesture)
        }
    
    @objc func viewTapped() {
            endEditing(true)
        }
}
