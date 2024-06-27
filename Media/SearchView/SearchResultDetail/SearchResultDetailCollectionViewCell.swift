//
//  SearchResultDetailCollectionViewCell.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import UIKit

class SearchResultDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchResultDetailCollectionViewCell2"
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        posterImageView.backgroundColor = .white
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}