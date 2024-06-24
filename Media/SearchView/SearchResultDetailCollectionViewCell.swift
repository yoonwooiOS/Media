//
//  SearchResultDetailCollectionViewCell.swift
//  Media
//
//  Created by 김윤우 on 6/24/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchResultDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchResultDetailCollectionViewCell"
    
    let movieImage: UIImageView = {
        let image = UIImageView()
        let url = URL(string: "")
        image.kf.setImage(with: url)
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(movieImage)
        
        movieImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        movieImage.backgroundColor = .cyan
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
