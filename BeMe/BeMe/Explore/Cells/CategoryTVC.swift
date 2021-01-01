//
//  CategoryTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/01.
//

import UIKit

class CategoryTVC: UITableViewCell {
    static let identifier: String = "CategoryTVC"
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension CategoryTVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let category = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.identifier, for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
        
        category.layer.borderWidth = 1
        category.layer.borderColor = UIColor.gray.cgColor
        category.layer.cornerRadius = 4
        return category
    }
}

extension CategoryTVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30) }
}
