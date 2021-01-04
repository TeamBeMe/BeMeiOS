//
//  FollowPeopleCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowPeopleCVC: UICollectionViewCell {
    static let identifier : String = "FollowPeopleCVC"
    var i = 0
    var totalCell = 10
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    
    var isFollowing = true
    var mTimer : Timer?
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
    @objc func timerCallback(){
        i = i + 1
        self.peopleCollectionView.performBatchUpdates({
            self.peopleCollectionView.reloadItems(at: [IndexPath(item: i-1, section: 0)])
        }, completion: { finished in
           
        
        })
        if i>=totalCell {
            mTimer?.invalidate()
            i = 0
        }
        
    }
}



extension FollowPeopleCVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
        return totalCell
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

extension FollowPeopleCVC : FollowingFollowButtonDelegate{
    func followButtonAction() {
        if isFollowing{
            isFollowing = false
//            UIView.animate(withDuration: 0.5, animations: {
//                self.alpha = 0
//
//            }, completion: { finished in
//                UIView.animate(withDuration: 0.5, animations: {
//                    self.peopleCollectionView.reloadData()
//                    self.alpha = 1
//                })
//
//
//            })
           
            mTimer = Timer.scheduledTimer(timeInterval: Double(1/Double(totalCell)), target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
            

           
            
        }

    }
    
    
   
    
}

extension FollowPeopleCVC : FollowingFollowingButtonDelegate{
    func followingButtonAction() {
        if !isFollowing{
            isFollowing = true
//            UIView.animate(withDuration: 0.5, animations: {
//                self.alpha = 0
//
//            }, completion: { finished in
//                UIView.animate(withDuration: 0.5, animations: {
//                    self.peopleCollectionView.reloadData()
//                    self.alpha = 1
//                })
//
//
//            })
            mTimer = Timer.scheduledTimer(timeInterval: Double(1/Double(totalCell)), target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)

  
        }
    }
}



