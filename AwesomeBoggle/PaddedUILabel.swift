//
//  PaddedUILabel.swift
//  AwesomeBoggle
//
//  Created by mtodd on 2/9/17.
//  Copyright © 2017 Matt Todd. All rights reserved.
//
import UIKit

class PaddedUILabel: UILabel {
    override func drawText(in: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        super.drawText(in: UIEdgeInsetsInsetRect(`in`, insets))
    }
}
