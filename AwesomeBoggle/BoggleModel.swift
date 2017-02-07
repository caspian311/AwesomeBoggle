//
//  BoggleModel.swift
//  AwesomeBoggle
//
//  Created by mtodd on 2/6/17.
//  Copyright © 2017 Matt Todd. All rights reserved.
//

import Foundation

class BoggleModel {
    var viewController: BoggleViewControllerProtocol?
    
    func populateGrid() {
        if let viewController = viewController {
            var letters = [String]()
            for _ in 0...16 {
                letters += [getRandomString()]
            }
            
            viewController.populateNewLettersToGrid(letters)
        }
    }
    
    func setViewController(_ viewController: BoggleViewControllerProtocol) {
        self.viewController = viewController
    }
    
    private func getRandomString() -> String {
        let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters)
        let random_int = Int(arc4random_uniform(26))
        return String(letters[random_int])
    }
}
