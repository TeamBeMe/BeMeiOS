//
//  FollowingSearchVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowingSearchVC: UIViewController {
    
    
    @IBOutlet weak var wholeCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    let customEmptyView = CustomEmptyView()

    var followees: [FollowingFollows] = []
    var searched: [FindPeopleSearchData] = []
    var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        wholeCollectionView.delegate = self
        wholeCollectionView.dataSource = self
        searchTextField.addLeftPadding(left: 23)
        searchTextField.backgroundColor = .veryLightPinkTwo
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    

    
    
    
    

}



extension FollowingSearchVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        if isSearching == false {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowingListCVC.identifier,
                    for: indexPath) as? FollowingListCVC else {return UICollectionViewCell()}
            
            cell.followingPerson = followees[indexPath.item]
            cell.setItems()
            return cell
            
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowingListCVC.identifier,
                    for: indexPath) as? FollowingListCVC else {return UICollectionViewCell()}
            
            cell.findPeopleSearchData = searched[indexPath.item]
            cell.setSearchedItem()
            return cell
            
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if isSearching == false{
            if followees.count == 0{
                customEmptyView.setItems(text: "팔로잉 한 사람이 없습니다.")
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
            
            return followees.count
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

extension FollowingSearchVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        FindPeopleSearchService.shared.search(findID: searchTextField.text!,
                                              isFollowing: 1){(networkResult) -> (Void) in
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

