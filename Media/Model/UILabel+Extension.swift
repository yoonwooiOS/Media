//
//  UILabel+Extension.swift
//  Media
//
//  Created by 김윤우 on 6/11/24.
//

import UIKit

extension UILabel {
    
    func primarySubtitleLabel(text: String, textColor: UIColor, fontSize size: CGFloat, textAlignment: NSTextAlignment, backgroundColor bgColor: UIColor) {
        
        self.text = text
        self.textColor = textColor
        self.font = .systemFont(ofSize: size)
        self.textAlignment = textAlignment
        self.numberOfLines = 0
        self.backgroundColor = bgColor
    }
    
    func primaryTitleLabel(text: String, textColor: UIColor, fontSize size: CGFloat, textAlignment: NSTextAlignment, backgroundColor bgColor: UIColor) {
       
        self.text = text
        self.textColor = textColor
        self.font = .boldSystemFont(ofSize: size)
        self.textAlignment = textAlignment
        self.numberOfLines = 0
        self.backgroundColor = bgColor
    }
    
}
