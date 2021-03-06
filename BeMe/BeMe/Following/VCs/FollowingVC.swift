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
    var scrollDirection: Bool = true
    var lastContentOffset: CGFloat = 0.0
    var lastIndexpath = IndexPath(item: 0, section: 0)
    @IBOutlet weak var wholeCollectionView: FollowingWholeCV!
    var isScrolled = true
    var answers: [FollowingAnswers] = []
    var answerPage = 1
    var isLoading = false
    var isFollowing = true
    var followShouldBeChanged = false
    var totalCell = 11
    var followingFollowButtonDelegate : FollowingFollowButtonDelegate?
    var followingFollowingButtonDelegate : FollowingFollowingButtonDelegate?
    var curPage = 0
    var lastInset = CGPoint(x: 0, y: 0)
    var lastY: CGFloat = 0.0
    var followers: [FollowingFollows] = []
    var followees: [FollowingFollows] = []
    var followingToScrapDelegate: FollowingToScrapDelegate?
    
    var customEmptyView = CustomEmptyView()
    var pageLen = 0
    
    var savedAnswers: [FollowingAnswers] = []
    
    static var fromWhichView = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        setItems()
//        let loadingFrame = CGRect(x: 0, y: 155, width: view.frame.width, height: view.frame.height-155)
//        LoadingHUD.show(loadingFrame: loadingFrame,color: .white)
//        isLoading = true
        //        getAnswerData()
        //        getFirstPageAnswerData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFollowData()
        print("zz")
        print(FollowingVC.fromWhichView)
        
        switch FollowingVC.fromWhichView{
        case 0:
            print("upupupup")
            getUpdateAnswers()
        case 1:
            wholeCollectionView.reloadData()
            FollowingVC.fromWhichView = 0
            
        default:
            
            
            print("1")
        }
        print("캐리?")
        
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewwilldisappear")
        isScrolled = false
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
    
    func getFollowData(){
        
        
        FollowingGetService.shared.getHomeData() {(networkResult) -> (Void) in
            switch networkResult{
            case .success(let data) :
                self.followers = []
                self.followees = []
                
                if let followDatas = data as? FollowingGetData{
                    for f in followDatas.followers {
                        self.followers.append(f)
                    }
                    for f in followDatas.followees {
                        self.followees.append(f)
                    }
                    
                    
                }
                self.wholeCollectionView.reloadData()
                
                
                
                //                self.wholeCollectionView.reloadData()
                print(self.followees)
                print(self.followers)
                
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
    
    
    func getAnswerData(){
        
        answerPage += 1
//        let loadingFrame = CGRect(x: 0, y: view.frame.height-87, width: view.frame.width, height: 87)
//        if isLoading == false{
//            LoadingHUD.show(loadingFrame: loadingFrame,color: .white)
//            isLoading = true
//        }
        let pastSize = answers.count
        FollowingGetAnswersService.shared.getAnswerData(page: answerPage){(networkResult) -> (Void) in
            switch networkResult{
            case .success(let data) :
                if let answerDatas = data as? FollowingAnswersData {
                    self.pageLen = answerDatas.pageLen
                    for answerData in answerDatas.answers{
                        self.answers.append(answerData)
                    }
                    
                }
                self.wholeCollectionView.reloadData()
                LoadingHUD.hide()
                if self.answers.count == 0{
                    self.customEmptyView.setItems(text: "아이쿠..! 아직 팔로우하는 사람이 없군요\n팔로잉을 하고 다른 사람들의 글을 둘러보세요")
                    self.wholeCollectionView.addSubview(self.customEmptyView)
                    print(self.customEmptyView.superview?.bounds.minX)
                    self.customEmptyView.snp.makeConstraints{
                        $0.centerX.equalToSuperview()
                        $0.top.equalToSuperview().offset(362)
                        $0.height.equalTo(80)
                    }
                    
                }
                else{
                    self.customEmptyView.removeFromSuperview()
                }
                
//                self.wholeCollectionView.reloadDataWithCompletion {
//                    LoadingHUD.hide()
//                    if self.answers.count == 0{
//                        self.customEmptyView.setItems(text: "아이쿠..! 아직 팔로우하는 사람이 없군요\n팔로잉을 하고 다른 사람들의 글을 둘러보세요")
//                        self.wholeCollectionView.addSubview(self.customEmptyView)
//                        print(self.customEmptyView.superview?.bounds.minX)
//                        self.customEmptyView.snp.makeConstraints{
//                            $0.centerX.equalToSuperview()
//                            $0.top.equalToSuperview().offset(362)
//                            $0.height.equalTo(80)
//                        }
//
//                    }
//                    else{
//                        self.customEmptyView.removeFromSuperview()
//                    }
//
//                }
                //                self.wholeCollectionView.reloadData()
                //                DispatchQueue.main.async {
                //                    let indexPath = NSIndexPath(item: self.wholeCollectionView.numberOfItems(inSection: 3)+200, section: 3)
                //                    LoadingHUD.hide()
                //                    self.isLoading = false
                //
                //                }
                print(self.answers)
                print("success")
            //                if self.answers.count > pastSize{
            //                    self.answerPage = self.answerPage+1
            //                }
            //                else{
            //
            //                }
            
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
    
    func updateDataOnePage(){
        
        curPage += 1
        let loadingFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        FollowingGetAnswersService.shared.getAnswerData(page: curPage){(networkResult) -> (Void) in
            switch networkResult{
            case .success(let data) :
                if let answerDatas = data as? FollowingAnswersData {
                    self.pageLen = answerDatas.pageLen
                    for answerData in answerDatas.answers{
                        self.answers.append(answerData)
                    }
                    
                }
                if self.curPage < self.answerPage {
                    self.updateDataOnePage()
                }
                else{
                    DispatchQueue.global(qos: .background).sync {
                        self.wholeCollectionView.reloadData()
                        self.wholeCollectionView.setContentOffset(CGPoint(x: 0, y: self.lastY), animated: false)
                    }
                    
                    LoadingHUD.hide()
                    if self.answers.count == 0{
                        self.customEmptyView.setItems(text: "아이쿠..! 아직 팔로우하는 사람이 없군요\n팔로잉을 하고 다른 사람들의 글을 둘러보세요")
                        self.wholeCollectionView.addSubview(self.customEmptyView)
                        print(self.customEmptyView.superview?.bounds.minX)
                        self.customEmptyView.snp.makeConstraints{
                            $0.centerX.equalToSuperview()
                            $0.top.equalToSuperview().offset(362)
                            $0.height.equalTo(80)
                        }
                       
        
                    }
                    else{
                        self.customEmptyView.removeFromSuperview()
                    }
        
                  
                }

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
    
    func getUpdateAnswers(){
        let loadingFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        LoadingHUD.show(loadingFrame: loadingFrame,color: .white)
        curPage = 0
        answers = []
        updateDataOnePage()
    }
    
    func goToMoreAnswerButtonDidTapped(questionId: Int, question: String) {
        guard let detail = UIStoryboard(name: "Explore", bundle: nil).instantiateViewController(identifier: "ExploreDetailVC") as?
                ExploreDetailVC else { return }
        detail.questionId = questionId
        detail.questionText = question
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func goToCommentButtonTapped(_ answerId: Int) {
        guard let comment = UIStoryboard.init(name: "Comment", bundle: nil).instantiateViewController(identifier: "CommentVC") as? CommentVC else { return }
        comment.answerId = answerId
        comment.isMoreButtonHidden = false
        comment.modalPresentationStyle = .fullScreen
        let nc = UINavigationController(rootViewController: comment)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true, completion: nil)
    }
    
    private func scrapAnswer(answerId: Int,wasScrapped: Bool,indexInVC: Int) {
        
        ExploreAnswerScrapService.shared.putExploreAnswerScrap(answerId: answerId) { (result) in
            switch result {
            case .success(let data):
                
                guard let dt = data as? GenericResponse<Int> else { return }
                print(dt.message)
                if dt.message == "스크랩 성공" || dt.message == "스크랩 취소 성공" {
                    //                    self.followingToScrapDelegate?.setScrap(wasScrapped: wasScrapped)
                    self.answers[indexInVC].isScrapped = !wasScrapped
                    self.wholeCollectionView.reloadData()
                } else {
                    // 사용자한테 실패했다고 알려주는 동작
                }
                
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                
            case .pathErr: print("path")
            case .serverErr:
                let alertViewController = UIAlertController(title: "통신 실패", message: "서버 오류", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                print("networkFail")
                print("serverErr")
            case .networkFail:
                let alertViewController = UIAlertController(title: "통신 실패", message: "네트워크 오류", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
    
    
}




extension FollowingVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowUpperCVC.identifier,
                    for: indexPath) as? FollowUpperCVC else {return UICollectionViewCell()}
            cell.followingBarButtonDelegate = self
            cell.followPeopleCollectionViewDelegate = self
            cell.followingPeopleCollectionViewDelegate = self
            cell.followPlusButtonDelegate = self
            cell.followScrapButtonDelegate = self
            return cell
            
        }
        
        
        else if indexPath.section == 1{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowPeopleCVC.identifier,
                    for: indexPath) as? FollowPeopleCVC else {return UICollectionViewCell()}
            followingFollowButtonDelegate = cell
            followingFollowingButtonDelegate = cell
            cell.followees = self.followees
            cell.followers = self.followers
            print("마지막")
            print(isFollowing)
            if isFollowing{
                
                cell.shows = self.followees
                cell.isFollowing = isFollowing
            }
            else {
                cell.shows = self.followers
                cell.isFollowing = isFollowing
            }
            
            cell.followScrapButtonDelegate = self
            cell.peopleCollectionView.reloadData()
            
            return cell
            
        }
//        else if indexPath.section == 2{
//            guard let cell = collectionView.dequeueReusableCell(
//                    withReuseIdentifier: FollowHeaderCVC.identifier,
//                    for: indexPath) as? FollowHeaderCVC else {return UICollectionViewCell()}
//
//
//            return cell
//
//        }
        else{
//            if indexPath.item == answers.count && pageLen > answerPage{
//                guard let cell = collectionView.dequeueReusableCell(
//                        withReuseIdentifier: FollowMoreButtonCVC.identifier,
//                        for: indexPath) as? FollowMoreButtonCVC else {return UICollectionViewCell()}
//                cell.followingMoreButtonDelegate = self
//
//                return cell
//
//            }
            
//            else {
                

                guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: FollowCardCVC.identifier,
                        for: indexPath) as? FollowCardCVC else {return UICollectionViewCell()}
                let answerTmp = answers[indexPath.item]
                let answerText = answerTmp.content ?? ""
                let answerCategory = answerTmp.category ?? ""
                let answerDate = answerTmp.answerDate ?? ""
                let answerProfile = answerTmp.userProfile ?? ""
                let answerUserName = answerTmp.userNickname ?? ""
                let answerIsAnswered = answerTmp.isAnswered ?? false
                cell.answerData = answers[indexPath.item]
                cell.followScrapButtonDelegate = self
                cell.indexInVC = indexPath.item
                cell.setItems(question: answerTmp.question,
                              answer: answerText,
                              category: answerCategory,
                              answerTime: answerDate,
                              profileImgUrl: answerProfile,
                              userName: answerUserName,
                              isAnswered: answerIsAnswered
                              
                )
                
                return cell
                
                
             
//            }
            
            
        }
        
        
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1{
            return 1
        }
//        else if section == 2{
//            return 1
//        }
        else{
            
            return answers.count
        }
        
        
    }
    
    
}




extension FollowingVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: collectionView.frame.width , height: 101)
        }
        
        else if indexPath.section == 1 {
            return CGSize(width: collectionView.frame.width , height: 150)
            
        }
//        else if indexPath.section == 2{
//            return CGSize(width: collectionView.frame.width , height: 80)
//        }
        else{
            if indexPath.item == answers.count && pageLen > answerPage {
                return CGSize(width: collectionView.frame.width , height: 70)
                
            }
            else {
                
               
                    let tmpQuestionTextView = UITextView().then{
                        $0.frame = CGRect(x: 0, y: 0, width: 255, height: 50)
                        $0.backgroundColor = .lightGray
                        $0.alpha = 0
                        let questionText = answers[indexPath.item].question
                        
                        
                        $0.text = questionText
                        
                        $0.font = UIFont.systemFont(ofSize: 16)
                    }
                    
                    let tmpTextView = UITextView().then{
                        $0.frame = CGRect(x: 0, y: 0, width: 275, height: 50)
                        $0.backgroundColor = .lightGray
                        $0.alpha = 0
                        let answerText = answers[indexPath.item].content ?? ""
                        //                    if answers[indexPath.item].isAnswered == true{
                        //                        $0.text = answerText
                        //                    }
                        //                    else{
                        //                        $0.text = "아직 송현님이 답하지 않은 질문입니다.\n답변을 하시고 글을 보시겠습니까?"
                        //                    }
                        
                        $0.text = answerText
                        $0.font = UIFont.systemFont(ofSize: 14)
                    }
                    
                    view.addSubview(tmpTextView)
                    view.addSubview(tmpQuestionTextView)
                    tmpTextView.translatesAutoresizingMaskIntoConstraints = false
                    tmpQuestionTextView.translatesAutoresizingMaskIntoConstraints = false
                    
                    tmpTextView.snp.makeConstraints{
                        $0.leading.equalToSuperview().offset(50)
                        $0.trailing.equalToSuperview().offset(-50)
                        $0.height.equalTo(50)
                        $0.top.equalToSuperview().offset(50)
                        
                    }
                    tmpQuestionTextView.snp.makeConstraints{
                        $0.leading.equalToSuperview().offset(50)
                        $0.trailing.equalToSuperview().offset(-70)
                        $0.height.equalTo(50)
                        $0.top.equalToSuperview().offset(50)
                        
                    }
                    tmpTextView.delegate = self
                    tmpTextView.isScrollEnabled = false
                    textViewDidChange(tmpTextView)
                    
                    tmpQuestionTextView.delegate = self
                    tmpQuestionTextView.isScrollEnabled = false
                    textViewDidChange(tmpQuestionTextView)
                    var dynamicHeight : CGFloat?
                    var dynamicQuestionHeight : CGFloat?
                    tmpTextView.constraints.forEach { constraint in
                        if constraint.firstAttribute == .height {
                            dynamicHeight = constraint.constant
                        }
                    }
                    tmpQuestionTextView.constraints.forEach { constraint in
                        if constraint.firstAttribute == .height {
                            dynamicQuestionHeight = constraint.constant
                        }
                    }
                    tmpTextView.removeFromSuperview()
                    tmpQuestionTextView.removeFromSuperview()

                    return CGSize(width: collectionView.frame.width  ,
                                  height: 109.0+CGFloat(dynamicHeight!)+CGFloat(dynamicQuestionHeight!))
                    
                
                
//                else{
//                    let tmpQuestionTextView = UITextView().then{
//                        $0.frame = CGRect(x: 0, y: 0, width: 255, height: 50)
//                        $0.backgroundColor = .lightGray
//                        $0.alpha = 0
//                        let questionText = answers[indexPath.item].question
//                        $0.text = questionText
//                        $0.font = UIFont.systemFont(ofSize: 16)
//                    }
//
//                    let tmpTextView = UITextView().then{
//                        $0.frame = CGRect(x: 0, y: 0, width: 275, height: 50)
//                        $0.backgroundColor = .lightGray
//                        $0.alpha = 0
//                        let answerText = answers[indexPath.item].content ?? ""
//                        $0.text = "아직 송현님이 답하지 않은 질문입니다.\n답변을 하시고 글을 보시겠습니까?"
//                        $0.font = UIFont.systemFont(ofSize: 14)
//                    }
//
//                    view.addSubview(tmpTextView)
//                    view.addSubview(tmpQuestionTextView)
//                    tmpTextView.translatesAutoresizingMaskIntoConstraints = false
//                    tmpQuestionTextView.translatesAutoresizingMaskIntoConstraints = false
//
//                    tmpTextView.snp.makeConstraints{
//                        $0.leading.equalToSuperview().offset(50)
//                        $0.trailing.equalToSuperview().offset(-50)
//                        $0.height.equalTo(50)
//                        $0.top.equalToSuperview().offset(50)
//
//                    }
//                    tmpQuestionTextView.snp.makeConstraints{
//                        $0.leading.equalToSuperview().offset(50)
//                        $0.trailing.equalToSuperview().offset(-70)
//                        $0.height.equalTo(50)
//                        $0.top.equalToSuperview().offset(50)
//
//                    }
//                    tmpTextView.delegate = self
//                    tmpTextView.isScrollEnabled = false
//                    textViewDidChange(tmpTextView)
//
//                    tmpQuestionTextView.delegate = self
//                    tmpQuestionTextView.isScrollEnabled = false
//                    textViewDidChange(tmpQuestionTextView)
//                    var dynamicHeight : CGFloat?
//                    var dynamicQuestionHeight : CGFloat?
//                    tmpTextView.constraints.forEach { constraint in
//                        if constraint.firstAttribute == .height {
//                            dynamicHeight = constraint.constant
//                        }
//                    }
//                    tmpQuestionTextView.constraints.forEach { constraint in
//                        if constraint.firstAttribute == .height {
//                            dynamicQuestionHeight = constraint.constant
//                        }
//                    }
//                    tmpTextView.removeFromSuperview()
//                    tmpQuestionTextView.removeFromSuperview()
//
//                    //                if answers[indexPath.item].isAnswered == true{
//                    //                    return CGSize(width: collectionView.frame.width  ,
//                    //                                  height: 109.0+CGFloat(dynamicHeight!)+CGFloat(dynamicQuestionHeight!))
//                    //                }
//                    //                else{
//                    //                    return CGSize(width: collectionView.frame.width  ,
//                    //                                  height: 132.0+CGFloat(dynamicHeight!)+CGFloat(dynamicQuestionHeight!))
//                    //                }
//                    //
//                    return CGSize(width: collectionView.frame.width  ,
//                                  height: 132.0+CGFloat(dynamicHeight!)+CGFloat(dynamicQuestionHeight!))
//
//
//
//                }
                
            }
            
            
            
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if section > 1{
            return UIEdgeInsets(top: 0, left: 0, bottom: 50, right:0)
        }
        
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

extension FollowingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section > 1{
            if (scrollDirection) {
                let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
                //                cell.layer.transform = rotate
                cell.layer.transform = rotationTransform
                
                //                cell.alpha = 0.5
                
                UIView.animate(withDuration: 0.3, animations: {
                    cell.layer.transform = CATransform3DIdentity
                    
                })
            } else {
                if isScrolled == true{
                    let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -50, 0)
                    cell.layer.transform = rotationTransform
                    UIView.animate(withDuration: 0.3, animations: {
                        cell.layer.transform = CATransform3DIdentity
                        
                    },completion: { finished in
//                        LoadingHUD.hide()
                        self.isLoading = false
                    })
                    isScrolled = false
                }
                
            }
            
        }
        
        
        
        
    }
    
    func scrollViewDidScroll (_ scrollView: UIScrollView) {
        
        lastInset = scrollView.contentOffset
        if scrollView.contentOffset.y != 0{
            lastY = scrollView.contentOffset.y
        }
        
        for cell in wholeCollectionView.visibleCells {
            if let indexPath = wholeCollectionView.indexPath(for: cell){
                if indexPath.item > 5 && indexPath.item >= answers.count-3{
                    if pageLen > answerPage{
                        moreButtonAction()
                    }
                    
                }
                
            }

           
            
        }
        
        
        let currentContentOffset = scrollView.contentOffset.y
        if currentContentOffset > 100 {
            isScrolled = true
        }
        
        if (currentContentOffset > lastContentOffset) {
            // scroll up
            scrollDirection = true
        } else {
            // scroll down
            scrollDirection = false
        }
        lastContentOffset = currentContentOffset
        
        for cell in wholeCollectionView.visibleCells {
            lastIndexpath = wholeCollectionView.indexPath(for: cell)!
            print(lastIndexpath)
        }
        
        
        
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
    
    
    
}

extension FollowingVC : UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width,height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
                textView.snp.makeConstraints{
                    $0.height.equalTo(estimatedSize.height)
                }
                
            }
            
            
        }
    }
    
}


extension FollowingVC : FollowingMoreButtonDelegate {
    func moreButtonAction() {
        getAnswerData()
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
        vcName.followers = followers
        vcName.followees = followees
        
        vcName.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(vcName, animated: true)
    }
    
}
extension FollowingVC : FollowingPeopleCollectionViewDelegate{
    func followingPeopleUpdate() {
        isFollowing = true
        followingFollowingButtonDelegate?.followingButtonAction()
    }
    
}
extension FollowingVC : FollowPeopleCollectionViewDelegate{
    func followPeopleUpdate() {
        isFollowing = false
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

extension FollowingVC: FollowPlusButtonDelegate{
    func plusButtonAction(){
        guard let vcName = UIStoryboard(name: "Search",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "SearchVC") as? SearchVC
        else{
            
            return
        }
        
        vcName.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vcName, animated: true)
        
    }
    
}

extension FollowingVC: FollowScrapButtonDelegate {
    func replyButtonTap(answerData: FollowingAnswers,indexInVC: Int) {
        
        
        FollowingNewAnswerService.shared.getNewData(questionID: answerData.questionID)  {(networkResult) -> (Void) in
            switch networkResult{
            case .success(let data) :
                if let newData = data as? FollowingNewAnswerData {
                    var inputData = AnswerDataForViewController(lock: true, questionCategory: newData.category, answerDate: answerData.answerDate!, question: newData.question, answer: "", index: 0, answerIdx: answerData.answerIdx, questionID: newData.questionID, createdTime: "", categoryID: newData.categoryID, id: newData.id, commentPublicFlag: 1)
                    guard let answerVC = UIStoryboard(name: "Answer",
                                                      bundle: nil).instantiateViewController(
                                                        withIdentifier: "AnswerVC") as? AnswerVC
                    else{
                        
                        return
                    }
                    
                    
                    
                    answerVC.isFromFollowingTab = true
                    answerVC.followScrapButtonDelegate = self
                    answerVC.answerData = inputData
                    answerVC.indexInFollowingVC = indexInVC
                    self.navigationController?.pushViewController(answerVC, animated: true)
                    
                    
                    
                    
                }
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
    
    func scrapButtonAction(answerID: Int,wasScrapped: Bool,indexInVC: Int) {
        scrapAnswer(answerId: answerID,wasScrapped: wasScrapped,indexInVC: indexInVC)
    }
    func containViewTap(answerID: Int) {
        goToCommentButtonTapped(answerID)
    }
    func moreButtonTap(questionID: Int, question: String){
        goToMoreAnswerButtonDidTapped(questionId: questionID, question: question)
    }
    func profileSelectedTap(userID: Int){
        guard let profileVC = UIStoryboard(name: "OthersPage",
                                           bundle: nil).instantiateViewController(
                                            withIdentifier: "OthersPageVC") as? OthersPageVC
        else{
            
            return
        }
        profileVC.userID = userID
        self.navigationController?.pushViewController(profileVC, animated: true)
        
        
    }
    func alarmButtonTap() {
        guard let alarm = UIStoryboard.init(name: "Alarm", bundle: nil).instantiateViewController(identifier: "AlarmVC") as? AlarmVC else { return }
        
        self.navigationController?.pushViewController(alarm, animated: true)
    }
    func fromAnswerVC(indexInVC: Int){
        answers[indexInVC].isAnswered = true
        wholeCollectionView.reloadData()
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


protocol FollowPlusButtonDelegate{
    func plusButtonAction()
    
}

protocol FollowScrapButtonDelegate {
    func scrapButtonAction(answerID: Int,wasScrapped: Bool,indexInVC: Int)
    func containViewTap(answerID: Int)
    func moreButtonTap(questionID: Int, question: String)
    func replyButtonTap(answerData: FollowingAnswers,indexInVC: Int)
    func profileSelectedTap(userID: Int)
    func alarmButtonTap()
    func fromAnswerVC(indexInVC: Int)
}

