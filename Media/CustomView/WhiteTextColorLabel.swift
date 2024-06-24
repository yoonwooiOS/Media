//
//  WhiteTextColorLabel.swift
//  Media
//
//  Created by 김윤우 on 6/24/24.
//

import UIKit

class WhiteTextColorLabel: UILabel {
    
    
    init(text: String) {
        super.init(frame: .zero)
        
      
        self.text = text
        self.textColor = .white
        self.font = .boldSystemFont(ofSize: 14)
        self.backgroundColor = .none
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
