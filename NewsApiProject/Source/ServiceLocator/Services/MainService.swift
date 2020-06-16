//
//  MainService.swift
//  NewsApiProject
//
//  Created by Радим Гасанов on 16.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import Foundation
import CoreData

//MARK: - Service
class MainServiceImpl {
    
    private var coreDataService: CoreDataService
    private var requestManager: RequestManager
    
    init(coreDataService: CoreDataService,
         requestManager: RequestManager) {
        self.coreDataService = coreDataService
        self.requestManager = requestManager
    }
    
}
//MARK: - Functions
extension MainServiceImpl {
    func downloadNewsModels(completion: @escaping (_ newsModels: [(title: String, author: String)]) -> Void) {
        let parameters: [String : String] = [
            "domains": "techcrunch.com",
            "apiKey": "1bcf1ea909a44af38ae15752735e20ea"
        ]
        let headerParameters: [String : String] = [:]
        RequestManager.sendRequest(url: "https://newsapi.org/v2/everything",
                                   parameters: parameters,
                                   headerParameters: headerParameters) { responseObject, error in
            guard let responseObject = responseObject,
                error == nil, responseObject["status"] as? String == "ok", let articles = responseObject["articles"] as? [[String: Any]] else {
                return
            }
            var newsModels = [(title: String, author: String)]()
            for article in articles {
                let title = article["title"] as? String ?? "unknowned title"
                let author = article["author"] as? String ?? "unknowned author"
                newsModels.append((title: title, author: author))
            }
            completion(newsModels)
        }
    }
}
