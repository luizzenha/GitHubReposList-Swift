//
//  ReposModel.swift
//  GitHubReposList
//
//  Created by Luiz Zenha on 17/02/20.
//  Copyright © 2020 Zenha. All rights reserved.
//

import Foundation
import RestEssentials


protocol ReposModelDelegate{
    func return_repos(_ array:[Repos])
    func return_repos_error(_ error_message:String)
}
class ReposModel{
    
    var delegate: ReposModelDelegate?
    
    let url: String! = "https://api.github.com/search/repositories?q=language:swift&sort=stars&page="
 
    
    /**
        Get list of repos sorted by stars
     - Parameter page: Int must be greater than 0
     */
    func get_repos(page: Int!) {
        if(page <= 0){
            return;
        }
        
        guard let rest = RestController.make(urlString: String(format: "%@%d", self.url, page)) else {
            DispatchQueue.main.async {
                self.delegate?.return_repos_error("Url error!")
            }
            return;
        }
        rest.get(RootRepos.self){ result, httpResponse in
            do{
                let response = try result.value()
                DispatchQueue.main.async {
                    self.delegate?.return_repos(response.items)
                }
            }
            catch{
                DispatchQueue.main.async {
                    self.delegate?.return_repos_error(error.localizedDescription)
                }
            }
        }
          
    }
}
