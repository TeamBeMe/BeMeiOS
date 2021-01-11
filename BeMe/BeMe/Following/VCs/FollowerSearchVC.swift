//
//  FollowerSearchVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowerSearchVC: UIViewController {
    @IBOutlet weak var wholeCollectionView: UICollectionView!
    var followers: [FollowingFollows] = []
    var searched: [FindPeopleSearchData] = []
    var isSearching = false
    @IBOutlet weak var searchTextField: UITextField!
    var followAlertDelegate: FollowAlertDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wholeCollectionView.delegate = self
        wholeCollectionView.dataSource = self
        searchTextField.addLeftPadding(left: 23)
        searchTextField.backgroundColor = .veryLightPinkTwo
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        searchTextField.delegate = self
    }
    

  

}
extension FollowerSearchVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
 
         if !isSearching {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowerListCVC.identifier,
                    for: indexPath) as? FollowerListCVC else {return UICollectionViewCell()}
            cell.tableViewDelegate = self
            cell.followerPerson = followers[indexPath.item]
            cell.setItems()
            return cell
            
        }
         else{
             guard let cell = collectionView.dequeueReusableCell(
                     withReuseIdentifier: FollowerListCVC.identifier,
                     for: indexPath) as? FollowerListCVC else {return UICollectionViewCell()}
            cell.tableViewDelegate = self
             cell.findPeopleSearchData = searched[indexPath.item]
             cell.setSearchedItem()
             return cell
             
         }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if isSearching == false{
            return followers.count
        }
        return searched.count
    }
    
    
}




extension FollowerSearchVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width-60, height: 36)
            
        }
        else {
            return CGSize(width: collectionView.frame.width-60 , height: 40)
            
        }
      
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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

extension FollowerSearchVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        FindPeopleSearchService.shared.search(findID: searchTextField.text!,
                                              isFollowing: 2){(networkResult) -> (Void) in
            switch networkResult{
            case .success(let data) :
                self.searched = []
                print(self.searchTextField.text!)
                if let searchedData = data as? FindPeopleSearchData{


                    self.searched.append(searchedData)


                }
                self.wholeCollectionView.reloadData()
                print("success")
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")

            }
            

        }
        
        
        
        
        return true
    }
    
    @objc func textFieldDidChange(){
        if searchTextField.text != ""{
            isSearching = true
            wholeCollectionView.reloadData()
        }
        else{
            isSearching = false
            wholeCollectionView.reloadData()
        }

    }
    
}



extension FollowerSearchVC: FollowMoreButtonMidDelegate {
    
    func settingButtonDidTapped() {
        print("callll33")
        followAlertDelegate?.showAlert()
    }

}

protocol FollowMoreButtonMidDelegate{
    func settingButtonDidTapped()
}
