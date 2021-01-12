//
//  OthersPageVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/09.
//

import UIKit

class OthersPageVC: UIViewController {
    
    //MARK:**- IBOutlet Part**
    @IBOutlet weak var othersPageCollectionView: UICollectionView!
    
    
    //MARK:**- Variable Part**
    let othersPageCVLayout = OthersPageCVFlowLayout()
    
    let othersPageCVC = OthersPageCVC()
    
    private var othersAnswerArray: [Answer] = [] {
        didSet {
            othersPageCollectionView.reloadData()
        }
    }
    
    private var othersProfile: [OthersProfile] = [] {
        didSet {
            othersPageCollectionView.reloadData()
        }
    }
    

    
    //MARK:**- Constraint Part**
    
    //MARK:**- Life Cycle Part**
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        othersPageCollectionView.delegate = self
        othersPageCollectionView.dataSource = self
        
        if #available(iOS 11.0, *) {
            othersPageCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        othersPageCollectionView.collectionViewLayout = othersPageCVLayout
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setAnswerData(userId: 1, page: 1)
        setProfileData(userId: 2)
    }
    //MARK:**- IBAction Part**
    
    
    //MARK:**- default Setting Function Part**
    
    func setKeywordLabel( label : UILabel, keyword: String){
        label.text = keyword
        label.textColor = UIColor.darkGray
        
    }
    
    
    //MARK:**- Function Part**
    
    
    
    
    
}
//MARK:**- extension 부분**
extension OthersPageVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}

extension OthersPageVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OthersPageCVC.identifier,
                for: indexPath) as? OthersPageCVC else {
            return UICollectionViewCell()}
        
        
        
        cell.othersAnswerArray = othersAnswerArray
        print("=====")
        print(cell.othersAnswerArray.count)
        cell.otherspageTableView.reloadData()

        return cell
    }
    
    
    
}

extension OthersPageVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item <= 1 {
            return CGSize(width: collectionView.frame.width  , height: 748)
        }
        else{
            return CGSize(width: collectionView.frame.width  , height: 748)
        }
    }
    
    
    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (section == 0) {
            return CGSize(width: collectionView.frame.width, height: 294)
        } else {
            //refact
            return CGSize.zero
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //    UIEdgeInset
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    // collectionview heaeder 사용
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: OthersPageCRV.identifier, for: indexPath) as? OthersPageCRV else {
                assert(false, "응 아니야")
            }
            
            headerView.othersProfile = othersProfile
            if (othersProfile.count != 0) {
                headerView.setProfile(nickname: othersProfile[0].nickname, img: othersProfile[0].profileImg!, visit: String(othersProfile[0].continuedVisit), answerCount: String(othersProfile[0].answerCount), isFollowed: othersProfile[0].isFollowed)
            }
            
//            headerView.da
            //            othersPageCVLayout.mypageCRVDelegate = headerView
            
            return headerView
        default:
            assert(false, "응 아니야")
            
        }
        
        
    }
}


extension OthersPageVC {
    private func setAnswerData(userId: Int, page: Int) {
        OthersPageAnswerService.shared.getOthersAnswer(userId: userId, page: page) { (result) in
            switch result {
            case .success(let data):
                if let response = data as? OthersAnswer{
                    print(" 성공")
                    
                    
                    self.othersAnswerArray = response.answers
                    print(self.othersAnswerArray[0].answerDate)
                    self.othersPageCollectionView.reloadData()
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    print(" 실패")
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverERr")
            case .networkFail :
                print("networkFail")
            default :
                print("?")
            }
        }
        
        
    }
    
    
    private func setProfileData(userId: Int) {
        OthersPageProfileService.shared.getOthersProfile(userId: userId) { (result) in
            switch result {
            case .success(let data):
                if let othersProfile = data as? OthersProfile{
                    print(" 성공")
                    
                    self.othersProfile.append(othersProfile)
                    
                    
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    print(" 실패")
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverERr")
            case .networkFail :
                print("networkFail")
            default :
                print("?")
            }
        }
        
    }
    
    
}
