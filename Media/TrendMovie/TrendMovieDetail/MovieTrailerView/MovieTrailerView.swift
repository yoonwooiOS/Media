//
//  MovieTrailerView.swift
//  Media
//
//  Created by 김윤우 on 7/1/24.
//

import UIKit
import WebKit
import SnapKit

final class MovieTrailerView: BaseView {
     let webView = {
        let view = WKWebView(frame: .zero)
        return view
        
    }()
    
    override func setUpHierarchy() {
        addSubview(webView)
    }
    override func setUpLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
}


