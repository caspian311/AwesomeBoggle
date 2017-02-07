//
//  ViewController.swift
//  AwesomeBoggle
//
//  Created by mtodd on 1/26/17.
//  Copyright © 2017 Matt Todd. All rights reserved.
//

import UIKit


protocol BoggleViewControllerProtocol: class {
    func setRandomizedLetters(_ letters: Array<String>)
}

class BoggleViewController: UIViewController, BoggleViewControllerProtocol {
    let boggleView: BoggleView
    let boggleModel: BoggleModel
    
    init(boggleView: BoggleView = BoggleView(), boggleModel: BoggleModel = BoggleModel()) {
        self.boggleView = boggleView
        self.boggleModel = boggleModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = boggleView
        boggleModel.populateGrid(viewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setRandomizedLetters(_ letters: Array<String>) {
        boggleView.setRandomizedLetters(letters)
    }
}

