//
//  DiffArticleTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/08.
//

import UIKit
import Firebase

class DiffArticleTVC: UITableViewCell {
    static let identifier: String = "DiffArticleTVC"
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var highLightBar: UIView!
    @IBOutlet weak var diffArticleSubTitle: UILabel!
    @IBOutlet weak var highLightBarLeading: NSLayoutConstraint!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: UITableViewButtonSelectedDelegate?

    private var isRecentButtonPressed: Bool = true
    
    var selectedCategoryId: Int = 0
    var categoryArray: [ExploreCategory] = [] {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    
    // CollectionView 동적 너비를 위해
    var flowLayout: UICollectionViewFlowLayout  {
        return categoryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setLabel()
        setCategoryCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setCategoryCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.isMultipleTouchEnabled = true
        flowLayout.estimatedItemSize = CGSize(width: 34, height: 34)
        flowLayout.minimumLineSpacing = 8.0
    }
    
    @IBAction func recentButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
        delegate?.recentOrFavoriteButtonTapped(0, "최신")
        isRecentButtonPressed = true
        setLabel()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
        delegate?.recentOrFavoriteButtonTapped(1, "흥미")
        isRecentButtonPressed = false
        setLabel()
    }
}

//MARK: - Private Method

extension DiffArticleTVC {
    private func setLabel() {
        self.diffArticleSubTitle.text = self.isRecentButtonPressed ? "내가 답한 질문에 대한 다른 사람들의 최신 답변이에요" : "내가 관심있어 할 다른 사람들의 답변이에요"
    }
    private func moveHighLightBar(to button: UIButton) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
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
                
        if indexPath.item == selectedCategoryId - 1  {
            category.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        
        category.name.text = categoryArray[indexPath.item].name
        category.name.sizeToFit()
        category.makeRounded(cornerRadius: 4.0)
        category.setBorder(borderColor: .gray, borderWidth: 1)
        return category
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Selected")
        selectedCategoryId = indexPath.item + 1
        switch selectedCategoryId {
        case 1:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_VALUES_SEARCH", parameters: [
                AnalyticsParameterScreenName: "SEARCH"
            ])
            
            break
        case 2:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_RELATIONSHIP_SEARCH", parameters: [
                AnalyticsParameterScreenName: "SEARCH"
            ])
            
            break
        case 3:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_LOVE_SEARCH", parameters: [
                AnalyticsParameterScreenName: "SEARCH"
            ])
            
            break
        case 4:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_DAILYLIFE_SEARCH", parameters: [
                AnalyticsParameterScreenName: "SEARCH"
            ])
            
            break
        case 5:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_ABOUTME_SEARCH", parameters: [
                AnalyticsParameterScreenName: "SEARCH"
            ])
            
            break
        case 6:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_STORY_SEARCH", parameters: [
                AnalyticsParameterScreenName: "SEARCH"
            ])
            
            break
        default:
            break
        }
        delegate?.categoryButtonTapped(indexPath, selectedCategoryId)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("DeSelected")
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCVC else {
            return true
        }

        if cell.isSelected {
            selectedCategoryId = 0
            delegate?.categoryButtonTapped(indexPath, selectedCategoryId)
            collectionView.deselectItem(at: indexPath, animated: false)
            return false
        } else {
            return true
        }
        
    }
}

extension DiffArticleTVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
}
