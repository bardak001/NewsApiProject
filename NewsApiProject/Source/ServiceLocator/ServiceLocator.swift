//
//  ServiceLocator.swift
//  NewsApiProject
//
//  Created by Радим Гасанов on 16.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

protocol ServiceLocator {
    var coreDataService: CoreDataService { get }
    
    var mainService: MainServiceImpl { get }
}
