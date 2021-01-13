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
    let customEmptyView = CustomEmptyView()
    
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
            if followers.count == 0{
                customEmptyView.setItems(text: "나를 팔로우 한 사람이 없습니다.")
                view.addSubview(customEmptyView)
                customEmptyView.snp.makeConstraints{
                    $0.leading.trailing.equalToSuperview()
                    $0.top.equalToSuperview().offset(157)
                    $0.height.equalTo(80)
                    
                }
            }
            else{
                customEmptyView.removeFromSuperview()
            }
            
            return followers.count
        }
        if searched.count == 0{
            customEmptyView.setItems(text: "검색 결과가 없습니다.")
            view.addSubview(customEmptyView)
            customEmptyView.snp.makeConstraints{
                $0.leading.trailing.equalToSuperview()
                $0.top.equalToSuperview().offset(157)
                $0.height.equalTo(80)
                
            }
        }
        else{
            customEmptyView.removeFromSuperview()
        }
        
        return searched.count
    }
    
    
    
}




extension FollowerSearchVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width-60, height: 40)
            
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
    
    func settingButtonDidTapped(id: Int) {
        print("callll33")
        followAlertDelegate?.showAlert(id: id)
    }
    
}

protocol FollowMoreButtonMidDelegate{
    func settingButtonDidTapped(id: Int)
}
