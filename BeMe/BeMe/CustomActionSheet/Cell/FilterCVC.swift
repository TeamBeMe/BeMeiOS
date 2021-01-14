//
//  FilterCVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/14.
//

import UIKit

class FilterCVC: UICollectionViewCell {
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        setButton(isSelected: true)
        filterCVCDelegate?.setSelectedCategory(index: indexPath)
    }
    
    static let identifier: String = "FilterCVC"
    var categoryArray: [ExploreCategory] = []
    var indexPath = -1
    private var filterCVCDelegate: FilterCVCDelegate?
   
    override class func awakeFromNib() {
        
    }
    
    func setButton(isSelected: Bool) {
        if !isSelected {
            
            categoryButton.setBorderWithRadius(borderColor: .veryLightPink, borderWidth: 1, cornerRadius: 4)
            categoryButton.backgroundColor = UIColor.white
            categoryButton.setTitleColor(.slateGrey, for: .normal)
        } else {
            
            categoryButton.setBorderWithRadius(borderColor: .black, borderWidth: 1, cornerRadius: 4)
            categoryButton.backgroundColor = UIColor.black
            categoryButton.setTitleColor(.white, for: .normal)
        }
        
    }
    func setButton(text: String) {
        categoryButton.setTitle(text, for: .normal)
        categoryButton.setBorderWithRadius(borderColor: .veryLightPink, borderWidth: 1, cornerRadius: 4)
        categoryButton.backgroundColor = UIColor.white
        categoryButton.setTitleColor(.slateGrey, for: .normal)
    }
}

protocol FilterCVCDelegate {
    func setSelectedCategory(index: Int)
}
