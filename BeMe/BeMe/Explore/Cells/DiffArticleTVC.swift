//
//  DiffArticleTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/08.
//

import UIKit

class DiffArticleTVC: UITableViewCell {
    static let identifier: String = "DiffArticleTVC"
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categoryArray: [String] = ["가치관", "사랑", "일상", "이야기", "미래", "의미", "사랑"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCategoryCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setCategoryCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
}

extension DiffArticleTVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let category = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.identifier, for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }

        category.name.sizeToFit()
        category.makeRounded(cornerRadius: 4.0)
        category.setBorder(borderColor: .gray, borderWidth: 1)
        
        return category
    }
    
    
    
}
