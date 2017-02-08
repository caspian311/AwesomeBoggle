//
//  ViewController.swift
//  AwesomeBoggle
//
//  Created by mtodd on 1/26/17.
//  Copyright © 2017 Matt Todd. All rights reserved.
//

import UIKit


protocol BoggleViewControllerProtocol: class {
    func populateNewLettersToGrid(_ letters: Array<String>)
    
    func resetGrid()
    
    func letterSelected(_ letter: String?)
    
    func currentWordChanged()
    
    func submitWord()
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
        
        boggleView.setViewController(self)
        boggleModel.setViewController(self)
        
        boggleModel.populateGrid()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func populateNewLettersToGrid(_ letters: Array<String>) {
        boggleView.updateLetters(letters)
    }
    
    func resetGrid() {
        boggleModel.populateGrid()
    }
    
    func letterSelected(_ letter: String?) {
        if let letter = letter {
            boggleModel.addLetter(letter)
        }
    }
    
    func currentWordChanged() {
        boggleView.setCurrentWord(boggleModel.getCurrentWord())
    }
    
    func submitWord() {
        boggleModel.submitWord()
    }
}

