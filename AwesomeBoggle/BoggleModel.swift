//
//  BoggleModel.swift
//  AwesomeBoggle
//
//  Created by mtodd on 2/6/17.
//  Copyright © 2017 Matt Todd. All rights reserved.
//

import Foundation

class BoggleModel {
    func populateGrid(viewController: BoggleViewControllerProtocol) {
        var letters = Array<String>()
        for _ in 0...16 {
            letters += [getRandomString()]
        }
        viewController.setRandomizedLetters(letters)
    }
    
    func getRandomString() -> String {
        let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters)
        let random_int = Int(arc4random_uniform(26))
        return String(letters[random_int])
    }
}
