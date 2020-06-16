//
//  DefaultServiceLocator.swift
//  NewsApiProject
//
//  Created by Радим Гасанов on 16.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

class DefaultServiceLocator: ServiceLocator {
    var coreDataService: CoreDataService = CoreDataService()
    private let requestManager = RequestManager()
    
    lazy var mainService = MainServiceImpl(coreDataService: coreDataService,
                                           requestManager: requestManager)
}
