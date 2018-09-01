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
    func displayFetchedItems(viewModel: MuseumMedia.FetchItems.ViewModel)
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

