//
//  MainTableViewController.swift
//  NewsApiProject
//
//  Created by Радим Гасанов on 16.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - ViewController
class MainTableViewController: UITableViewController {
    
    var presenter: MainPresenter?
    
    private let reuseID = "reuseIdentifier"
    
    private var newModels = [NewsModel]()
    
    private let refreshContr: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: Constants.refreshTitle)
        refreshControl.addTarget(self,
                                 action: #selector(refresh),
                                 for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: reuseID)
        tableView.refreshControl = refreshContr
        presenter?.getOldNews()
        
    }
    
}
//MARK: - Functions

extension MainTableViewController {
    
    //MARK: - UI functions
//    //MARK: - @objc functions
//    //MARK: - another functions
    @objc private func refresh() {
        presenter?.refreshNewsModels()
    }
}
//MARK: - data source

extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        cell.backgroundColor = .lightGray
        let newsModel = newModels[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = (newsModel.author ?? "unknowned authot") + ": " + (newsModel.title ?? "is empty")
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
//MARK: - View
extension MainTableViewController: MainView {
    func setNewsModels(newModels: [NewsModel]) {
        self.newModels = newModels
        refreshContr.endRefreshing()
        tableView.reloadData()
    }
}

//MARK: - Constants
extension MainTableViewController {
    private enum Constants {
        static let refreshTitle = "Pull to refresh"
    }
}
