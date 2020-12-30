//
//  FollowingSearchVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowingSearchVC: UIViewController {
    
    
    @IBOutlet weak var wholeCollectionView: UICollectionView!
    
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        wholeCollectionView.delegate = self
        wholeCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    
    
    
    

}



extension FollowingSearchVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowingSearchCVC.identifier,
                    for: indexPath) as? FollowingSearchCVC else {return UICollectionViewCell()}
            
            
            return cell
            
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowingListCVC.identifier,
                    for: indexPath) as? FollowingListCVC else {return UICollectionViewCell()}
            
            
            return cell
            
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    
}




extension FollowingSearchVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width - 60, height: 36)
            
        }
        else {
            return CGSize(width: collectionView.frame.width - 60 , height: 40)
            
        }
      
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
        
    }
    
    
    
}

