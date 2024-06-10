//
//  MovieInfoTableViewCell.swift
//  Media
//
//  Created by 김윤우 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

class MovieInfoTableViewCell: UITableViewCell {
    
    static let identifier = "MovieInfoTableViewCell"
    
    let releaseDateLabel = UILabel()
    let genreLabel = UILabel()
    let layoutView = UIView()
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
        
        setUphrierachy()
        setUpLayout()
        setUpUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUphrierachy() {
        
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(layoutView)
        contentView.addSubview(movieImage)
        movieImage.addSubview(gradeStringLabel)
        movieImage.addSubview(gradeNumberLable)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieInfoLable)
        contentView.addSubview(contourImage)
        contentView.addSubview(gotodetailViewLabel)
        contentView.addSubview(chevronimage)
        
    }
    
    func setUpLayout() {
        releaseDateLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).offset(32)
            $0.height.equalTo(20)
            $0.width.equalTo(80)
        }
        genreLabel.snp.makeConstraints {
            
            $0.top.equalTo(releaseDateLabel.snp.bottom).offset(8)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).offset(32)
            $0.height.equalTo(30)
            $0.width.equalTo(80)
        }
        layoutView.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(32)
            $0.bottom.equalTo(contentView.snp.bottom).inset(60)
        }
        movieImage.snp.makeConstraints {
            $0.top.equalTo(layoutView.snp.top)
            $0.horizontalEdges.equalTo(layoutView.safeAreaLayoutGuide)
            
            $0.width.equalTo(layoutView)
            $0.height.equalTo(180)
        }
        gradeStringLabel.snp.makeConstraints {
            $0.leading.equalTo(movieImage.snp.leading).offset(8)
            $0.bottom.equalTo(movieImage.snp.bottom).inset(8)
            $0.width.equalTo(30)
            $0.height.equalTo(20)
            
        }
        gradeNumberLable.snp.makeConstraints {
            $0.leading.equalTo(gradeStringLabel.snp.trailing)
            $0.bottom.equalTo(movieImage.snp.bottom).inset(8)
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
            $0.width.equalTo(60)
            $0.height.equalTo(20)
            
        }
        
        chevronimage.snp.makeConstraints {
            
            $0.top.equalTo(contourImage).offset(8)
            $0.trailing.equalTo(layoutView.safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(60)
            $0.height.equalTo(20)
            
        }
        
    }
    
    func setUpUI() {
        
    }
    
    func setUpCell(data:result ) {
        
        let url = URL(string: APIKey.imageURL + data.poster_path)
        
        releaseDateLabel.text = data.release_date
        movieImage.kf.setImage(with: url)
        movieTitleLabel.text = data.title
        movieInfoLable.text = data.overview
        
    }
}

