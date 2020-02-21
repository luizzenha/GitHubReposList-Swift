//
//  LoadingFooterViewCell.swift
//  GitHubReposList
//
//  Created by Luiz Zenha on 18/02/20.
//  Copyright © 2020 Zenha. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewCell: UITableViewCell {

    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.style = .large
        loader.color = Const.contrastColor
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.tintColor = Const.contrastColor
        
        return loader
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(loader)
        loader.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView(){
        loader.startAnimating()
    }
    
}
