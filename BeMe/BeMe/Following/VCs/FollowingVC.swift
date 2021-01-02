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
    
    @IBOutlet weak var wholeCollectionView: UICollectionView!
    
    var myText = "저는 며칠 전 퇴사를 했어요. 수많은 고민 끝에 결국 저질렀습니다. 몇 년간 원해왔던 일이라 꿈만 같아요. 제가 스스로의 힘으로 하고 싶은 걸 해볼 수 있는 시간적 여유를 가지게 된 게 정말 만족스러워요. 앞으로 저에게는 정말 다양한 가능성들이 무궁무진하게 열려있어요. 앞으로 어떤 사람들과 만나게 될지, 어떤 프로젝트를 하게 될지 상상하면서 새해를 맞이하고 싶어요. 지금은 시국이 어떻게 풀릴지 확실하지 않지만 제 인생은 앞으로도 계속해서 나아가겠죠?"
    
    var myText2 = "저는 며칠 전 퇴사를 했어요. 수많은 고민 끝에 결국 저질렀습니다. 몇 년간 원해왔던 일이라 꿈만 같아요. 제가 스스로의 힘으로 하고 싶은 걸 해볼 수 있는 시간적 여유를 가지게 된 게 정말 만족스러워요. 앞으로 저에게는 정말 다양한 가능성들이 무궁무진하게 열려있어요. 앞으로 어떤 사람들과 만나게 될지, 어떤 프로젝트를 하게 될지 상상하면서 새해를 맞이하고 싶어요. 지금은 시국이 어떻게 풀릴지 확실하지 않지만 제 인생은 앞으로도 계속해서 나아가겠죠?저는 며칠 전 퇴사를 했어요. 수많은 고민 끝에 결국 저질렀습니다. 몇 년간 원해왔던 일이라 꿈만 같아요. 제가 스스로의 힘으로 하고 싶은 걸 해볼 수 있는 시간적 여유를 가지게 된 게 정말 만족스러워요. 앞으로 저에게는 정말 다양한 가능성들이 무궁무진하게 열려있어요. 앞으로 어떤 사람들과 만나게 될지, 어떤 프로젝트를 하게 될지 상상하면서 새해를 맞이하고 싶어요. 지금은 시국이 어떻게 풀릴지 확실하지 않지만 제 인생은 앞으로도 계속해서 나아가겠죠?"
    
    var isFollowing = true
    var followShouldBeChanged = false
    var totalCell = 11
    var followingFollowButtonDelegate : FollowingFollowButtonDelegate?
    var followingFollowingButtonDelegate : FollowingFollowingButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        
        
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
            
            return cell
            
        }
        
        
        else if indexPath.section == 1{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowPeopleCVC.identifier,
                    for: indexPath) as? FollowPeopleCVC else {return UICollectionViewCell()}
            followingFollowButtonDelegate = cell
            followingFollowingButtonDelegate = cell
            
            
            return cell
            
        }
        else if indexPath.section == 2{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowHeaderCVC.identifier,
                    for: indexPath) as? FollowHeaderCVC else {return UICollectionViewCell()}
            
            
            return cell
            
        }
        else{
            if indexPath.item == totalCell-1 {
                guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: FollowMoreButtonCVC.identifier,
                        for: indexPath) as? FollowMoreButtonCVC else {return UICollectionViewCell()}
                cell.followingMoreButtonDelegate = self
                
                return cell
                
            }
            
            else {
                guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: FollowCardCVC.identifier,
                        for: indexPath) as? FollowCardCVC else {return UICollectionViewCell()}
                
                
                cell.setAnswer(answer: myText)
                
                return cell
                
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
            return totalCell
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
            if indexPath.item == totalCell-1 {
                return CGSize(width: collectionView.frame.width , height: 70)
                
            }
            else {
                let tmpTextView = UITextView().then{
                    $0.frame = CGRect(x: 0, y: 0, width: 275, height: 50)
                    $0.backgroundColor = .lightGray
                    $0.alpha = 0
                    $0.text = myText
                    $0.font = UIFont.systemFont(ofSize: 14)
                }
                
                view.addSubview(tmpTextView)
                tmpTextView.translatesAutoresizingMaskIntoConstraints = false
                
                tmpTextView.snp.makeConstraints{
                    $0.leading.equalToSuperview().offset(50)
                    $0.trailing.equalToSuperview().offset(-50)
                    $0.height.equalTo(50)
                    $0.top.equalToSuperview().offset(50)
                    
                }
                tmpTextView.delegate = self
                tmpTextView.isScrollEnabled = false
                textViewDidChange(tmpTextView)
                var dynamicHeight : CGFloat?
                tmpTextView.constraints.forEach { constraint in
                    if constraint.firstAttribute == .height {
                        dynamicHeight = constraint.constant
                        
                    }
                }
                tmpTextView.removeFromSuperview()
                
                return CGSize(width: collectionView.frame.width  , height: 112.0+CGFloat(dynamicHeight!))
                
            }
            
            
            
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
        
        return 0
        
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
                print(estimatedSize.height)
            }
            
            
        }
    }
    
}


extension FollowingVC : FollowingMoreButtonDelegate {
    func moreButtonAction() {
        totalCell += 10
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


