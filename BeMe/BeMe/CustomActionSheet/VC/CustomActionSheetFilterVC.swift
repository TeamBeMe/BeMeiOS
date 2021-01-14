//
//  CustomActionSheetFilterVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/14.
//

import UIKit

class CustomActionSheetFilterVC: UIViewController {
    
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var publicButton: UIButton!
    @IBOutlet weak var unpublicButton: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var availablityLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    // 서버통신을 통해 받아오는 값
    private var categoryArray: [ExploreCategory] = []
    var selecetedAvailablity: [Bool] = [false, false, false]
    private var filterCVCDelegate: FilterCVCDelegate?
//    var selecetedCategry: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setButton(view: allButton, isSelected: false)
        setButton(view: publicButton, isSelected: true)
        setButton(view: unpublicButton, isSelected: false)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setCategoryData()
//        print(categoryArray[0].name)
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .init("categoryClose"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func allButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func publicButtonTapped(_ sender: UIButton) {
    }
    @IBAction func unpublicButtonTapped(_ sender: UIButton) {
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
        
        
    }
}

extension CustomActionSheetFilterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(categoryArray.count)
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FilterCVC.identifier,
                for: indexPath) as? FilterCVC else {
            return UICollectionViewCell()}
        cell.indexPath = indexPath.row
        cell.categoryArray = self.categoryArray
        cell.setButton(isSelected: categoryArray[indexPath.row].selected!)
        cell.setButton(text: categoryArray[indexPath.row].name)
        print(indexPath.row)
        print(categoryArray[indexPath.row].name)
        
        
//        categoryCollectionView.reloadData()
        
        return cell
        
        
    }
    
    
}

extension CustomActionSheetFilterVC: UICollectionViewDelegateFlowLayout {
    
}

extension CustomActionSheetFilterVC {
    
    private func setCategoryData() {
        ExploreCategoryService.shared.getExploreCategory { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<[ExploreCategory]> else { return }
                if let categories = dt.data {
                    self.categoryArray = categories
                    
                    for var category in self.categoryArray {
                        category.selected = false
                    }
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

extension CustomActionSheetFilterVC: FilterCVCDelegate {
    func setSelectedCategory(index: Int) {
        
        for var category in self.categoryArray {
            category.selected = false
        }
        
        categoryArray[index].selected = true
        categoryCollectionView.reloadData()
    }
    
    
}
