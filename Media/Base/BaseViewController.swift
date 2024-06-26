//
//  BaseViewController.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpHierarchy()
        setUpLayout()
        setUpView()
    }
    
    func setUpHierarchy() {}
    
    func setUpLayout() {}
    
    func setUpView() {
//        view.backgroundColor = .white
    }
}
