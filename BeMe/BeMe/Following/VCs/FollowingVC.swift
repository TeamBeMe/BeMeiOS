//
//  FollowingVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowingVC: UIViewController {

    @IBOutlet weak var upperContainerView: UIView!
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followerButton: UIButton!
    
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var barButton: UIButton!
   
    @IBOutlet weak var wholeCollectionView: UICollectionView!
    
    var isFollowing = true
    var followShouldBeChanged = false
    var totalCell = 13
    var followingFollowButtonDelegate : FollowingFollowButtonDelegate?
    var followingFollowingButtonDelegate : FollowingFollowingButtonDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
       
        
    }
    
    
    
    
    @IBAction func followerButtonAction(_ sender: Any) {

        followerButton.tintColor = .black
        followingButton.tintColor = .lightGray
       
       
       
        
    }
    
    
    @IBAction func followingButtonAction(_ sender: Any) {
        

        followerButton.tintColor = .lightGray
        followingButton.tintColor = .black
        UIView.animate(withDuration: 0.3, animations: {
            self.underLineView.transform = .identity
            
        })
        if !isFollowing {
            isFollowing = true
            followShouldBeChanged = true
            wholeCollectionView.reloadData()
        }
        
    }
    
    
    
    @IBAction func barButtonAction(_ sender: Any) {
      
        
        
    }
    
    
}



//MARK:- User Define Functions
extension FollowingVC {
    
    func setItems(){

        wholeCollectionView.dataSource = self
        wholeCollectionView.delegate = self
        
        
    }
    
    
    
    
    
    
}




extension FollowingVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowUpperCVC.identifier,
                    for: indexPath) as? FollowUpperCVC else {return UICollectionViewCell()}
            cell.followingBarButtonDelegate = self
            cell.followPeopleCollectionViewDelegate = self
            cell.followingPeopleCollectionViewDelegate = self
            
            return cell
            
        }
        
        
        else if indexPath.item == 1{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowPeopleCVC.identifier,
                    for: indexPath) as? FollowPeopleCVC else {return UICollectionViewCell()}
            followingFollowButtonDelegate = cell
            followingFollowingButtonDelegate = cell

            
            return cell
            
        }
        else if indexPath.item == 2{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowHeaderCVC.identifier,
                    for: indexPath) as? FollowHeaderCVC else {return UICollectionViewCell()}
            
            
            return cell
            
        }
        else if indexPath.item == totalCell-1 {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowMoreButtonCVC.identifier,
                    for: indexPath) as? FollowMoreButtonCVC else {return UICollectionViewCell()}
            cell.followingMoreButtonDelegate = self
            
            return cell
            
        }
        
        else {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowCardCVC.identifier,
                    for: indexPath) as? FollowCardCVC else {return UICollectionViewCell()}
            
            
            return cell
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return totalCell
    }
    
    
}




extension FollowingVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0{
            return CGSize(width: collectionView.frame.width , height: 101)
        }
        
        else if indexPath.item == 1 {
            return CGSize(width: collectionView.frame.width , height: 150)
            
        }
        else if indexPath.item == 2{
            return CGSize(width: collectionView.frame.width , height: 80)
        }
        else if indexPath.item == totalCell-1 {
            return CGSize(width: collectionView.frame.width , height: 70)
            
        }
        else {
            return CGSize(width: collectionView.frame.width  , height: 313)
            
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
        return 0
        
    }
    
    
    
}


extension FollowingVC : FollowingMoreButtonDelegate {
    func moreButtonAction() {
        totalCell += 10
        wholeCollectionView.reloadData()
    }
}

extension FollowingVC : FollowingBarButtonDelegate{
    func barButtonAction() {
        guard let vcName = UIStoryboard(name: "FollowSearch",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "FollowSearchVC") as? FollowSearchVC
            else{
                
                return
        }
        
        vcName.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vcName, animated: true)
    }
    
}
extension FollowingVC : FollowingPeopleCollectionViewDelegate{
    func followingPeopleUpdate() {
        followingFollowingButtonDelegate?.followingButtonAction()
    }
    
}
extension FollowingVC : FollowPeopleCollectionViewDelegate{
    func followPeopleUpdate() {
        followingFollowButtonDelegate?.followButtonAction()
        
    }
}

extension FollowingVC : FollowingTabBarDelegate{
    func followButtonTapped() {
       

        self.wholeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                              at: .top,
                                        animated: true)
     
    
        
    }
}

protocol FollowingTabBarDelegate{
    func followButtonTapped()
    
}

protocol FollowingPeopleCollectionViewDelegate{
    func followingPeopleUpdate()
    
    
    
}
protocol FollowPeopleCollectionViewDelegate{
    func followPeopleUpdate()
    
    
    
}


protocol FollowingMoreButtonDelegate{
    func moreButtonAction()
    
    
}

protocol FollowingBarButtonDelegate{
    func barButtonAction()
    
    
}

protocol FollowingFollowButtonDelegate{
    func followButtonAction()
    
}
protocol FollowingFollowingButtonDelegate{
    func followingButtonAction()
    
}


