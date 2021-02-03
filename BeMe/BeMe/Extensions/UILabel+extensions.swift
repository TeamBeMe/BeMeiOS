//
//  UILabel+extensions.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/14.
//

import Foundation
import UIKit

extension UILabel {
  func addCharacterSpacing(kernValue: Double = 1.15) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
    func calculateMaxLabelLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight

        let attributes: [NSAttributedString.Key: Any] = [
            .kern: -1,
            .font: self.font,
            .foregroundColor: UIColor.blue,
            .paragraphStyle: NSMutableParagraphStyle()
                
        ]
        let text3 = NSAttributedString(string: self.text ?? "",attributes: attributes)
    
        let textSize = text3.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
