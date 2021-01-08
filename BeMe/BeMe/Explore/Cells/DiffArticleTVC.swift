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
    @IBOutlet weak var highLightBar: UIView!
    @IBOutlet weak var diffArticleSubTitle: UILabel!
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    private var isRecentButtonPressed: Bool = true
    var categoryArray: [String] = ["가치관", "사랑", "일상", "이야기", "미래", "의미", "사랑"]
    
    // CollectionView 동적 너비를 위해
    var flowLayout: UICollectionViewFlowLayout  {
        return categoryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
        setCategoryCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setCategoryCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        flowLayout.estimatedItemSize = CGSize(width: 34, height: 34)
        flowLayout.minimumLineSpacing = 8.0
    }
    
    @IBAction func recentButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
        delegate?.recentOrFavoriteButtonTapped(0)
        isRecentButtonPressed = true
        setLabel()
        print("Hello")
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
        delegate?.recentOrFavoriteButtonTapped(1)
        isRecentButtonPressed = false
        setLabel()
    }
    
}

//MARK: - Private Method

extension DiffArticleTVC {
    
    private func setLabel() {
        diffArticleSubTitle.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.diffArticleSubTitle.alpha = 1.0
            self.diffArticleSubTitle.text = self.isRecentButtonPressed ? "내가 답한 질문에 대한 다른 사람들의 최신 답변이에요" : "내가 관심있어 할 다른 사람들의 답변이에요"
        }) { (_) in
            
        }
        
    }
    
    private func moveHighLightBar(to button: UIButton) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
            // Slide Animation
            self.highLightBar.frame.origin.x = 30 + button.frame.minX
        }) { _ in
            
        }
    }
    
}
extension DiffArticleTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let category = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.identifier, for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
        
        category.name.sizeToFit()
        category.name.text = categoryArray[indexPath.item]
        category.makeRounded(cornerRadius: 4.0)
        category.setBorder(borderColor: .gray, borderWidth: 1)
        
        return category
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCVC {
            cell.backgroundColor = .black
            cell.name.textColor = .white
        }
        // 카테고리 Sorting 작업
        delegate?.categoryButtonTapped(indexPath) // indexPath = 어떤 category 인지
    }
}

extension DiffArticleTVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
}
