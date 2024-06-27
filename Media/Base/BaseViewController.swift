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
        print(#function, "base")
        view.backgroundColor = .white
        setUpHierarchy()
        setUpLayout()
        setUpView()
    }
    
    func setUpHierarchy() {}
    
    func setUpLayout() {}
    
    func setUpView() {
        print(#function, "base_setUpView")
//        view.backgroundColor = .white
    }
}
