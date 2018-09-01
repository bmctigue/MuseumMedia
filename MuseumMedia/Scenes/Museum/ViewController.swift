//
//  ViewController.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 9/1/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

protocol Displayable: class {
    var builder: Builder? { get set }
    var interactor: BusinessLogic? { get set }
    func fetch()
    func displayFetchedItem(viewModel: MuseumMedia.FetchItem.ViewModel)
}

class ViewController: UIViewController, Displayable {
    
    var builder: Builder?
    var interactor: BusinessLogic?
     var displayedItem: MuseumMedia.FetchItem.ViewModel.DisplayedItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.builder = Builder(viewController: self)
        fetch()
    }
    
    func fetch() {
        let request = MuseumMedia.FetchItem.Request()
        interactor?.fetchItem(request: request)
    }
    
    func displayFetchedItem(viewModel: MuseumMedia.FetchItem.ViewModel) {
        displayedItem = viewModel.displayedItem
    }
}

