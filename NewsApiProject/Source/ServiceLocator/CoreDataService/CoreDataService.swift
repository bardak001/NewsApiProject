//
//  CoreDataService.swift
//  NewsApiProject
//
//  Created by Радим Гасанов on 16.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit
import CoreData

class CoreDataService: CoreDataServiceProtocol {    
    
    var appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    //MARK: - Fetch
    func fetchNewsModels(completion: @escaping ([NewsModel]?) -> Void) {
        guard let context = self.context else { return }
        
        let fetchRequest: NSFetchRequest<NewsModel> = NewsModel.fetchRequest()
        
        do {
            let newsModel = try context.fetch(fetchRequest)
            completion(newsModel)
        } catch {
            completion(nil)
        }
    }
    
    //MARK: - Save
    func saveNewsModel(title: String, author: String) {
        guard let context = self.context,
            let entity = NSEntityDescription.entity(forEntityName: "NewsModel", in: context),
            let newsObject = NSManagedObject(entity: entity, insertInto: context) as? NewsModel else { return }
        newsObject.title = title
        newsObject.author = author
        do {
            try! context.save()
        }
    }
    
    //MARK: - Delete
    func deleteAllNewsModels() {
        fetchNewsModels { (newsModels) in
            guard let newsModels = newsModels else { return }
            for newModel in newsModels {
                self.context?.delete(newModel)
            }
        }
    }
}
