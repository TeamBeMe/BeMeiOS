//
//  HomeVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import UIKit
import Then
import SnapKit
import UserNotifications

class HomeVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cardCollectionView: HomeCardCollectionView!
    static var shouldShowAlarm = false
    
    let alertHorizontalSeperator = UIView().then{
        $0.backgroundColor = .gray
        
    }
    let alertVerticalSeperator = UIView().then {
        $0.backgroundColor = .gray
    }
    @IBOutlet weak var timeLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var lastIdx = -1
    var firstImage = UIImageView().then {
        $0.image = UIImage(named: "icEdit")
        
    }
    var firstLabel = UILabel().then {
        $0.text = "수정하기"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    var secondImage = UIImageView().then {
        $0.image = UIImage(named: "icDelete")
    }
    var secondLabel = UILabel().then {
        $0.text = "삭제하기"
        $0.textColor = .grapefruit
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    var lineView = UIView().then {
        $0.backgroundColor = .slateGrey
    }
    var cancelButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    var cancelLabel = UILabel().then {
        $0.text = "취소"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    var alertContainView = UIView().then {
        $0.backgroundColor = .charcoalGrey
    }
    var blurView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    }
    var changeButton = UIButton().then {
        $0.backgroundColor = .charcoalGrey
    }
    var removeButton = UIButton().then {
        $0.backgroundColor = .charcoalGrey
    }
    
    //MARK:- User Define Variables
    private var collectionViewWidth = 0
    private var cardWidth : CGFloat = 0.0
    var pastCards = 0
    var todayCards = 0
    var todayCardsForLabel = 0
    var currentCardIdx = 0
    private var initialScrolled = false
    private var cardHeight = 0.0
    var nowPos = CGPoint(x: -1.0, y: 0)
    let deviceBound = UIScreen.main.bounds.height/812.0
    let deviceWidthBound = UIScreen.main.bounds.width/375.0
    var locks = [false,false,false,false,false,false,false,false,]
    let userNotificationCenter = UNUserNotificationCenter.current()
    private var flexible = false
    var answerDataList : [AnswerDataForViewController] = []
    var pageForServer = 1
    var changePublicIdx = 0
    var changePublicAnswerID = 0
    var deleteAnswerID = 0
    var deleteIdx = 0
    var initialAnimated = false
    
    var pageForUpdate = 0
    var isInit = false
   
}


//MARK:- LifeCycle Methods
extension HomeVC {
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //        pastCards = 3
        //        todayCards = 1
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        let customLayout = HomeCardCustomFlowLayout()
        cardCollectionView.collectionViewLayout = customLayout
        //        cardCollectionView.reloadData()
        timeLabelTopConstraint.constant = 103 * deviceBound
        collectionViewTopConstraint.constant = 150 * deviceBound
        if deviceBound < 1 {
            collectionViewHeightConstraint.constant = 450
            cardHeight = 450
            cardWidth = 315
        }
        else {
            collectionViewHeightConstraint.constant = 491*deviceBound
            cardHeight = Double(491*deviceBound)
            cardWidth = 315*deviceBound
        }
        //        userNotificationCenter.delegate = self
//        requestNotificationAuthorization()
//        sendNotification()
        
//        LoadingHUD.show(loadingFrame: self.view.frame,color: .black)
        answerDataList = []
//        pageGetFromServer()
        
       
       
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        
        
        if !initialScrolled{
            LoadingHUD.show(loadingFrame: self.view.frame,color: .black)
            
           
           
        }
        if isInit == false{
            pageGetFromServer()
            isInit = true
        }
        else{
            pageUpdate()
        }
       

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //        if initialScrolled == false {
        //            cardCollectionView.scrollToItem(at: IndexPath(item: pastCards, section: 0),
        //                                            at: .centeredHorizontally,
        //                                            animated: false)
        //            initialScrolled = true
        //            currentCardIdx = pastCards + todayCards - 1
        //        }
        
        
    }
    
    
    
    
}
//MARK:- User Define functions
extension HomeVC {
    func startAnimation(){
        self.cardCollectionView.alpha = 0
        self.timeLabel.alpha = 0
        
        UIView.animate(withDuration: 1.5, animations: {
            self.cardCollectionView.alpha = 1
            self.timeLabel.alpha = 1
           
        },completion: { finished in
           
            
            
        })
        
    }
    
    
    func changeLock(){
        var input = 1
        if answerDataList[changePublicIdx].lock! {
            input = 0
        }
        
        HomeChangePublicService.shared.changePublic(id: changePublicAnswerID,publicFlag: input) {(networkResult) -> (Void) in
            switch networkResult{
            case .success(let data) :
                self.answerDataList[self.changePublicIdx].lock! = !self.answerDataList[self.changePublicIdx].lock!
                self.cardCollectionView.reloadData()
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
    
    func makeAlertTitle() -> String {
        if answerDataList[changePublicIdx].lock == true {
            return "공개 질문으로 전환하시겠어요?"
        }
        else{
            return "비공개 질문으로 전환하시겠어요?"
        }
        
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "오늘의 질문이 도착했어요"
        notificationContent.body = "질문을 보러가려면 눌러주세요"
        
        
        
        
        
        var date = DateComponents()
        date.hour = 22
        date.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func pageUpdate(){
        LoadingHUD.show(loadingFrame: self.view.frame,color: .black)
        print("바뀌기전")
        print(self.todayCards)
        print(self.pastCards)
        pageForUpdate = 0
        self.todayCards = 0
        self.pastCards = 0
        answerDataList = []
        
        onePageUpdate()
        
    }
    
    func onePageUpdate(){
        pageForUpdate += 1
        HomePageDataService.shared.getHomeData(page: pageForUpdate){(networkResult) -> (Void) in
            switch networkResult {
            case .success(let data) :
                
                var i = 0
                print(data)
                
                
                if let homePageDatas = data as? [HomePageData]{
                    
                    print(homePageDatas.count)
                    
                    
                    for homePageData in homePageDatas{
                        
                        
                        var answerDate = homePageData.answerDate ?? ""
                        var answerIdx = homePageData.answerIdx ?? 0
                        var content = homePageData.content ?? ""
                        var createdAt = homePageData.createdAt ?? ""
                        var categoryName = homePageData.questionCategoryName ?? ""
                        var questionCategoryName = homePageData.questionCategoryName ?? ""
                        var questionTitle = homePageData.questionTitle ?? ""
                        var questionID = homePageData.questionID ?? 0
                        var questionCategoryID = homePageData.questionCategoryID ?? 0
                        var dataId = homePageData.id ?? 0
                        var commentPublicFlag = homePageData.commentBlockedFlag ?? 1
                        
                        if answerDate != ""{
                            let index = answerDate.index(answerDate.startIndex, offsetBy: 10)
                            answerDate = answerDate.substring(to: index)
                        }
                        if createdAt != "" {
                            let index = createdAt.index(createdAt.startIndex, offsetBy: 10)
                            createdAt = createdAt.substring(to: index)
                        }

                        
                        if homePageData.isToday!  {
                            self.todayCards += 1
        
                        }
                        else if content == ""{
                            self.todayCards += 1
                            self.todayCardsForLabel += 1
                        }
                        else{
                            self.pastCards = self.pastCards + 1
                        }
                        
                        
                        
                        
                        var newData = AnswerDataForViewController(lock: homePageData.publicFlag != 1,
                                                                  questionCategory: questionCategoryName,
                                                                  answerDate: answerDate,
                                                                  question: questionTitle,
                                                                  answer: content,
                                                                  index: self.currentCardIdx,
                                                                  answerIdx: answerIdx,
                                                                  questionID: questionID,
                                                                  createdTime: createdAt,
                                                                  categoryID: questionCategoryID,
                                                                  id: dataId,
                                                                  commentPublicFlag: commentPublicFlag)
                        print("")
                        print(newData)
                        self.answerDataList.insert(newData, at: 0)
                        i = i + 1
                    }
                    
                    print("바뀐 후")
                    print(self.todayCards)
                    print(self.pastCards)
                    print(self.answerDataList)
                    if self.pageForUpdate < self.pageForServer-1 {
                        self.onePageUpdate()
                    }
                    else{
                        self.cardCollectionView.reloadData()
                        
                        if self.answerDataList.count > 0 {
                            for i in 0...self.answerDataList.count-1 {
                                if self.answerDataList[i].id! == self.lastIdx {
                                    self.cardCollectionView.scrollToItem(at: IndexPath(item: i,
                                                                                       section: 0),
                                                                         at: .centeredHorizontally,
                                                                         animated: false)
                                }
                                
                            }
                            
                        }
                       
                        
                        
                        
                        
                        
                    }
                    
                    
                   
                    
                }
              
                
            case .requestErr(let msg):
                if let message = msg as? String {
                    LoadingHUD.hide()
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
        
        
        
        
    
    
    func pageGetFromServer(){
        LoadingHUD.show(loadingFrame: self.view.frame,color: .black)
        HomePageDataService.shared.getHomeData(page: self.pageForServer){(networkResult) -> (Void) in
            switch networkResult {
            case .success(let data) :
                
                self.pageForServer = self.pageForServer + 1
                var i = 0
                print(data)
                
                if let homePageDatas = data as? [HomePageData]{
                    
                    print(homePageDatas.count)
                    
                    
                    for homePageData in homePageDatas{
                        
                        
                        var answerDate = homePageData.answerDate ?? ""
                        var answerIdx = homePageData.answerIdx ?? 0
                        var content = homePageData.content ?? ""
                        var createdAt = homePageData.createdAt ?? ""
                        var categoryName = homePageData.questionCategoryName ?? ""
                        var questionCategoryName = homePageData.questionCategoryName ?? ""
                        var questionTitle = homePageData.questionTitle ?? ""
                        var questionID = homePageData.questionID ?? 0
                        var questionCategoryID = homePageData.questionCategoryID ?? 0
                        var dataId = homePageData.id ?? 0
                        var commentPublicFlag = homePageData.commentBlockedFlag ?? 1
                        if answerDate != ""{
                            let index = answerDate.index(answerDate.startIndex, offsetBy: 10)
                            answerDate = answerDate.substring(to: index)
                        }
                        if createdAt != "" {
                            let index = createdAt.index(createdAt.startIndex, offsetBy: 10)
                            createdAt = createdAt.substring(to: index)
                        }

                        
                        if homePageData.isToday!  {
                            self.todayCards += 1
        
                        }
                        else if content == ""{
                            self.todayCards += 1
                            self.todayCardsForLabel += 1
                        }
                        else{
                            self.pastCards = self.pastCards + 1
                        }
                        
                        
                        
                        
                        var newData = AnswerDataForViewController(lock: homePageData.publicFlag != 1,
                                                                  questionCategory: questionCategoryName,
                                                                  answerDate: answerDate,
                                                                  question: questionTitle,
                                                                  answer: content,
                                                                  index: self.currentCardIdx,
                                                                  answerIdx: answerIdx,
                                                                  questionID: questionID,
                                                                  createdTime: createdAt,
                                                                  categoryID: questionCategoryID,
                                                                  id: dataId,
                                                                  commentPublicFlag: commentPublicFlag)
                        print("")
                        print(newData)
                        self.answerDataList.insert(newData, at: 0)
                        i = i + 1
                    }
                    
                    self.cardCollectionView.reloadDataWithCompletion {
                        LoadingHUD.hide()
                       
                        if self.initialScrolled == false{
                            
                        }
                       
                    }
                    if self.initialScrolled == false {
                        self.startAnimation()
                        self.cardCollectionView.scrollToItem(at: IndexPath(item: self.pastCards + self.todayCards - 1,
                                                                           section: 0),
                                                             at: .centeredHorizontally,
                                                             animated: false)
//                        LoadingHUD.hide()
                        self.initialScrolled = true
                        self.currentCardIdx = self.pastCards + self.todayCards - 1
                        self.timeLabel.text = "오늘의 질문"
                    }
                    else{
                        self.cardCollectionView.scrollToItem(at: IndexPath(item: self.currentCardIdx+homePageDatas.count,
                                                                           section: 0),
                                                             at: .centeredHorizontally,
                                                             animated: false)
                        self.currentCardIdx = self.currentCardIdx+homePageDatas.count
                        
                    }
                    
                }
              
                
            case .requestErr(let msg):
                if let message = msg as? String {
                    LoadingHUD.hide()
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
        print(answerDataList)
        
        
    }
    
    
}

extension HomeVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item >= pastCards && indexPath.item <= pastCards + todayCards - 1{
            
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: NewCardCVC.identifier,
                    for: indexPath) as? NewCardCVC else {return UICollectionViewCell()}
            cell.index = indexPath.item
            cell.changePublicDelegate = self
            cell.homeAnswerButtonDelegate = self
            cell.homeChangeQuestionDelegate = self
            cell.homeFixButtonDelegate = self
            cell.answerData = answerDataList[indexPath.item]
            if indexPath.item == self.pastCards + self.todayCards - 1{
                if answerDataList[indexPath.item].answer == ""{
                    if initialAnimated == false{
                        cell.isInitial = true
                        cell.initialAnimation()
                        initialAnimated = true
                    }
                   
                }
            }
            
            
            cell.setItems()
            
            
            return cell
        }
        
        else if indexPath.item < pastCards {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PastCardCVC.identifier,
                    for: indexPath) as? PastCardCVC else {return UICollectionViewCell()}
            cell.index = indexPath.item
            cell.changePublicDelegate = self
            cell.homeFixButtonDelegate = self
            cell.answerData = answerDataList[indexPath.item]
            
            cell.setItems()
            return cell
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AddCardCVC.identifier,
                    for: indexPath) as? AddCardCVC else {return UICollectionViewCell()}
            
            cell.addDelegate = self
            return cell
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return pastCards + todayCards + 1
    }
    
    
}




extension HomeVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        collectionViewWidth = Int(collectionView.frame.width)
        return CGSize(width: cardWidth ,
                      height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right:20)
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

extension HomeVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let curPos = scrollView.contentOffset


        if flexible {
            if Int(curPos.x) > Int(cardWidth+10) + Int(cardWidth+20)*(currentCardIdx-1) - 200
                && Int(curPos.x) < Int(cardWidth+10) + Int(cardWidth+20)*(currentCardIdx-1) + 200{
                flexible = !flexible
            }
        }

        if initialScrolled == true && !flexible{

            if Int(curPos.x) < Int(cardWidth+10) + Int(cardWidth+20)*(currentCardIdx-1) - 200 {
                cardCollectionView.scrollToItem(at: IndexPath(item: currentCardIdx-1, section: 0),
                                                at: .centeredHorizontally,
                                                animated: true)

                currentCardIdx = currentCardIdx-1
                print("curr")
                print(currentCardIdx)
                if currentCardIdx < 1 {
                    print("curr")
                    print(currentCardIdx)
                    pageGetFromServer()

                }

            }
            else if Int(curPos.x) > Int(cardWidth+10) + Int(cardWidth+20)*(currentCardIdx-1) + 200{
                cardCollectionView.scrollToItem(at: IndexPath(item: currentCardIdx+1, section: 0),
                                                at: .centeredHorizontally,
                                                animated: true)
                currentCardIdx = currentCardIdx+1


            }

        }
        if currentCardIdx < pastCards+todayCardsForLabel{
            timeLabel.text = "과거의 질문"
        }
        else{
            timeLabel.text = "오늘의 질문"
        }

        if currentCardIdx < answerDataList.count {
            lastIdx = answerDataList[currentCardIdx].id!
        }
        
        
        
        
    }
    
}

extension HomeVC : AddQuestionDelegate {
    func addQuestion() {
        
        for i in pastCards..<pastCards+todayCards{
            if answerDataList[i].answer == "" || answerDataList[i].answer == nil{
                showAlert(titleLabel: "새로운 질문을 받기 위해\n오늘의 질문을 먼저 대답해주세요",
                          leftButtonTitle: "취소",
                          rightButtonTitle: "확인",
                          topConstraint: 24)
                return
            }
        }
        
        HomeNewQuestionService.shared.getHomeData() {(networkResult) -> (Void) in
            switch networkResult {
            case .success(let data) :
                
                
                if let newQuestionData = data as? HomeNewQuestionData {
                    self.todayCards = self.todayCards+1
                    var answerDate = newQuestionData.answerDate ?? ""
                    var answerIdx = newQuestionData.answerIdx ?? 0
                    var content = newQuestionData.content ?? ""
                    var createdAt = newQuestionData.createdAt ?? ""
                    var categoryName = newQuestionData.questionCategoryName ?? ""
                    var questionCategoryName = newQuestionData.questionCategoryName ?? ""
                    var questionTitle = newQuestionData.questionTitle ?? ""
                    var questionID = newQuestionData.questionID ?? 0
                    var questionCategoryID = newQuestionData.questionCategoryID ?? 0
                    var dataID = newQuestionData.id ?? 0
                    
                    var commentPublicFlag = newQuestionData.commentBlockedFlag ?? 1
                    if answerDate != ""{
                        let index = answerDate.index(answerDate.startIndex, offsetBy: 10)
                        answerDate = answerDate.substring(to: index)
                    }
                    if createdAt != "" {
                        let index = createdAt.index(createdAt.startIndex, offsetBy: 10)
                        createdAt = createdAt.substring(to: index)
                    }

                    
                    
                    
                    
                    
                    
                    
                    var newData = AnswerDataForViewController(lock: newQuestionData.publicFlag != 1,
                                                              questionCategory: questionCategoryName,
                                                              answerDate: answerDate,
                                                              question: questionTitle,
                                                              answer: content,
                                                              index: self.currentCardIdx,
                                                              answerIdx: answerIdx,
                                                              questionID: questionID,
                                                              createdTime: createdAt,
                                                              categoryID: questionCategoryID,
                                                              id: dataID,
                                                              commentPublicFlag: commentPublicFlag)
                    
                    
                    self.answerDataList.append(newData)
                    self.cardCollectionView.reloadData()
                    
                    
                    
                }
                
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


extension HomeVC : ChangePublicDelegate{
    func changePublic(idx: Int,answerID: Int) {
        changePublicIdx = idx
        changePublicAnswerID = answerID
        showAlert(titleLabel: makeAlertTitle(),leftButtonTitle: "취소",
                  rightButtonTitle: "확인",topConstraint: 30)
        
        
    }
    
    
    func showAlert(titleLabel: String,leftButtonTitle: String,rightButtonTitle: String,topConstraint: Int){
        let blurView = UIView(frame: .zero).then{
            $0.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0.6))
            
        }
        
        let alertView = CustomAlertView(frame: .zero)
        
        self.view.addSubview(blurView)
        self.view.addSubview(alertView)
        
        alertView.setTitles(titleLabel: titleLabel,
                            leftButtonTitle: "취소",
                            rightButtonTitle: "확인")
        
        alertView.setTopConstraint(top: topConstraint)
        blurView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        
        alertView.snp.makeConstraints {
            $0.width.equalTo(270)
            if topConstraint < 30 {
                $0.height.equalTo(128)
            }
            else{
                $0.height.equalTo(122)
            }
            
            $0.centerX.centerY.equalToSuperview()
        }
        
        alertView.leftButtonClicked = { [weak self] in
            blurView.removeFromSuperview()
            alertView.removeFromSuperview()
            
        }
        alertView.rightButtonClicked = { [weak self] in
            if topConstraint == 30{
                self?.changeLock()
            }
            else {
                var goTo = self?.currentCardIdx
                for i in 0..<(self?.answerDataList.count)!+1{
                    if self?.answerDataList[i].answer == nil || self?.answerDataList[i].answer == ""{
                        goTo = i
                        break
                    }
                    
                }
                
                
                self?.cardCollectionView.scrollToItem(at: IndexPath(item: goTo!, section: 0),
                                                at: .centeredHorizontally,
                                                animated: false)
            }
            
            blurView.removeFromSuperview()
            alertView.removeFromSuperview()
        }
        
        
    }
    
    
}


extension HomeVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}

extension HomeVC : HomeTabBarDelegate{
    func homeButtonTapped() {
        flexible = true
        
        self.cardCollectionView.scrollToItem(at: IndexPath(item: self.pastCards+self.todayCards-1, section: 0),
                                             at: .centeredHorizontally,
                                             animated: true)
        
        currentCardIdx = pastCards
        
        
        
        
    }
}


extension HomeVC : HomeFixButtonDelegate{
    func fixButtonTapped(idx: Int) {
        print("called")
        deleteIdx = idx
        deleteAnswerID = answerDataList[deleteIdx].id!
        makeUnderAlertView()
    }
}

extension HomeVC : HomeAnswerButtonDelegate {
    func answerButtonTapped(index:Int,answerData: AnswerDataForViewController) {
        guard let answerVC = UIStoryboard(name: "Answer",
                                          bundle: nil).instantiateViewController(
                                            withIdentifier: "AnswerVC") as? AnswerVC
        else{
            
            return
        }
        
        answerVC.answerDataDelegate = self
        answerVC.curCardIdx = index
        answerVC.answerData = answerData
//        answerVC.setLabels()
        self.navigationController?.pushViewController(answerVC, animated: true)
        
    }
}

extension HomeVC : HomeGetDataFromAnswerDelegate {
    func setNewAnswer(answerData: AnswerDataForViewController) {
        if let id = answerData.id {
            lastIdx = id
        }
        
     
    }
    
    
}


extension HomeVC: HomeChangeQuestionDelegate{
    func getNewQuestion(idx: Int,answerID: Int) {
        print("called")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        if let changedDate = UserDefaults.standard.string(forKey: "rerollDate"){
            if changedDate == dateString{
                self.showToast(text: "질문 변경하기는 하루 1회만 가능합니다")
                return
            }
        }
        else{
            UserDefaults.standard.setValue(dateString, forKey: "rerollDate")
            
        }
        
        
        
        HomeChangeQuestionService.shared.getNewQuestion(answerID: answerID){ (networkResult) -> (Void) in
            switch networkResult{
            case .success(let data) :
                
                
                if let newQuestionData = data as? HomeNewQuestionData {
                    
                    var answerDate = newQuestionData.answerDate ?? ""
                    var answerIdx = newQuestionData.answerIdx ?? 0
                    var content = newQuestionData.content ?? ""
                    var createdAt = newQuestionData.createdAt ?? ""
                    var categoryName = newQuestionData.questionCategoryName ?? ""
                    var questionCategoryName = newQuestionData.questionCategoryName ?? ""
                    var questionTitle = newQuestionData.questionTitle ?? ""
                    var questionID = newQuestionData.questionID ?? 0
                    var questionCategoryID = newQuestionData.questionCategoryID ?? 0
                    var dataID = newQuestionData.id ?? 0
                    if answerDate != ""{
                        let index = answerDate.index(answerDate.startIndex, offsetBy: 10)
                        answerDate = answerDate.substring(to: index)
                    }
                    if createdAt != "" {
                        let index = createdAt.index(createdAt.startIndex, offsetBy: 10)
                        createdAt = createdAt.substring(to: index)
                    }
                    
                    
                    
                    var commentPublicFlag = newQuestionData.commentBlockedFlag ?? 1
                    
                    
                    var newData = AnswerDataForViewController(lock: newQuestionData.publicFlag != 1,
                                                              questionCategory: questionCategoryName,
                                                              answerDate: answerDate,
                                                              question: questionTitle,
                                                              answer: content,
                                                              index: self.currentCardIdx,
                                                              answerIdx: answerIdx,
                                                              questionID: questionID,
                                                              createdTime: createdAt,
                                                              categoryID: questionCategoryID,
                                                              id: dataID,
                                                              commentPublicFlag: commentPublicFlag)
                    print(newData)
                    
                    
                   
                    
                    self.answerDataList[idx] = newData
                    self.cardCollectionView.reloadData()
                    
                    
                    
                }
                
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
