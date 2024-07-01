//
//  CastListTableViewCell.swift
//  Media
//
//  Created by 김윤우 on 6/12/24.
//

import UIKit
import SnapKit
import Kingfisher

class CastListTableViewCell: BaseTableViewCell {
    
    static let identifier = "CastListTableViewCell"
    
    let castImage = {
        let view = UIImageView()
        return view
    }()
    var castName = {
        let view = UILabel()
        view.primaryTitleLabel(fontSize: 20)
        return view
    }()
    let roleName = {
        let view = UILabel()
        view.primarySubtitleLabel(fontSize: 14)
        return view
    }()
    
    override func setUpHierarchy() {
        contentView.addSubview(castImage)
        contentView.addSubview(castName)
        contentView.addSubview(roleName)
    }
   
    override func setUpLayout() {
        
        castImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.leading.equalToSuperview().offset(8)
            $0.width.equalTo(contentView.snp.height).multipliedBy(12.0 / 17.0)
        }
        
        castName.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            $0.leading.equalTo(castImage.snp.trailing).offset(16)
            $0.width.equalTo(200)
            $0.height.equalTo(24)
        }
        
        roleName.snp.makeConstraints {
            $0.top.equalTo(castName.snp.bottom)
            $0.leading.equalTo(castImage.snp.trailing).offset(16)
            $0.width.equalTo(200)
            $0.height.equalTo(20)
        }
        
    }
    
    override func setUpView() {
        
        
    }
    
    func setUpCell(data: Cast) {
        guard let image = data.profile_path else { return }
        
        self.castName.text = data.original_name
        
        let url = URL(string:  APIKey.imageURL + image)
        self.castImage.kf.setImage(with:  url)
        self.castImage.layer.cornerRadius = 7
        self.castImage.clipsToBounds = true
        self.roleName.text = data.character
    }
}

extension UILabel {
    
    func primaryTitleLabel(fontSize: CGFloat) {
        self.font = .boldSystemFont(ofSize: fontSize )
        self.textAlignment = .left
    }
    
    func primarySubtitleLabel(fontSize: CGFloat) {
        
        self.font = .systemFont(ofSize: fontSize )
        self.textColor = .systemGray3
        self.textAlignment = .left
    }
}
