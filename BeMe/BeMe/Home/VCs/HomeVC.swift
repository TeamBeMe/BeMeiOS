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
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    
    let alertHorizontalSeperator = UIView().then{
        $0.backgroundColor = .gray
        
    }
    let alertVerticalSeperator = UIView().then {
        $0.backgroundColor = .gray
    }
    @IBOutlet weak var timeLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    
    //MARK:- User Define Variables
    private var collectionViewWidth = 0
    private var cardWidth : CGFloat = 0.0
    private var pastCards = 0
    private var todayCards = 0
    private var currentCardIdx = 0
    private var initialScrolled = false
    private var cardHeight = 0.0
    var nowPos = CGPoint(x: -1.0, y: 0)
    let deviceBound = UIScreen.main.bounds.height/812.0
    let deviceWidthBound = UIScreen.main.bounds.width/375.0
    var locks = [false,false,false,false,false,false,false,false,]
    let userNotificationCenter = UNUserNotificationCenter.current()
    private var flexible = false
    
    
}


//MARK:- LifeCycle Methods
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        pastCards = 3
        todayCards = 1
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
        requestNotificationAuthorization()
        sendNotification()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if initialScrolled == false {
            cardCollectionView.scrollToItem(at: IndexPath(item: pastCards, section: 0),
                                            at: .centeredHorizontally,
                                            animated: false)
            initialScrolled = true
            currentCardIdx = pastCards + todayCards - 1
        }
        
        
    }
    
    
    
    
}
//MARK:- User Define functions
extension HomeVC {
    
    @objc func cancelButtonAction(){
        print("called")
        
    }
    
    @objc func okayButtonAction(){
        print("called")
        
    }
    
    func changeLock(){
        locks[currentCardIdx] = !locks[currentCardIdx]
        cardCollectionView.reloadData()
        
    }
    
    func makeAlertTitle() -> String {
        if locks[currentCardIdx] == false {
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
    
    
}

extension HomeVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item >= pastCards && indexPath.item <= pastCards + todayCards - 1{
            
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: NewCardCVC.identifier,
                    for: indexPath) as? NewCardCVC else {return UICollectionViewCell()}
            cell.setLock(after: locks[indexPath.item])
            cell.changePublicDelegate = self
            return cell
        }
        
        else if indexPath.item < pastCards {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PastCardCVC.identifier,
                    for: indexPath) as? PastCardCVC else {return UICollectionViewCell()}
            cell.setLock(after: locks[indexPath.item])
            cell.changePublicDelegate = self
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
        if Int(curPos.x) < (pastCards-1)*collectionViewWidth {
            timeLabel.text = "과거의 질문"
        }
        else{
            timeLabel.text = "오늘의 질문"
            
        }
        
        if flexible {
            if Int(curPos.x) > Int(cardWidth+10) + Int(cardWidth+20)*(currentCardIdx-1) - 200
                && Int(curPos.x) < Int(cardWidth+10) + Int(cardWidth+20)*(currentCardIdx-1) + 200 {
                flexible = !flexible
            }
        }
        
        if initialScrolled == true && !flexible{

            if Int(curPos.x) < Int(cardWidth+10) + Int(cardWidth+20)*(currentCardIdx-1) - 200 {
                cardCollectionView.scrollToItem(at: IndexPath(item: currentCardIdx-1, section: 0),
                                                at: .centeredHorizontally,
                                                animated: true)
                currentCardIdx = currentCardIdx-1


            }
            else if Int(curPos.x) > Int(cardWidth+10) + Int(cardWidth+20)*(currentCardIdx-1) + 200 {
                cardCollectionView.scrollToItem(at: IndexPath(item: currentCardIdx+1, section: 0),
                                                at: .centeredHorizontally,
                                                animated: true)
                currentCardIdx = currentCardIdx+1


            }

        }

        
    }

}

extension HomeVC : AddQuestionDelegate {
    func addQuestion() {

        
        let customCard = CustomTodayCardView(frame: .zero)
        let customAddCard = CustomAddCardView(frame: .zero)
        self.view.addSubview(customCard)
        self.view.addSubview(customAddCard)
        customCard.snp.makeConstraints{
            $0.width.equalTo(cardWidth)
            $0.height.equalTo(cardHeight)
            $0.top.equalToSuperview().offset(150*deviceBound)
            $0.leading.equalToSuperview().offset(40)
            
        }
        customAddCard.snp.makeConstraints{
            $0.width.equalTo(cardWidth)
            $0.height.equalTo(cardHeight)
            $0.top.equalToSuperview().offset(150*deviceBound)
            $0.leading.equalToSuperview().offset(40)
            
        }
        UIView.transition(from: customAddCard,
                          to: customCard,
                          duration: 1.5,
                          options: .transitionCurlUp,
                          completion: { f in
                            customCard.removeFromSuperview()
                            self.todayCards = self.todayCards+1
                            self.cardCollectionView.reloadData()
                            self.cardCollectionView.scrollToItem(at: IndexPath(item: self.currentCardIdx, section: 0),
                                                            at: .centeredHorizontally,
                                                            animated: true)
                            
                          })
        
    }
    
}


extension HomeVC : ChangePublicDelegate{
    func changePublic(now: Bool) {
        
        showAlert(now: now)
        
        
    }
    
    
    func showAlert(now : Bool){
        let blurView = UIView(frame: .zero).then{
            $0.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0.6))
            
        }
        
        let alertView = CustomAlertView(frame: .zero)
        
        self.view.addSubview(blurView)
        self.view.addSubview(alertView)
        
        alertView.setTitles(titleLabel: makeAlertTitle(),
                            leftButtonTitle: "취소",
                            rightButtonTitle: "확인")
        
        
        blurView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.width.equalTo(270)
            $0.height.equalTo(122)
            $0.centerX.centerY.equalToSuperview()
        }
        
        alertView.leftButtonClicked = { [weak self] in
            blurView.removeFromSuperview()
            alertView.removeFromSuperview()
            
        }
        alertView.rightButtonClicked = { [weak self] in
            self?.changeLock()
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

        self.cardCollectionView.scrollToItem(at: IndexPath(item: self.pastCards, section: 0),
                                        at: .centeredHorizontally,
                                        animated: true)
        
        currentCardIdx = pastCards
    
        
    
        
    }
}

protocol AddQuestionDelegate{
    
    func addQuestion()
    
    
}

protocol ChangePublicDelegate{
    
    func changePublic(now : Bool)
    
}



protocol HomeTabBarDelegate {
    func homeButtonTapped()
    
}
