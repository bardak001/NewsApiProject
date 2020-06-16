//
//  MainPresenter.swift
//  NewsApiProject
//
//  Created by Радим Гасанов on 16.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit
import CoreData

//MARK: - Presenter
class MainPresenterImpl: MainPresenter {
    
    let view: MainView
    let router: MainRouter
    let state: MainState
    
    // MARK: - Service
    var coreDataService: CoreDataService
    var mainService: MainServiceImpl
    
    // MARK: - Init
    init(view: MainView,
         router: MainRouter,
         state: MainState,
         coreDataService: CoreDataService,
         mainService: MainServiceImpl) {
        self.view = view
        self.router = router
        self.state = state
        self.coreDataService = coreDataService
        self.mainService = mainService
    }
}

//MARK: - Functions
extension MainPresenterImpl {
    func getOldNews() {
        coreDataService.fetchNewsModels { (newsModels) in
            guard let newsModels = newsModels else { return }
            print("загружены данные из кордаты!")
            self.view.setNewsModels(newModels: newsModels)
        }
    }
    func refreshNewsModels() {
        print("удалены данные в кордате!")
        coreDataService.deleteAllNewsModels()
        
        mainService.downloadNewsModels { (newsModels) in
            print("загружены данные с сервера!")
            for newsModel in newsModels {
                print("новые данные сохранены в кордату: title - \(newsModel.title), author - \(newsModel.author)")
                self.coreDataService.saveNewsModel(title: newsModel.title,
                                                   author: newsModel.author)
            }
            print("вновь загружены данные из кордаты!")
            self.coreDataService.fetchNewsModels { (newsModels) in
                guard let newsModels = newsModels else { return }
                DispatchQueue.main.async {
                    self.view.setNewsModels(newModels: newsModels)
                }
            }
        }
    }
}
