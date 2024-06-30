//
//  SearchResultDetailTableViewCell.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import UIKit

class SearchResultDetailTableViewCell: BaseTableViewCell {
    
    var titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.text = ""
        view.textColor = .black
        return view
    }()
   
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionVewResource.layout())
    
    override func setUpHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    override func setUpLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(20)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
           
        }
        collectionView.backgroundColor = .white
    }
    
}
