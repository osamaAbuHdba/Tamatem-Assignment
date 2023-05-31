//
//  UIColor+Ex.swift
//  Tamatem Assignment
//
//  Created by Osama Abu Hdba on 31/05/2023.
//

import UIKit

/**
 Base Enum to access all Colors
  - Example :-  view.tintColor = .Background1
 */

enum Color: String {                                     // Light hex#  :: Dark hex#
    case background                                            //071746 :: 071746
    case buttonBackground                                      //FECD00 :: FECD00
    case buttonTitleColor                                      //113284 :: 113284

    var color: UIColor {
        UIColor(named: self.rawValue)!
    }
}

extension UIColor {
    static var background:            UIColor { Color.background.color }
    static var buttonBackground:      UIColor { Color.buttonBackground.color }
    static var buttonTitleColor:      UIColor { Color.buttonTitleColor.color }
}
