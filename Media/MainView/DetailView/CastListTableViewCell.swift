//
//  CastListTableViewCell.swift
//  Media
//
//  Created by 김윤우 on 6/12/24.
//

import UIKit
import SnapKit
import Kingfisher

class CastListTableViewCell: UITableViewCell {
    
    static let identifier = "CastListTableViewCell"
    
    let castImage = UIImageView()
    var castName = UILabel()
    let roleName = UILabel()
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUphrierachy()
        setUpLayout()
        setUpUi()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUphrierachy() {
        
        contentView.addSubview(castImage)
        contentView.addSubview(castName)
        contentView.addSubview(roleName)
       
        
    }
    
    func setUpLayout() {
        
        castImage.snp.makeConstraints {
            
            $0.verticalEdges.leading.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(68)
            $0.width.equalTo(48)
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
    
    func setUpUi() {
        castName.primaryTitleLabel(fontSize: 20)
        roleName.primarySubtitleLabel(fontSize: 14)
        
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
