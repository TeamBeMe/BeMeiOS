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
    var followScrapButtonDelegate: FollowScrapButtonDelegate?
    var shows: [FollowingFollows] = []
    var followers: [FollowingFollows] = []
    var followees: [FollowingFollows] = []
    var followerCustomEmptyView = CustomEmptyView()
    
    var isFollowing = true
    var mTimer : Timer?
    override func awakeFromNib() {
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        totalCell = followees.count
        shows = followees
        
    }
    func changeFollow(){
        if isFollowing == true{
            isFollowing = false
            shows = followers
        }
        else {
            isFollowing = true
            shows = followees
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
            totalCell = shows.count
            self.peopleCollectionView.reloadData()
            
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
       
        let profileURL = shows[indexPath.item].profileImg ?? ""
        
        cell.setProfile(userName: shows[indexPath.item].nickname!,
                        profileImageURL: profileURL)
        cell.followingFollows = shows[indexPath.item]
        cell.personToPeopleDelegate = self
        return cell
            
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if shows.count == 0{
            self.addSubview(followerCustomEmptyView)
            
            
            followerCustomEmptyView.snp.makeConstraints{
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(20)
                $0.height.equalTo(100)
                
                
            }
            if isFollowing{
                followerCustomEmptyView.setItems(text: "회원님이 팔로우 하는 사람들이 여기에 표시됩니다")
            }
            else{
                followerCustomEmptyView.setItems(text: "회원님을 팔로우 하는 사람들이 여기에 표시됩니다")
            }
            followerCustomEmptyView.setImage(image: UIImage(named: "icIdsearch")!)
            
        }
        else{
            followerCustomEmptyView.removeFromSuperview()
        }

        return shows.count
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
            shows = followers
//            mTimer = Timer.scheduledTimer(timeInterval: Double(1/Double(totalCell)), target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
            print(shows)
            peopleCollectionView.reloadData()
           
            
        }

    }
    
    
   
    
}

extension FollowPeopleCVC : FollowingFollowingButtonDelegate{
    func followingButtonAction() {
        if !isFollowing{
            isFollowing = true
            shows = followees
//            mTimer = Timer.scheduledTimer(timeInterval: Double(1/Double(totalCell)), target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
            print(shows)
            peopleCollectionView.reloadData()
  
        }
    }
}

extension FollowPeopleCVC: PersonToPeopleDelegate {
    func med(userID: Int) {
        followScrapButtonDelegate?.profileSelectedTap(userID: userID)
    }
}




protocol PersonToPeopleDelegate {
    
    func med(userID: Int)
}
