//
//  GitHubReposListTests.swift
//  GitHubReposListTests
//
//  Created by Luiz Zenha on 17/02/20.
//  Copyright © 2020 Zenha. All rights reserved.
//

import Quick
import Nimble

@testable import GitHubReposList

class GitHubReposListTests: QuickSpec {

    
    override func spec() {
        var viewController: ReposViewController!
        var view:ReposView!
        var lastItens: Int!
        
        context("view is loaded") {
            beforeEach {
                viewController = ReposViewController()
                view = viewController.view as? ReposView
            }
            it("it should load repositories", closure: {

                expect(viewController.loading).toEventually(equal(false), timeout: 10)
                expect(viewController.arrayItensScreen).toNot(beNil())
                expect(viewController.arrayItensScreen?.count).to(beGreaterThan(0))
                expect(view.tableView.numberOfRows(inSection: 0)).to(equal(viewController.arrayItensScreen?.count))
                
            })
        }
        
        context("afeter view laoded") {
            
            it("check loaded repositories", closure: {
                let arrayItens:[Repos]! = viewController.arrayItensScreen
                for item in arrayItens {
                    expect(item.name).toNot(beNil())
                    expect(item.name).to(beAKindOf(String.self))
                    expect(item.stargazers_count).toNot(beNil())
                    expect(item.stargazers_count).to(beAKindOf(Int.self))
                    expect(item.owner).toNot(beNil())
                    expect(item.owner).to(beAKindOf(Author.self))
                    expect(item.owner.login).toNot(beNil())
                    expect(item.owner.login).to(beAKindOf(String.self))
                    expect(item.owner.avatar_url).toNot(beNil())
                    expect(item.owner.avatar_url).to(beAKindOf(String.self))
                    
                }
                
            })
            
        }
        
        context("check uitablewview cell content") {
            
            it("it should load repositories", closure: {
                
                let firstCell: ReposViewCell? = (view.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ReposViewCell)

                expect(firstCell?.lblName.text).toNot(beNil())
                expect(firstCell?.lblReposName.attributedText).toNot(beNil())
                expect(firstCell?.lblStars.attributedText).toNot(beNil())
                    
            })
            
        }
        
    }

}
