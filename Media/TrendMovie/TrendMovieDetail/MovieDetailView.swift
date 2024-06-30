//
//  MovieDetailView.swift
//  Media
//
//  Created by 김윤우 on 6/30/24.
//

import UIKit

class MovieDetailView: BaseView {
    
    let moviewImage = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 5
        return view
    }()
    let overViewTitleLabel = {
        let view = UILabel()
        view.text = "OverView"
        view.primarySubTitleLabel(fontSize: 16)
        return view
    }()
    let overViewTopSeparator = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
        
    }()
    let overViewLabel = {
        let view = UILabel()
        view.numberOfLines = 2
        return view
    }()
    let underChevron = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        view.tintColor = .black
        return view
    }()
    let overViewBottomSeparator = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    let castTitleLabel = {
        let view = UILabel()
        view.text = "Cast"
        view.primarySubTitleLabel(fontSize: 16)
        return view
    }()
    let castSeperator = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 80
        view.register(CastListTableViewCell.self, forCellReuseIdentifier: CastListTableViewCell.identifier)
        return view
    }()
    var movieDetail: [Cast] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    override func setUpView() {
        backgroundColor = .systemBackground
    }
    
    override func setUpHierarchy() {
        [moviewImage, overViewTitleLabel, overViewTopSeparator,  overViewLabel, underChevron, overViewBottomSeparator, castTitleLabel, castSeperator, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setUpLayout() {
        moviewImage.snp.makeConstraints {
            
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(200)
            
        }
        
        overViewTitleLabel.snp.makeConstraints {
            
            $0.top.equalTo(moviewImage.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(100)
            $0.height.equalTo(28)
        }
        
        overViewTopSeparator.snp.makeConstraints {
            
            $0.top.equalTo(overViewTitleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(1)
        }
        
        overViewLabel.snp.makeConstraints {
            
            $0.top.equalTo(overViewTopSeparator.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(60)
            
        }
        
        underChevron.snp.makeConstraints {
            
            $0.top.equalTo(overViewLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(overViewLabel)
            $0.size.equalTo(36)
            
        }
        
        overViewBottomSeparator.snp.makeConstraints {
            
            $0.top.equalTo(underChevron.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(1)
        }
        
        castTitleLabel.snp.makeConstraints {
            
            $0.top.equalTo(overViewBottomSeparator.snp.bottom).offset(20)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(60)
            $0.height.equalTo(28)
            
        }
        
        castSeperator.snp.makeConstraints {
            
            $0.top.equalTo(castTitleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(1)
            
        }
        
        tableView.snp.makeConstraints {
            
            $0.top.equalTo(castSeperator.snp.bottom).offset(4)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            
        }
    }
}
