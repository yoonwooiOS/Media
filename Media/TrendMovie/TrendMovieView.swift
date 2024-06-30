//
//  TrendMovieView.swift
//  Media
//
//  Created by 김윤우 on 6/30/24.
//

import UIKit
import SnapKit

class TrendMovieView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView()
        view.register(MovieInfoTableViewCell.self, forCellReuseIdentifier: MovieInfoTableViewCell.identifier)
        view.rowHeight = 480
        
        return view
    }()
    
    override func setUpHierarchy() {
        addSubview(tableView)
        
    }
    
    override func setUpLayout() {
        tableView.snp.makeConstraints {
            
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func setUpView() {
        backgroundColor = .white
    }
    
}
