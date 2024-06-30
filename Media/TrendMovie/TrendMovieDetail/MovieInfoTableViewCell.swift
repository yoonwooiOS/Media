//
//  MovieInfoTableViewCell.swift
//  Media
//
//  Created by 김윤우 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

class MovieInfoTableViewCell: BaseTableViewCell {
    
    static let identifier = "MovieInfoTableViewCell"
    
    let releaseDateLabel = UILabel()
    let genreLabel = UILabel()
    let layoutView = UIImageView()
    let movieImage = UIImageView()
    let gradeStringLabel = UILabel()
    let gradeNumberLable = UILabel()
    let movieTitleLabel = UILabel()
    let movieInfoLable = UILabel()
    let contourImage = UIView()
    let gotodetailViewLabel = UILabel()
    let chevronimage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    override func setUpHierarchy() {
        [releaseDateLabel, genreLabel, layoutView, movieImage, movieTitleLabel, movieInfoLable, contourImage, gotodetailViewLabel, chevronimage ].forEach {
            self.addSubview($0)
        }
        movieImage.addSubview(gradeStringLabel)
        movieImage.addSubview(gradeNumberLable)
    }
   
    override func setUpLayout() {
        releaseDateLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).offset(32)
            $0.height.equalTo(10)
            $0.width.equalTo(80)
        }
        genreLabel.snp.makeConstraints {
            
            $0.top.equalTo(releaseDateLabel.snp.bottom)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).offset(32)
            $0.height.equalTo(30)
            $0.width.equalTo(120)
        }
        layoutView.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(32)
            $0.bottom.equalTo(contentView.snp.bottom).inset(40)
        }
        movieImage.snp.makeConstraints {
            $0.top.equalTo(layoutView.snp.top)
            $0.horizontalEdges.equalTo(layoutView.safeAreaLayoutGuide)
            
            $0.width.equalTo(layoutView)
            $0.height.equalTo(240)
        }
        gradeStringLabel.snp.makeConstraints {
            $0.leading.equalTo(movieImage.snp.leading).offset(16)
            $0.bottom.equalTo(movieImage.snp.bottom).inset(16)
            $0.width.equalTo(30)
            $0.height.equalTo(20)
            
        }
        gradeNumberLable.snp.makeConstraints {
            $0.leading.equalTo(gradeStringLabel.snp.trailing)
            $0.bottom.equalTo(movieImage.snp.bottom).inset(16)
            $0.width.equalTo(30)
            $0.height.equalTo(20)
            
        }
        movieTitleLabel.snp.makeConstraints {
            
            $0.top.equalTo(movieImage.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(layoutView.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(30)
            $0.width.equalTo(layoutView.safeAreaLayoutGuide).inset(8)
            
        }
        movieInfoLable.snp.makeConstraints {
            
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(layoutView.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(20)
            $0.width.equalTo(layoutView.safeAreaLayoutGuide).inset(8)
        }
        
        contourImage.snp.makeConstraints {
            $0.top.equalTo(movieInfoLable.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(layoutView.safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(layoutView.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(1)
        }
        
        gotodetailViewLabel.snp.makeConstraints {
            $0.top.equalTo(contourImage).offset(8)
            $0.leading.equalTo(layoutView.safeAreaLayoutGuide).offset(8)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
            
        }
        
        chevronimage.snp.makeConstraints {
            
            $0.top.equalTo(contourImage).offset(8)
            $0.trailing.equalTo(layoutView.safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(16)
            $0.height.equalTo(20)
            
        }
        
    }
    
    func setUpCell(data:result ) {
        
        let url = URL(string: APIKey.imageURL + data.poster_path)
        
        movieImage.primaryImageView(contentMode: .scaleToFill, cornerRadius: 4)
        layoutView.layer.shadowOffset = CGSize(width: 50, height: 50)
        layoutView.layer.shadowOpacity = 0.6
        layoutView.layer.shadowRadius = 20
        layoutView.layer.shadowColor = UIColor.gray.cgColor
        layoutView.clipsToBounds = false
        movieImage.layer.cornerRadius = 5
        movieImage.clipsToBounds = true
        releaseDateLabel.primarySubtitleLabel(text: data.release_date, textColor: .systemGray2, fontSize: 12, textAlignment: .left, backgroundColor: .clear)
        
        movieImage.kf.setImage(with: url)
        movieTitleLabel.primaryTitleLabel(text: data.title, textColor: .black, fontSize: 20, textAlignment: .left, backgroundColor: .clear)
        movieInfoLable.primarySubtitleLabel(text: data.overview, textColor: .systemGray, fontSize: 16, textAlignment: .left, backgroundColor: .clear)
        gradeStringLabel.primarySubtitleLabel(text: "평점", textColor: .white, fontSize: 12, textAlignment: .center, backgroundColor: .systemBlue)
        gradeNumberLable.primarySubtitleLabel(text: "3.3", textColor: .black, fontSize: 12, textAlignment: .center, backgroundColor: .white)
        contourImage.backgroundColor = .black
        gotodetailViewLabel.primarySubtitleLabel(text: "자세히 보기", textColor: .black, fontSize: 14, textAlignment: .left, backgroundColor: .clear)
        
        chevronimage.image = UIImage(systemName: "chevron.right")
        chevronimage.tintColor = .black
        
        
    }
}

