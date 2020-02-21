//
//  ReposView.swift
//  GitHubReposList
//
//  Created by Luiz Zenha on 17/02/20.
//  Copyright © 2020 Zenha. All rights reserved.
//

import Foundation
import UIKit

protocol ReposViewDelegate {
    func refreshReposList()
}
class ReposView: UIView {
    var tableView: UITableView!
    var identifier : String = "ReposViewCell"
    var identifierFooter : String = "ReposViewCellFooter"
    var refreshControl : UIRefreshControl = UIRefreshControl()
    var delegate : ReposViewDelegate!
    
    //default initialize (Xib ou Storyboard)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    //Dynamic init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame);
        
        //Create Tablew View, Set
        tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        tableView.separatorStyle = .none
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        tableView.register(ReposViewCell.self, forCellReuseIdentifier:identifier)
        tableView.register(LoadingViewCell.self, forCellReuseIdentifier: identifierFooter)
        tableView.accessibilityLabel = "table_repositories"
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor:  Const.contrastColor,
            .font: UIFont(name: "Helvetica", size: 16)!
        ]
        refreshControl.tintColor = Const.contrastColor
        refreshControl.backgroundColor = Const.bgColor
        tableView.backgroundColor = Const.bgColor
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Loading GitHub repositores ...", attributes: attributes)
        tableView.contentOffset = CGPoint(x:0, y:-refreshControl.frame.size.height)
        tableView.refreshControl = refreshControl
        
        tableView.refreshControl?.beginRefreshing()
        
    }
    
    
    //Reload all data from server
    @objc private func refreshTable(){
        delegate!.refreshReposList()
    }
    
    //Reload data on table view
    func reloadData() {
//        self.tableView.contentOffset = CGPoint(x:0, y:0)
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    
    //Set table delegate and data source
    func setTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    

    //Get Cell to row at index
    func cellForItem(repos: Repos, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ReposViewCell
        cell.configureView(repos)
        return cell
    }
    
    func cellLoadingForFooter() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierFooter) as! LoadingViewCell
        cell.configureView()
        return cell
    }
    
    func heightForRow() -> CGFloat{
        return 100.0
    }
    
    
}
