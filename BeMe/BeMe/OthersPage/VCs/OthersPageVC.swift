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
    
    var tableviewHeight: CGFloat = 0.0
    
    
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
        
//        othersAnswerArray = []
//        othersProfile = []
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
        
        setAnswerData(userId: 2, page: 1)
        setProfileData(userId: 6)
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
        print("otehrspage CV ")
        print(othersAnswerArray[0].id)
        print(othersAnswerArray[0].content)
        print(othersAnswerArray[0].isScrapped!)
        //        print("=====")
        //        print(cell.othersAnswerArray.count)
        //        tableviewHeight = cell.tableviewHeight
        //        print("=====")
        //        print(tableviewHeight)
        cell.otherspageTableView.reloadData()
        
        
        return cell
    }
    
    
    
}

extension OthersPageVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        tableviewHeight = CGFloat(othersAnswerArray.count) * 135.0
        
        //        print("=====")
        //        print(tableviewHeight)
        //        collectionView.cellForItem(at: indexPath)
        return CGSize(width: collectionView.frame.width  , height: tableviewHeight)
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
                headerView.setProfile(nickname: othersProfile[0].nickname, img: othersProfile[0].profileImg!, visit: String(othersProfile[0].continuedVisit), answerCount: String(othersProfile[0].answerCount), isFollowed: othersProfile[0].isFollowed!)
                //                print("othersProfile[0].isFollowed")
                //                print(othersProfile[0].isFollowed)
            }
            
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
                    print("setAnswerData 성공")
                    
                    
                    self.othersAnswerArray = response.answers
                    print("setAnswerData 안에ㅐ서")
                    print(response.answers[0].isScrapped)
                    self.othersPageCollectionView.reloadData()
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    print("setAnswerData 실패")
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
                    print("setProfileData 성공")
                    
                    self.othersProfile.append(othersProfile)
                    
                    
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    print("setProfileData 실패")
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
