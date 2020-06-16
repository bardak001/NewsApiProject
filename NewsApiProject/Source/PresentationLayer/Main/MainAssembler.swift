//
//  MainAssembler.swift
//  NewsApiProject
//
//  Created by Радим Гасанов on 16.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - Assembly
class MainAssembler {
    static func createModule(serviceLocator: ServiceLocator) -> UIViewController {
        let view = MainTableViewController(style: .plain)
        let state = MainState()
        let router = MainRouterImpl(serviceLocator: serviceLocator)
        router.viewController = view
        
        let presenter = MainPresenterImpl(view: view,
                                          router: router,
                                          state: state,
                                          coreDataService: serviceLocator.coreDataService,
                                          mainService: serviceLocator.mainService)
        
        view.presenter = presenter
        
        return view
    }
}
