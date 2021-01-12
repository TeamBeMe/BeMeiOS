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
    @IBOutlet weak var wholeCollectionView: FollowingWholeCV!
    var isScrolled = true
    
    var answers: [FollowingAnswers] = []
    var answerPage = 1
    var isLoading = false
    var myQuestion = "요즘 내 삶에서\n가장 만족스러운 것은 무엇인가요?"
    var myText = "저는 며칠 전 퇴사를 했어요. 수많은 고민 끝에 결국 저질렀습니다. 몇 년간 원해왔던 일이라 꿈만 같아요. 제가 스스로의 힘으로 하고 싶은 걸 해볼 수 있는 시간적 여유를 가지게 된 게 정말 만족스러워요. 앞으로 저에게는 정말 다양한 가능성들이 무궁무진하게 열려있어요. 앞으로 어떤 사람들과 만나게 될지, 어떤 프로젝트를 하게 될지 상상하면서 새해를 맞이하고 싶어요. 지금은 시국이 어떻게 풀릴지 확실하지 않지만 제 인생은 앞으로도 계속해서 나아가겠죠?  "
    
    var myText2 = "저는 며칠 전 퇴사를 했어요. 수많은 고민 끝에 결국 저질렀습니다. 몇 년간 원해왔던 일이라 꿈만 같아요. 제가 스스로의 힘으로 하고 싶은 걸 해볼 수 있는 시간적 여유를 가지게 된 게 정말 만족스러워요. 앞으로 저에게는 정말 다양한 가능성들이 무궁무진하게 열려있어요. 앞으로 어떤 사람들과 만나게 될지, 어떤 프로젝트를 하게 될지 상상하면서 새해를 맞이하고 싶어요. 지금은 시국이 어떻게 풀릴지 확실하지 않지만 제 인생은 앞으로도 계속해서 나아가겠죠?저는 며칠 전 퇴사를 했어요. 수많은 고민 끝에 결국 저질렀습니다. 몇 년간 원해왔던 일이라 꿈만 같아요. 제가 스스로의 힘으로 하고 싶은 걸 해볼 수 있는 시간적 여유를 가지게 된 게 정말 만족스러워요. 앞으로 저에게는 정말 다양한 가능성들이 무궁무진하게 열려있어요. 앞으로 어떤 사람들과 만나게 될지, 어떤 프로젝트를 하게 될지 상상하면서 새해를 맞이하고 싶어요. 지금은 시국이 어떻게 풀릴지 확실하지 않지만 제 인생은 앞으로도 계속해서 나아가겠죠?"
    
    var isFollowing = true
    var followShouldBeChanged = false
    var totalCell = 11
    var followingFollowButtonDelegate : FollowingFollowButtonDelegate?
    var followingFollowingButtonDelegate : FollowingFollowingButtonDelegate?
    
    var followers: [FollowingFollows] = []
    var followees: [FollowingFollows] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        let loadingFrame = CGRect(x: 0, y: 155, width: view.frame.width, height: view.frame.height-155)
        LoadingHUD.show(loadingFrame: loadingFrame,color: .white)
        isLoading = true
        getAnswerData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFollowData()
        
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
        let loadingFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        if isLoading == false{
            LoadingHUD.show(loadingFrame: loadingFrame,color: .white)
            isLoading = true
        }
        
        FollowingGetAnswersService.shared.getAnswerData(page: answerPage){(networkResult) -> (Void) in
            switch networkResult{
            case .success(let data) :
                if let answerDatas = data as? FollowingAnswersData {
                    for answerData in answerDatas.answers{
                        self.answers.append(answerData)
                    }
                    
                }
                self.wholeCollectionView.reloadDataWithCompletion {
                    LoadingHUD.hide()
                    
                }
                //                self.wholeCollectionView.reloadData()
                //                DispatchQueue.main.async {
                //                    let indexPath = NSIndexPath(item: self.wholeCollectionView.numberOfItems(inSection: 3)+200, section: 3)
                //                    LoadingHUD.hide()
                //                    self.isLoading = false
                //
                //                }
                print(self.answers)
                print("success")
                self.answerPage = self.answerPage+1
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
            cell.shows = self.followees
            cell.peopleCollectionView.reloadData()
            
            return cell
            
        }
        else if indexPath.section == 2{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowHeaderCVC.identifier,
                    for: indexPath) as? FollowHeaderCVC else {return UICollectionViewCell()}
            
            
            return cell
            
        }
        else{
            if indexPath.item == answers.count-1 {
                guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: FollowMoreButtonCVC.identifier,
                        for: indexPath) as? FollowMoreButtonCVC else {return UICollectionViewCell()}
                cell.followingMoreButtonDelegate = self
                
                return cell
                
            }
            
            else {
                
                if answers[indexPath.item].isAnswered == true{
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
                    
                    cell.setItems(question: answerTmp.question,
                                  answer: answerText,
                                  category: answerCategory,
                                  answerTime: answerDate,
                                  profileImgUrl: answerProfile,
                                  userName: answerUserName,
                                  isAnswered: answerIsAnswered
                                  
                    )
                    
                    return cell
                }
                
                else {
                    guard let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: FollowNotAnsweredCVC.identifier,
                            for: indexPath) as? FollowNotAnsweredCVC else {return UICollectionViewCell()}
                    cell.setItems(inputAnswer:  answers[indexPath.item])
                    return cell
                }
                
            }
            
            
        }
        
        
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1{
            return 1
        }
        else if section == 2{
            return 1
        }
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
        else if indexPath.section == 2{
            return CGSize(width: collectionView.frame.width , height: 80)
        }
        else{
            if indexPath.item == answers.count-1 {
                return CGSize(width: collectionView.frame.width , height: 70)
                
            }
            else {
                
                if answers[indexPath.item].isAnswered == true{
                    let tmpQuestionTextView = UITextView().then{
                        $0.frame = CGRect(x: 0, y: 0, width: 260, height: 50)
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
                    print("dynamicQuestionHeight")
                    print(dynamicQuestionHeight)
                    
                    print("dynamicHeight")
                    print(dynamicHeight)
                    //                if answers[indexPath.item].isAnswered == true{
                    //                    return CGSize(width: collectionView.frame.width  ,
                    //                                  height: 109.0+CGFloat(dynamicHeight!)+CGFloat(dynamicQuestionHeight!))
                    //                }
                    //                else{
                    //                    return CGSize(width: collectionView.frame.width  ,
                    //                                  height: 132.0+CGFloat(dynamicHeight!)+CGFloat(dynamicQuestionHeight!))
                    //                }
                    //
                    return CGSize(width: collectionView.frame.width  ,
                                  height: 109.0+CGFloat(dynamicHeight!)+CGFloat(dynamicQuestionHeight!))
                    
                }
                
                else{
                    let tmpQuestionTextView = UITextView().then{
                        $0.frame = CGRect(x: 0, y: 0, width: 260, height: 50)
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
                        $0.text = "아직 송현님이 답하지 않은 질문입니다.\n답변을 하시고 글을 보시겠습니까?"
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

                    //                if answers[indexPath.item].isAnswered == true{
                    //                    return CGSize(width: collectionView.frame.width  ,
                    //                                  height: 109.0+CGFloat(dynamicHeight!)+CGFloat(dynamicQuestionHeight!))
                    //                }
                    //                else{
                    //                    return CGSize(width: collectionView.frame.width  ,
                    //                                  height: 132.0+CGFloat(dynamicHeight!)+CGFloat(dynamicQuestionHeight!))
                    //                }
                    //
                    return CGSize(width: collectionView.frame.width  ,
                                  height: 132.0+CGFloat(dynamicHeight!)+CGFloat(dynamicQuestionHeight!))
                    
                    
                    
                }
                
            }
            
            
            
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if section > 2{
            return UIEdgeInsets(top: 0, left: 0, bottom: 20, right:0)
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
        if indexPath.section > 2{
            if (scrollDirection) {
                let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 150, 0)
                //                cell.layer.transform = rotate
                cell.layer.transform = rotationTransform
                
                //                cell.alpha = 0.5
                
                UIView.animate(withDuration: 0.5, animations: {
                    cell.layer.transform = CATransform3DIdentity
                    
                })
            } else {
                if isScrolled == true{
                    let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -50, 0)
                    cell.layer.transform = rotationTransform
                    UIView.animate(withDuration: 0.5, animations: {
                        cell.layer.transform = CATransform3DIdentity
                        
                    },completion: { finished in
                        LoadingHUD.hide()
                        self.isLoading = false
                    })
                    isScrolled = false
                }
                
            }
            
        }
        
        
        
        
    }
    
    func scrollViewDidScroll (_ scrollView: UIScrollView) {
        
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
        followingFollowingButtonDelegate?.followingButtonAction()
    }
    
}
extension FollowingVC : FollowPeopleCollectionViewDelegate{
    func followPeopleUpdate() {
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
