//
//  CategoryTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/01.
//

import UIKit


class CategoryTVC: UITableViewCell {
    static let identifier: String = "CategoryTVC"
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    // CollectionView 동적 너비를 위해
    var flowLayout: UICollectionViewFlowLayout  {
        return categoryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        flowLayout.estimatedItemSize = CGSize(width: 34, height: 34)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension CategoryTVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let category = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.identifier, for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
        
        switch indexPath.row {
        case 0:
            category.name.text = "가치관"
        case 1:
            category.name.text = "사랑"
        case 2:
            category.name.text = "일상"
        case 3:
            category.name.text = "이야기"
        case 4:
            category.name.text = "미래"
        case 5:
            category.name.text = "의미"
        default:
            category.name.text = "사랑"
        }
        category.name.sizeToFit()
        category.setBorderWithRadius(borderColor: .gray, borderWidth: 1, cornerRadius: 4)
        return category
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCVC {
            cell.backgroundColor = .black
            cell.name.textColor = .white
        }
        // 카테고리 Sorting 작업
//        delegate?.categoryButtonTapped(indexPath) // indexPath = 어떤 category 인지
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCVC {
            cell.backgroundColor = .white
            cell.name.textColor = #colorLiteral(red: 0.3882352941, green: 0.3882352941, blue: 0.4, alpha: 1)
        }

        // 카테고리 Sorting 작업
//        delegate?.categoryButtonTapped(indexPath) // indexPath = 어떤 category 인지
    }
}

extension CategoryTVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30) }
    
 
}
