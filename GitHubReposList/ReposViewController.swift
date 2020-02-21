//
//  ViewController.swift
//  GitHubReposList
//
//  Created by Luiz Zenha on 17/02/20.
//  Copyright © 2020 Zenha. All rights reserved.
//

import UIKit

class ReposViewController: UIViewController, ReposModelDelegate, ReposViewDelegate, UITableViewDelegate, UITableViewDataSource {


    var model: ReposModel! = ReposModel()
    var arrayItens: [Repos]? = []
    var arrayItensScreen: [Repos]? = []
    var reposView: ReposView {
        return view as! ReposView
    }
    var page: Int = 1
    var loading: Bool = false
    
    override func loadView() {
        let _reposView = ReposView()
        _reposView.delegate = self
        self.view = _reposView
        self.title = NSLocalizedString("Title", comment: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reposView.setTableView(delegate: self, dataSource: self)
        model.delegate = self
        loadData();
    }
    
    
    func loadData(){
        loading = true
        self.model.get_repos(page: self.page)
    }
    
    // MARK: Connection delegates
    func return_repos(_ array: [Repos]) {
        arrayItens?.append(contentsOf: array)
        arrayItensScreen = arrayItens
        reposView.reloadData()
        page += 1
        loading = false
        
    }
    
    func return_repos_error(_ message: String) {
        loading = false
        
        let alert : UIAlertController = UIAlertController(title: NSLocalizedString("ErrorTitle", comment: ""), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: {
            self.reposView.reloadData()
        })
    }

    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItensScreen?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrayItensScreen!.count - indexPath.row < 10 && !loading {
            loadData()
            tableView.tableFooterView = reposView.cellLoadingForFooter()
        }
        
        return reposView.cellForItem(repos: arrayItensScreen![indexPath.row], indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return reposView.heightForRow()
    }
    
  
    
    
    
    
    // MARK: ReposView Delegate
    func refreshReposList() {
        page = 1
        arrayItens?.removeAll()
        loadData()
    }
}
