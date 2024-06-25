//
//  SearchResultDetailView.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import UIKit
import SnapKit

class SearchResultDetailView: BaseView {
    
    let searchResultMovieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let tableView = {
     let view = UITableView()
        view.rowHeight = 200
        view.register(SearchResultDetailTableViewCell.self, forCellReuseIdentifier: SearchResultDetailTableViewCell.identifier)
        return view
        
    }()
    
    override func setUpHierarchy() {
        
        addSubview(searchResultMovieTitleLabel)
        addSubview(tableView)
    }
    
    override func setUpLayout() {
        
        searchResultMovieTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(searchResultMovieTitleLabel.snp.bottom).offset(4)
        }
    }
    override func setUpView() {
        tableView.backgroundColor = .white
    }
}
