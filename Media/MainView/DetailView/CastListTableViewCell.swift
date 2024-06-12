//
//  CastListTableViewCell.swift
//  Media
//
//  Created by 김윤우 on 6/12/24.
//

import UIKit
import SnapKit
import Kingfisher

class CastListTableViewCell: UITableViewCell {
    
    static let identifier = "CastListTableViewCell"
    
    let castImage = UIImageView()
    let castName = UILabel()
    let roleName = UILabel()
    let roleNumber = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    
        setUphrierachy()
        setUpLayout()
        setUpUi()
        setUpCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUphrierachy() {
        
        
    }
    
    func setUpLayout() {
        
        
    }
    
    func setUpUi() {
        
        
    }
    
    func setUpCell() {
        
        
        
    }
    
    
}

#if DEBUG
import SwiftUI
struct ViewControllerRepresentable_DBVC: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
    }
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController{
        MovieDetailViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_DBVC_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable_DBVC()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
        }
        
    }
} #endif
