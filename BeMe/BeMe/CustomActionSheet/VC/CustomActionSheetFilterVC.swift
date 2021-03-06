//
//  CustomActionSheetFilterVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/14.
//

import UIKit
import Firebase

class CustomActionSheetFilterVC: UIViewController {
    
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var publicButton: UIButton!
    @IBOutlet weak var unpublicButton: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var availablityLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    // 서버통신을 통해 받아오는 값
    var categoryArray: [ExploreCategory] = []
//    private var filterCVCDelegate: FilterCVCDelegate?
    var fromServer = true
    
    private var selectedCategory: Int?
        = nil
    
    private var selectedAvailablity: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setButton(view: allButton, isSelected: false)
        setButton(view: publicButton, isSelected: false)
        setButton(view: unpublicButton, isSelected: false)
        
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self

        availablityButtonSet(availablity: selectedAvailablity)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setCategoryData()
        selectedAvailablity = MypageVC.selectedAvailablity
        availablityButtonSet(availablity: selectedAvailablity)
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .init("categoryClose"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func allButtonTapped(_ sender: UIButton) {
        selectedAvailablity = "all"
        availablityButtonSet(availablity: selectedAvailablity)
    }
    
    @IBAction func publicButtonTapped(_ sender: UIButton) {
        FirebaseAnalytics.Analytics.logEvent("CLICK_OPEN_MPFILTER", parameters: [
            AnalyticsParameterScreenName: "MPFILTER"
        ])
        selectedAvailablity = "public"
        availablityButtonSet(availablity: selectedAvailablity)
    }
    
    @IBAction func unpublicButtonTapped(_ sender: UIButton) {
        FirebaseAnalytics.Analytics.logEvent("CLICK_PRIVATE_MPFILTER", parameters: [
            AnalyticsParameterScreenName: "MPFILTER"
        ])
        selectedAvailablity = "unpublic"
        availablityButtonSet(availablity: selectedAvailablity)
    }
    

    @IBAction func applyButtonTapped(_ sender: Any) {
        
        if let category = selectedCategory {
            NotificationCenter.default.post(name: .init("categoryClose"), object: nil, userInfo: ["categoryId": category , "selectedAv": selectedAvailablity ?? "all"])
            self.dismiss(animated: true, completion: nil)
        } else {
            // 토스트팝업
            self.showToast(text: "카테고리를 선택해주세요.")
        }
        
    }

    func availablityButtonSet(availablity: String?){
        switch availablity {
        case "all":
            allButton.backgroundColor = .black
            allButton.setTitleColor(.white, for: .normal)
            allButton.setBorderWithRadius(borderColor: .black, borderWidth: 1, cornerRadius: 4)
            
            publicButton.backgroundColor = .white
            publicButton.setTitleColor(.slateGrey, for: .normal)
            publicButton.setBorderWithRadius(borderColor: .veryLightPink, borderWidth: 1, cornerRadius: 4)
            
            unpublicButton.backgroundColor = .white
            unpublicButton.setTitleColor(.slateGrey,  for: .normal)
            unpublicButton.setBorderWithRadius(borderColor: .veryLightPink, borderWidth: 1, cornerRadius: 4)
            
        case "public":
            allButton.backgroundColor = .white
            allButton.setTitleColor(.slateGrey, for: .normal)
            allButton.setBorderWithRadius(borderColor: .veryLightPink, borderWidth: 1, cornerRadius: 4)
            
            publicButton.backgroundColor = .black
            publicButton.setTitleColor(.white, for: .normal)
            publicButton.setBorderWithRadius(borderColor: .black, borderWidth: 1, cornerRadius: 4)
            
            
            
            unpublicButton.backgroundColor = .white
            unpublicButton.setTitleColor(.slateGrey,  for: .normal)
            unpublicButton.setBorderWithRadius(borderColor: .veryLightPink, borderWidth: 1, cornerRadius: 4)
        case "unpublic":
            allButton.backgroundColor = .white
            allButton.setTitleColor(.slateGrey, for: .normal)
            allButton.setBorderWithRadius(borderColor: .veryLightPink, borderWidth: 1, cornerRadius: 4)
            
            publicButton.backgroundColor = .white
            publicButton.setTitleColor(.slateGrey, for: .normal)
            publicButton.setBorderWithRadius(borderColor: .veryLightPink, borderWidth: 1, cornerRadius: 4)
            
            
            unpublicButton.backgroundColor = .black
            unpublicButton.setTitleColor(.white,  for: .normal)
            unpublicButton.setBorderWithRadius(borderColor: .black, borderWidth: 1, cornerRadius: 4)
            
        default:
            allButton.backgroundColor = .black
            allButton.setTitleColor(.white, for: .normal)
            allButton.setBorderWithRadius(borderColor: .black, borderWidth: 1, cornerRadius: 4)
            
            publicButton.backgroundColor = .white
            publicButton.setTitleColor(.slateGrey, for: .normal)
            publicButton.setBorderWithRadius(borderColor: .veryLightPink, borderWidth: 1, cornerRadius: 4)
            
            unpublicButton.backgroundColor = .white
            unpublicButton.setTitleColor(.slateGrey,  for: .normal)
            unpublicButton.setBorderWithRadius(borderColor: .veryLightPink, borderWidth: 1, cornerRadius: 4)
        }
    }
    
    func setLabel() {
        availablityLabel.textColor = .slateGrey
        categoryLabel.textColor = .slateGrey
    }
    
    
    func setButton(view: UIButton, isSelected: Bool) {
        if !isSelected {
            
            view.setBorderWithRadius(borderColor: .veryLightPink, borderWidth: 1, cornerRadius: 4)
            view.backgroundColor = UIColor.white
            view.setTitleColor(.slateGrey, for: .normal)
        } else {
            
            view.setBorderWithRadius(borderColor: .black, borderWidth: 1, cornerRadius: 4)
            view.backgroundColor = UIColor.black
            view.setTitleColor(.white, for: .normal)
        }
        
    }
}

extension CustomActionSheetFilterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = indexPath.item
        switch selectedCategory {
        case 1:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_VALUES_MPFILTER", parameters: [
                AnalyticsParameterScreenName: "MPFILTER"
            ])
            
            break
        case 2:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_RELATIONSHIP_MPFILTER", parameters: [
                AnalyticsParameterScreenName: "MPFILTER"
            ])
            
            break
        case 3:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_LOVE_MPFILTER", parameters: [
                AnalyticsParameterScreenName: "MPFILTER"
            ])
            
            break
        case 4:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_DAILYLIFE_MPFILTER", parameters: [
                AnalyticsParameterScreenName: "MPFILTER"
            ])
            
            break
        case 5:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_ABOUTME_MPFILTER", parameters: [
                AnalyticsParameterScreenName: "MPFILTER"
            ])
            
            break
        case 6:
            
            FirebaseAnalytics.Analytics.logEvent("CLICK_STORY_MPFILTER", parameters: [
                AnalyticsParameterScreenName: "MPFILTER"
            ])
            
            break
        default:
            break
        }
    }
}

extension CustomActionSheetFilterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FilterCVC.identifier,
                for: indexPath) as? FilterCVC else {
            return UICollectionViewCell()}
        cell.indexPath = indexPath.row

        cell.category = self.categoryArray[indexPath.item]

        cell.setButton(text: categoryArray[indexPath.item].name)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterCVC else {
            return true
        }

        if cell.isSelected {
            selectedCategory = 0
            collectionView.deselectItem(at: indexPath, animated: false)
            return false
        } else {
            return true
        }
    }
    
}

extension CustomActionSheetFilterVC: UICollectionViewDelegateFlowLayout {
    
}

extension CustomActionSheetFilterVC {
    
    private func setCategoryData() {
        fromServer = true
        ExploreCategoryService.shared.getExploreCategory { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<[ExploreCategory]> else { return }
                if let categories = dt.data {
                    self.categoryArray = categories
                }
                self.categoryCollectionView.reloadData()
   
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                
            case .pathErr: print("path")
            case .serverErr:
                let alertViewController = UIAlertController(title: "통신 실패", message: "서버 오류", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                print("networkFail")
                print("serverErr")
            case .networkFail:
                let alertViewController = UIAlertController(title: "통신 실패", message: "네트워크 오류", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
}
//
//extension CustomActionSheetFilterVC: FilterCVCDelegate {
//    func setSelectedCategory(index: Int) {
//
//    }
//    
//}
