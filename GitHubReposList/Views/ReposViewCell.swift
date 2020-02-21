//
//  ReposViewCell.swift
//  GitHubReposList
//
//  Created by Luiz Zenha on 17/02/20.
//  Copyright © 2020 Zenha. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

class ReposViewCell: UITableViewCell {
    
    let lblReposName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        lbl.sizeToFit()
        return lbl
    }()
    
    let lblName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica", size: 18)
        lbl.sizeToFit()
        return lbl
    }()
    
    let lblStars: UILabel = {
       let lbl = UILabel()
       lbl.translatesAutoresizingMaskIntoConstraints = false
       lbl.sizeToFit()
       return lbl
    }()
    let imgPhoto: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let customSeparator: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOpaque = true
        view.backgroundColor = Const.bgColor
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imgPhoto)
        
        imgPhoto.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:0).isActive = true
        imgPhoto.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        imgPhoto.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -1).isActive = true
        imgPhoto.addConstraint( NSLayoutConstraint(item: imgPhoto, attribute: .width, relatedBy: .equal, toItem: imgPhoto, attribute: .height, multiplier: 1, constant: 0))
        
        self.contentView.addSubview(lblReposName)
        lblReposName.leadingAnchor.constraint(equalTo: self.imgPhoto.trailingAnchor, constant: 5).isActive = true
        lblReposName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        lblReposName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        lblReposName.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
       
        self.contentView.addSubview(lblName)
        lblName.leadingAnchor.constraint(equalTo: self.imgPhoto.trailingAnchor, constant: 5).isActive = true
        lblName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        lblName.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        lblName.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        self.contentView.addSubview(lblStars)
        lblStars.leadingAnchor.constraint(equalTo: self.imgPhoto.trailingAnchor, constant: 5).isActive = true
        lblStars.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        lblStars.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        lblStars.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        self.contentView.addSubview(customSeparator)
        customSeparator.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:5).isActive = true
        customSeparator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        customSeparator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -1).isActive = true
        customSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    
    
    func configureView(_ repos:Repos){

        //Join FontAwesome with text
        let titleText: NSMutableAttributedString = NSMutableAttributedString(string: String.fontAwesomeIcon(name: .github), attributes: [
            .font: UIFont.fontAwesome(ofSize: 20, style: .brands)])
        let name: NSAttributedString = NSAttributedString(string: " " + repos.name, attributes: [
            .font: UIFont(name: "Helvetica-Bold", size: 20)!])
        titleText.append(name)
        lblReposName.attributedText = titleText
        
        //Autor login
        lblName.text = repos.owner.login
        
        
        
        //Join FontAwesome with text
        let starsText: NSMutableAttributedString = NSMutableAttributedString(string: String.fontAwesomeIcon(name: .star), attributes: [
            .font: UIFont.fontAwesome(ofSize: 16, style: .solid)])
        let stars: NSAttributedString = NSAttributedString(string: String(format: " %d", repos.stargazers_count), attributes: [
           .font: UIFont(name: "Helvetica", size: 16)!])
        starsText.append(stars)
        lblStars.attributedText = starsText
        
        //Load photo
        let url: URL? = URL(string: repos.owner.avatar_url)
        if url != nil{
            load_photo(url: url)
        }
    }
    
    
    
    func load_photo(url: URL!) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imgPhoto.image = image
                    }
                }
            }
        }
    }
    
}
