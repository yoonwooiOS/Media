//
//  BaseView.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpHierarchy()
        setUpLayout()
        setUpView()
    }
    func setUpHierarchy() {}
    func setUpLayout() { }
    func setUpView() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
