//
//  SearchCollectionViewCell.swift
//  Media
//
//  Created by 김윤우 on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire

class SearchCollectionViewCell: UICollectionViewCell {
    
    let movieImage = UIImageView()
    let gradeString = UILabel()
    let gradeNumber = UILabel()
    let movieTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpHriearchy()
        setUpLayout()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpHriearchy() {
        [movieImage, gradeString, gradeNumber, movieTitle].forEach {
            self.addSubview($0)
        }
    }
    
    func setUpLayout() {
        
        movieImage.snp.makeConstraints {
            
            $0.edges.equalTo(contentView.safeAreaLayoutGuide).inset(8)

        }
        
        gradeString.snp.makeConstraints {
            
            $0.bottom.equalTo(movieImage.snp.bottom).inset(16)
            $0.leading.equalTo(movieImage.safeAreaLayoutGuide).offset(4)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        gradeNumber.snp.makeConstraints {
            $0.bottom.equalTo(movieImage.snp.bottom).inset(16)
            $0.leading.equalTo(gradeString.snp.trailing)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        movieTitle.snp.makeConstraints {
            
            $0.top.equalTo(movieImage.snp.bottom).inset(2)
            $0.centerX.equalTo(movieImage)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            
        }
        
        
    }
    
   
    func setUpCell(data: Result) {
        movieImage.backgroundColor = .systemGray5
        let url = URL(string: APIKey.imageURL + (data.poster_path ?? ""))
        movieImage.kf.setImage(with: url)
        movieTitle.primarySubtitleLabel(text: data.title, textColor: .black, fontSize: 10, textAlignment: .center, backgroundColor: .clear)
    }
}
