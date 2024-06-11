//
//  UIImageView+Extension.swift
//  Media
//
//  Created by 김윤우 on 6/11/24.
//

import UIKit

extension UIImageView {
    
    func primaryImageView(contentMode mode: UIView.ContentMode, cornerRadius: CGFloat) {
        
        self.contentMode = mode
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
}
