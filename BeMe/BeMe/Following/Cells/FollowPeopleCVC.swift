//
//  FollowPeopleCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowPeopleCVC: UICollectionViewCell {
    static let identifier : String = "FollowPeopleCVC"
    
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    
    var isFollowing = true
    
    override func awakeFromNib() {
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        
    }
    func changeFollow(){
        if isFollowing == true{
            isFollowing = false
            
        }
        else {
            isFollowing = true
        }
        
    }
    
}



extension FollowPeopleCVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("called")
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FollowPersonCVC.identifier,
                for: indexPath) as? FollowPersonCVC else {return UICollectionViewCell()}
        if isFollowing == true {
            cell.setProfile(userName: "Following")
            
        }
        else{
            cell.setProfile(userName: "Follower")
        }
        
        return cell
            
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
}




extension FollowPeopleCVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: 58  , height: 100)
            
        
      
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right:0)
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
