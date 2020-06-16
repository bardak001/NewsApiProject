//
//  MainProtocols.swift
//  NewsApiProject
//
//  Created by Радим Гасанов on 16.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

protocol MainPresenter: AnyObject {
    func getOldNews()
    func refreshNewsModels()
}

protocol MainView: AnyObject {
    func setNewsModels(newModels: [NewsModel])
}

protocol MainRouter {}
