//
//  ReuseIdentifierProtocol.swift
//  Media
//
//  Created by 김윤우 on 6/30/24.
//

import Foundation

extension NSObjectProtocol {
    static var identifier: String {
            return String(describing: self)
        }
}
