//
//  CollectionVewResource.swift
//  Media
//
//  Created by 김윤우 on 6/25/24.
//

import UIKit

enum CollectionVewResource {
    
    enum SearchDetailCollectionViewLayout: Int {
        
        case itemWidth = 120
        case itemHeight = 160
        static let minimumLineSpacing: CGFloat  = 10
        static let minimumInteritemSpacing: CGFloat = 0
        static let insetTop: CGFloat = 0
        static let insetLeft: CGFloat = 20
        static let insetBottom: CGFloat = 0
        static let insetRight: CGFloat = 0
        static let scrollDirection:  UICollectionView.ScrollDirection = .horizontal
    }
    
    // 파라미터 초기값 사용 
    static func layout(itemWidth width: Int = 120,
                       itemHeight hight: Int = 160,
                       minimumLineSpacing: CGFloat = 10,
                       minimumInteritemSpacing: CGFloat = 0,
                       sectionInetTop top: CGFloat = 0,
                       sectionInetLeft left: CGFloat = 20,
                       sectionInetBottom bottom: CGFloat = 0,
                       sectionInetRight right: CGFloat = 0) -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: hight)
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        layout.scrollDirection = .horizontal
        return layout
        
    }
    
}
