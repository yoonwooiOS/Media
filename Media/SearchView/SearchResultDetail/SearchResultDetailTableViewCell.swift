//
//  SearchResultDetailTableViewCell.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import UIKit

class SearchResultDetailTableViewCell: BaseTableViewCell {
    static let identifier = "SearchResultDetailTableViewCell"
    
    var titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.text = ""
        view.textColor = .black
        return view
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SearchResultDetailTableViewCell.layout())
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CollectionVewResource.SearchDetailCollectionViewLayout.itemWidth.rawValue, height: CollectionVewResource.SearchDetailCollectionViewLayout.itemHeight.rawValue)
        layout.minimumLineSpacing = CGFloat(CollectionVewResource.SearchDetailCollectionViewLayout.minimumLineSpacing)
        layout.minimumInteritemSpacing = CollectionVewResource.SearchDetailCollectionViewLayout.minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(top: CollectionVewResource.SearchDetailCollectionViewLayout.insetTop, left: CollectionVewResource.SearchDetailCollectionViewLayout.insetLeft, bottom: CollectionVewResource.SearchDetailCollectionViewLayout.insetBottom, right: CollectionVewResource.SearchDetailCollectionViewLayout.insetRight
        )
        layout.scrollDirection = CollectionVewResource.SearchDetailCollectionViewLayout.scrollDirection
        return layout
    }
    
    override func setUpHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    override func setUpLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
           
        }
        collectionView.backgroundColor = .white
    }
}
