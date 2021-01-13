//
//  MypageVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/03.
//

import UIKit

class MypageVC: UIViewController {
    
    //MARK:**- IBOutlet Part**
    @IBOutlet weak var mypageCollectionView: UICollectionView!
    
    
    private var directionMenu: Int = 0
    
    //MARK:**- Variable Part**
    let mypageCVLayout = MypageCVFlowLayout()
    
    let mypageCVC = MypageCVC()
    
    private var myAnswerArray: [Answer] = [] {
        didSet {
            mypageCollectionView.reloadData()
        }
    }
    private var myScrapArray: [Answer] = [] {
        didSet {
            mypageCollectionView.reloadData()
        }
    }
    
    private var myProfile: [MyProfile] = [] {
        didSet {
            mypageCollectionView.reloadData()
        }
    }
    
    
    //MARK:**- Constraint Part**
    
    //MARK:**- Life Cycle Part**
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mypageCollectionView.delegate = self
        mypageCollectionView.dataSource = self
        
        if #available(iOS 11.0, *) {
            mypageCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        mypageCollectionView.collectionViewLayout = mypageCVLayout
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getProfileData()
        getAnswerData(availability: "", category: nil, page: -1, query: "")
    }
    
    //MARK:**- IBAction Part**
    
    
    //MARK:**- default Setting Function Part**
    
    
    func setSearhButton(view: UIButton) {
        view.setBorderWithRadius(borderColor: .veryLightPinkTwo, borderWidth: 1, cornerRadius: 6)
        view.backgroundColor = UIColor.veryLightPinkTwo
    }
    
    
    // 아래 두 함수는 TVC 뿐만 아니라 여러 곳에서 사용가능
    // 검색어를 삭제했거나 , 초기 화면
    func setKeywordLabel(label : UILabel){
        label.text = "검색"
        label.textColor = UIColor.rgb8E8E93
    }
    
    // 검색 결과 후
    func setKeywordLabel( label : UILabel, keyword: String){
        label.text = keyword
        label.textColor = UIColor.darkGray
        
    }
    
    
    //MARK:**- Function Part**
    
    
}
//MARK:**- extension 부분**
extension MypageVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}

extension MypageVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MypageCVC.identifier,
                for: indexPath) as? MypageCVC else {
            return UICollectionViewCell()}
        
        cell.scrollDirection(by: directionMenu)
        
        cell.myAnswerArray = myAnswerArray
        cell.myScrapArray = myScrapArray

        cell.mypageTabCollectionView.reloadData()
        cell.mypageCVCDelegate = self
        return cell
    }
    
    
    
}

extension MypageVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        //            layout.sectionHeadersPinToVisibleBounds = true
        //        }
        
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
            return CGSize(width: collectionView.frame.width, height: 393)
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
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MypageCRV.identifier, for: indexPath) as? MypageCRV else {
                assert(false, "응 아니야")
            }
            headerView.delegate = self
            headerView.myProfile = myProfile
            if (myProfile.count != 0) {
                headerView.setProfile(nickname: myProfile[0].nickname, img: myProfile[0].profileImg!, visit: String(myProfile[0].continuedVisit), answerCount: String(myProfile[0].answerCount))
            }
            
            return headerView
        default:
            assert(false, "응 아니야")
            
        }
        
        
    }
}

extension MypageVC: MypageCVCDelegate {
    
    func myAnswerItem() {
        directionMenu = 0
        getAnswerData(availability: "", category: 2, page: 1, query: "")
        mypageCollectionView.reloadData()
    }
    
    func othersAnswerItem() {
        directionMenu = 1
        getScrapData(availability: "", category: 1, page: 1, query: "")
        mypageCollectionView.reloadData()
    }
    
    func nowDirection() -> Int {
        print("directionMenu")
        print(directionMenu)
        return directionMenu
    }
    
    
    
}

extension MypageVC {
    private func getAnswerData(availability: String?, category: Int?, page: Int, query: String?) {
        MyPageAnswerService.shared.getMyAnswer(availability: availability, category: category, page: page, query: query) { (result) in
            switch result {
            case .success(let data):
                if let response = data as? MyAnswer{
                    print("getAnswerData 성공")
                    self.myAnswerArray = response.answers
//                    print("getAnswerData 안에서")
//                    print(response)
                    self.mypageCollectionView.reloadData()
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    print("getAnswerData 실패")
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
    private func getScrapData(availability: String?, category: Int?, page: Int, query: String?) {
        MyPageScrapService.shared.getMyScrap(availability: availability, category: category, query: query, page: page) { (result) in
            switch result {
            case .success(let data):
                if let response = data as? MyScrap{
                    print("getScrapData 성공")
                    self.myScrapArray = response.answers
//                    print("getScrapData 안에서")
//                    print(response)
                    self.mypageCollectionView.reloadData()
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    print("getScrapData 실패")
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
    private func getProfileData() {
        MyPageProfileService.shared.getMyProfile() { (result) in
            switch result {
            case .success(let data):
                if let othersProfile = data as? MyProfile{
                    print("MypageVC getProfileData 성공")
                    
                    self.myProfile.append(othersProfile)
                    
                    
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    print("MypageVC getProfileData 실패")
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
    
    private func setProfileData(image: UIImage) {
        MyPageProfileService.shared.setMyProfile(image: image) { (result) in
            switch result {
            case .success(let data):
                if let othersProfile = data as? MyProfile{
                    print("MypageVC setProfileData 성공")
                    
                    self.myProfile.append(othersProfile)
                    
                    
                    
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    print("MypageVC setProfileData 실패")
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
