//
//  BaseTableViewCell.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpHierarchy()
        setUpLayout()
        setUpView()
    }
    func setUpHierarchy() {}
    
    func setUpLayout() {}
    
    func setUpView() {
        backgroundColor = .white
    }

    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
