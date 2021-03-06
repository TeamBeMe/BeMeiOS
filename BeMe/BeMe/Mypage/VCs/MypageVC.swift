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
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var tmpLabel: UILabel!
    
    
    lazy var popupBackgroundView: UIView = UIView()
    
    private var directionMenu: Int = 0
    
    //MARK:**- Variable Part**
    let mypageCVLayout = MypageCVFlowLayout()
    
    private var filterVCDelegate: FilterVCDelegate?
    
    let mypageCVC = MypageCVC()
    
    static var selectedAvailablity: String?
    
    static var selectedCategory: Int?
    
    private var selectedCategoryId: Int?
    
    private var selectedAv: String?
    
    private var keyword: String?
    
    
    var tableviewHeight: CGFloat = 393.0
    var pastTableViewHeight: CGFloat = 393.0
    
    var scraptableviewHeight: CGFloat = 393.0
    var scrappastTableViewHeight: CGFloat = 393.0
    var myPageForServer = 1
    var otherPageForServer = 1
    var myPageLen = 1
    var otherPageLen = 1
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
    var chosenImage: UIImage?
    lazy var imagePickerController = UIImagePickerController().then {
        $0.sourceType = .photoLibrary
        //        $0.allowsEditing = true
        $0.delegate = self
    }
    //MARK:**- Constraint Part**
    
    //MARK:**- Life Cycle Part**
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        popupBackgroundView.setPopupBackgroundView(to: view)
        mypageCollectionView.delegate = self
        mypageCollectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissCategory), name: .init("categoryClose"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getKeyword), name: .init("keyword"), object: nil)
        
        if #available(iOS 11.0, *) {
            mypageCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        mypageCollectionView.collectionViewLayout = mypageCVLayout
        
    }
    
    @objc func getKeyword(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let keyword = userInfo["keyword"] as? String else { return }
        
        self.keyword = keyword
        
    }
    
    
    @objc func dismissCategory(_ notification: Notification) {
        popupBackgroundView.animatePopupBackground(false)
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        
        guard let categoryId = userInfo["categoryId"] as? Int? else { return  }
        print("First")
        guard let selectedAv = userInfo["selectedAv"] as? String else { return }
        print("Second")
        self.selectedAv = selectedAv
        self.selectedCategoryId = categoryId == nil ? 1 : categoryId! + 1
        
        MypageVC.selectedAvailablity = selectedAv
        MypageVC.selectedCategory = selectedCategoryId
        
        getAnswerData(availability: selectedAv, category: selectedCategoryId, page: myPageForServer, query: keyword)
        getScrapData(availability: selectedAv, category: selectedCategoryId, page: otherPageForServer, query: keyword)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(myPageUpdate), name: .myPageUpdate, object: nil)
        getProfileData()
        getAnswerData(availability: "all", category: nil, page: 1, query: "")
    }
    
    //MARK:**- IBAction Part**
    
    @IBAction func settingButtonTapped(_ sender: Any) {
        
        guard let setting = UIStoryboard.init(name: "Setting", bundle: nil).instantiateViewController(identifier: "SettingVC") as? SettingVC else { return }
        
        self.navigationController?.pushViewController(setting, animated: true)
    }
    
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
    
    func goToCommentButtonTapped(_ answerId: Int) {
        guard let comment = UIStoryboard.init(name: "Comment", bundle: nil).instantiateViewController(identifier: "CommentVC") as? CommentVC else { return }
        comment.answerId = answerId
        comment.isMoreButtonHidden = false
        comment.modalPresentationStyle = .fullScreen
        let nc = UINavigationController(rootViewController: comment)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true, completion: nil)
    }
    
    @objc func myPageUpdate(){
        
        if myPageForServer < myPageLen {
            print("마이페이지업데이트")
            myPageForServer += 1
            getAnswerData(availability: selectedAv, category: selectedCategoryId, page: myPageForServer, query: keyword)
        }
        
        
    }
    @objc func scrapUpdate(){
        
        if otherPageForServer < otherPageLen {
            print("스크랩업데이트")
            otherPageForServer += 1
            getScrapData(availability: selectedAv, category: selectedCategoryId, page: otherPageForServer, query: keyword)
            
        }
        
        
    }
    
}
//MARK:**- extension 부분**

extension MypageVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

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
        cell.profileEditDelegate = self
        cell.mypageTabCollectionView.reloadData()
        cell.mypageCVCDelegate = self
        return cell
    }
    
    
    
}

extension MypageVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if tableviewHeight != 0 {
            pastTableViewHeight = tableviewHeight
            
        }
        
        if scraptableviewHeight != 0 {
            scrappastTableViewHeight = scraptableviewHeight
        }
        
        if directionMenu == 0 {
            //            tableviewHeight = (CGFloat(myAnswerArray.count) * 105.0 > 0) ? CGFloat(myAnswerArray.count) * 105.0 : 735
            tableviewHeight = 0
            if myAnswerArray.count > 0 {
                for i in 0...myAnswerArray.count-1 {
                    tmpLabel.text = myAnswerArray[i].question
                    tableviewHeight += CGFloat(tmpLabel.calculateMaxLabelLines())*18.0 + 69.0
                }
            }
            return CGSize(width: collectionView.frame.width  , height: tableviewHeight+100.0)
        } else {
            
            scraptableviewHeight = 0
            if myScrapArray.count > 0 {
                for i in 0...myScrapArray.count-1 {
                    tmpLabel.text = myScrapArray[i].question
                    scraptableviewHeight += CGFloat(tmpLabel.calculateMaxLabelLines())*18.0 + 99.0
                }
            }
            return CGSize(width: collectionView.frame.width  , height: scraptableviewHeight+100.0)
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
                return UICollectionReusableView()
            }
            headerView.categoryDelegte = self
            headerView.delegate = self
            headerView.profileEditDelegate = self
            headerView.myProfile = myProfile
            headerView.MypageCRVDelegate = self
            print("박세란")
            
            
            if (myProfile.count != 0) {
                
                headerView.setProfile(nickname: myProfile[0].nickname, img: myProfile[0].profileImg!, visit: String(myProfile[0].continuedVisit), answerCount: String(myProfile[0].answerCount))
            }
            if chosenImage != nil{
                headerView.setProfileImage(img: chosenImage!)
            }
            
            
            return headerView
        default:
            assert(false, "응 아니야")
            
        }
        return UICollectionReusableView()
        
    }
}

extension MypageVC: CategorySelectedProtocol {
    func categoryButtonDidTapped() {
        popupBackgroundView.animatePopupBackground(true)
        guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: .main).instantiateViewController(withIdentifier: "CustomActionSheetFilterVC") as?
                CustomActionSheetFilterVC else { return }
        settingActionSheet.modalPresentationStyle = .overCurrentContext
        self.present(settingActionSheet, animated: true, completion: nil)
    }
}

extension MypageVC: MypageCVCDelegate {
    
    func myAnswerItem() {
        directionMenu = 0
        getAnswerData(availability: selectedAv, category: selectedCategoryId, page: 1, query: keyword)
        mypageCollectionView.reloadData()
    }
    
    func myScrapItem() {
        directionMenu = 1
        getScrapData(availability: selectedAv, category: selectedCategoryId, page: 1, query: keyword)
        mypageCollectionView.reloadData()
    }
    
    func nowDirection() -> Int {
        return directionMenu
    }
    
    
    
}

extension MypageVC {
    
    private func getAnswerData(availability: String?, category: Int?, page: Int, query: String?) {
        
        print("GETANSWERDATA")
        print(category)
        MyPageAnswerService.shared.getMyAnswer(availability: availability, category: category, page: page, query: query) { (result) in
            switch result {
            case .success(let data):
                if let response = data as? MyAnswer{
                    if page == 1 {
                        self.myAnswerArray = response.answers
                    }
                    else {
                        for ans in response.answers {
                            self.myAnswerArray.append(ans)
                        }
                        
                        
                    }
                    self.myPageLen = response.pageLen
                    self.mypageCollectionView.reloadData()
                    print("MypageVC getAnswerData 성공")
                    print(self.myAnswerArray)
                    print(response.answers.count)
                    print(availability)
                    print(category)
                    print(page)
                    print(query)
                    
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
                    if page == 1 {
                        self.myScrapArray = response.answers
                    }
                    else {
                        for ans in response.answers {
                            self.myScrapArray.append(ans)
                        }
                    }
                    self.otherPageLen = response.pageLen
                    self.mypageCollectionView.reloadData()
                    print("MypageVC getScrapData 성공")
                    print(self.myScrapArray)
                    print(response.answers.count)
                    print(availability)
                    print(category)
                    print(page)
                    print(query)
                    
                    
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
                    self.mypageCollectionView.reloadData()
                    
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
                break
            }
        }
        
    }
}

extension MypageVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset < 91.0 {
            settingButton.isHidden = false
        } else {
            settingButton.isHidden = true
        }
        print(offset)
        
        
        
        if directionMenu == 0 {
            print(tableviewHeight)
            print(pastTableViewHeight)
            if offset > tableviewHeight - pastTableViewHeight - 100 {
                myPageUpdate()
            }
        }
        else {
            print(scraptableviewHeight)
            print(scrappastTableViewHeight)
            
            if offset > scraptableviewHeight - scrappastTableViewHeight - 100 {
                scrapUpdate()
            }
        }
        
        
        
    }
    
}

extension MypageVC: ProfileEditDelegate{
    
    func profileEdit(){
        self.present(self.imagePickerController, animated: true, completion: nil)
        
    }
    func cardTapped(answerID: Int){
        goToCommentButtonTapped(answerID)
        
        
    }
    func showToast(showBool: Bool){
        let showText = showBool == true ? "비공개 답변으로 변경되었습니다" : "공개 답변으로 변경되었습니다"
        print("왜?")
        self.showToast(text: showText)
    }
}


extension MypageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        chosenImage = info[.originalImage] as? UIImage
        let shittyVC = ShittyImageCropVC(frame: (self.navigationController?.view.frame)!, image: chosenImage!, aspectWidth: 315, aspectHeight: 152)
        shittyVC.signUpProfileImageSetDelegate = self
        self.dismiss(animated: true, completion: {
            self.navigationController?.present(shittyVC, animated: true, completion: nil)
        })
        
    }
    
    
    
}

extension MypageVC: SignUpProfileImageSetDelegate{
    func setImage(img: UIImage) {
        chosenImage  = img
        MyPageProfileService.shared.setMyProfile(image: chosenImage!) {(networkResult) -> (Void) in
            switch networkResult{
            case .success(let data) :
                print("프로필 수정 성공")
                self.getProfileData()
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
    }
}
protocol FilterVCDelegate {
    func getSeletedCategory() -> Int?
    func getSeletedAvailabity() -> String
}


protocol ProfileEditDelegate{
    func profileEdit()
    func cardTapped(answerID: Int)
    func showToast(showBool: Bool)
}

extension MypageVC: MypageCRVDelegate{
    func searchButtonSearch() {
        if directionMenu == 0 {
            myAnswerItem()
        } else {
            myScrapItem()
        }
    }
    
    func deleteButtonSearch() {
        if directionMenu == 0 {
            myAnswerItem()
        } else {
            myScrapItem()
        }
    }
    
    
}

