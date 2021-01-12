//
//  UIColor+Extensions.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import UIKit

extension UIColor {
    
    @nonobjc class var darkGrey: UIColor {
      return UIColor(red: 44.0 / 255.0, green: 44.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var slateGrey: UIColor {
      return UIColor(red: 99.0 / 255.0, green: 99.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPink: UIColor {
      return UIColor(white: 201.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var darkGrey40: UIColor {
      return UIColor(red: 44.0 / 255.0, green: 44.0 / 255.0, blue: 46.0 / 255.0, alpha: 0.4)
    }
    
    @nonobjc class var charcoalGrey: UIColor {
      return UIColor(red: 72.0 / 255.0, green: 72.0 / 255.0, blue: 74.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grapefruit: UIColor {
      return UIColor(red: 1.0, green: 81.0 / 255.0, blue: 81.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var rgb8E8E93: UIColor {
      return UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var rgbededed: UIColor {
      return UIColor(white: 237.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var rgb3A3A3C: UIColor {
      return UIColor(red: 58.0 / 255.0, green: 58.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var rgb1C1C1E: UIColor {
      return UIColor(red: 28.0 / 255.0, green: 28.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPinkTwo: UIColor {
      return UIColor(white: 235.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var brownishGrey: UIColor {
        return UIColor(white: 114.0 / 255.0, alpha: 1.0)
      }
    @nonobjc class var veryLightPinkThree: UIColor {
       return UIColor(white: 237.0 / 255.0, alpha: 1.0)
     }
    @nonobjc class var deepSkyBlue: UIColor {
       return UIColor(red: 10.0 / 255.0, green: 132.0 / 255.0, blue: 1.0, alpha: 1.0)
     }


    

    /*
     Home은 독특해서 따로 빼둠
     */
    enum Home {
        enum Button {
            static let text: UIColor = { UIColor(white: 0.0, alpha: 1.0) }()
            static let backgruond: UIColor = { UIColor(white: 1.0, alpha: 1.0) }()
            
            static let slateGray: UIColor = { UIColor(red: 99.0 / 255.0, green: 99.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0) }()
        }
        
        enum Label {
            static let darkGrey: UIColor = { UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0) }()
            static let white: UIColor = { UIColor(white: 1.0, alpha: 1.0) }()
            static let lightGrey: UIColor = { UIColor(white: 201.0 / 255.0, alpha: 1.0) }()
        }
        
    }
    
    enum Background {
        static let `default`: UIColor = .white
        static let black: UIColor = .black
    }
    
    enum Label {
        static let slateGray: UIColor = { UIColor(red: 99.0 / 255.0, green: 99.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0) }()
        static let black: UIColor = { UIColor(white: 0.0, alpha: 1.0) }()
        static let text: UIColor = { UIColor(white: 1.0, alpha: 1.0) }()
    }
    
    enum Border {
        static let textView: UIColor = { UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0) }()
    }
}
