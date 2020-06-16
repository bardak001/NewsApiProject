//
//  CoreDataServiceProtocol.swift
//  NewsApiProject
//
//  Created by Радим Гасанов on 16.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    var appDelegate: AppDelegate? { get }
    var context: NSManagedObjectContext? { get }
    
    func fetchNewsModels(completion: @escaping ([NewsModel]?) -> Void)
    func saveNewsModel(title: String, author: String)
    func deleteAllNewsModels()
    
}
