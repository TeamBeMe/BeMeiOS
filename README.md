# BeMeiOS

<img src="https://user-images.githubusercontent.com/56102421/104687678-04ce8200-5743-11eb-8a17-ef279aa8f47f.png" width="40%" />

## 📌 프로젝트 소개

- SOPT 27th 장기 해커톤 APPJAM
- 기간: 2020.12.26 ~ 2021.1.16

> 매일 질문에 답을 하며 나를 알아가는 질문다이어리 BeMe 입니다.
>
> 24시간마다 새로운 질문 제공, 새로운 질문 받기를 통해 질문에 답을 할 수 있습니다.
> 자신의 글을 전체 공개하여 사람들과 소통할 수 있습니다.
> 마지막으로 마이페이지에서 내가 지금까지 답한 질문을 쉽게 볼 수 있으며, 내 생각이 어떻게 변했는지 확인할 수 있습니다.



## 📌 개발 환경 및 라이브러리

### 개발 환경

[![Swift 4](https://img.shields.io/badge/BeMe-iOS-black.svg?style=flat)](https://swift.org) ![Xcode](https://img.shields.io/badge/Xcode-12.3-blue) ![swift](https://img.shields.io/badge/swift-5.0-green) ![iOS](https://img.shields.io/badge/iOS-13.5-yellow) ![COCOAPODS](https://img.shields.io/badge/COCOAPODS-1.9.1-blue)

### 라이브러리

| 라이브러리(Library) | 목적(Purpose)            | 버전(VersionA                                                |
| ------------------- | ------------------------ | ------------------------------------------------------------ |
| Alamofire           | 서버 통신                | ![Alamofire](https://img.shields.io/badge/Alamofire-5.4.1-orange) |
| Kingfisher          | 이미지 처리              | ![Kingfisher](https://img.shields.io/badge/Kingfisher-6.0.1-yellow) |
| SnapKit             | 오토레이아웃             | ![Kingfisher](https://img.shields.io/badge/SnapKit-5.0.1-black) |
| Then                | 짧은 코드 처리           | ![Kingfisher](https://img.shields.io/badge/Then-2.7.0-white) |
| lottie-ios          | 로티 애니메이션 처리     | ![lottie-ios](https://img.shields.io/badge/lottieios-3.1.9-green) |
| Firebase/Messaging  | Firebase Cloud Messaging | ![Kingfisher](https://img.shields.io/badge/Firebase/Messaging-yellow) |
| SwiftLint           | 깔끔한 코딩 컨벤션       | ![Kingfisher](https://img.shields.io/badge/SwiftLint-red)    |

### AutoLayout 적용 여부

  **1. iPhone 12 Pro 적용** 

  **2. iPhone 12 mini 적용**

  **3. iPhone SE2 적용**



## 📌 서비스 workflow

<img src="https://user-images.githubusercontent.com/56102421/104720646-69ec9c80-5770-11eb-9504-a90ff517bb9c.png" width="50%" height="50%"/>



## 📌 협업 방식

- [Coding-Convention](https://www.notion.so/Naming-Rule-d1ad0ee6a8754d3d98d48a605139b4b2)
- [Git-Management](/GitManage.md)
- [Kanban Board](https://github.com/TeamBeMe/BeMeiOS/projects/1)
- [Foldering](https://github.com/TeamBeMe/BeMeiOS/wiki/Foldering)



## 📌 기능별 개발 여부

| Category         | 기능                                               | 개발 | 담당자   |
| ---------------- | -------------------------------------------------- | ---- | -------- |
| 스플래시         |                                                    | 🅾️    | [윤재]() |
| Auth             | 로그인                                             | ⭕️    | [윤재]() |
|                  | 회원가입                                           | ⭕️    | [윤재]() |
| 메인 화면        | 오늘의 질문 작성하기 및 수정하기                   | ⭕️    | [윤재]() |
|                  | 과거의 질문 수정하기                               | ⭕️    | [윤재]() |
|                  | 공개범위 설정하기                                  | ⭕️    | [윤재]() |
|                  | 댓글 기능 해제하기                                 | ⭕️    | [윤재]() |
|                  | 새로운 질문 받기                                   | ⭕️    | [윤재]() |
|                  | 질문에 대한 애니메이션 구현                        | ⭕️    | [윤재]() |
| 탐색 화면        | 나와 다른 생각들 답변 가져오기                     | ⭕️    | [재용]() |
|                  | 다른 글 둘러보기 답변 가져오기                     | ⭕️    | [재용]() |
|                  | 카테고리 필터 기능 (최신 / 흥미)                   | ⭕️    | [재용]() |
|                  | 카테고리 필터 기능 (질문 종류)                     | ⭕️    | [재용]() |
|                  | 리스트 애니메이션 구현                             | ⭕️    | [재용]() |
|                  | 답변 스크랩하기                                    | ⭕️    | [재용]() |
|                  | 오늘 질문 답변 하러가기                            | ⭕️    | [재용]() |
| 팔로우 화면      | 팔로잉 팔로워 필터 기능                            | ⭕️    | [윤재]() |
|                  | 팔로잉에 대한 답변 가져오기                        | ⭕️    | [윤재]() |
|                  | 답변 안 한 답변 하러가기                           | ⭕️    | [윤재]() |
|                  | 팔로잉 팔로워 검색하기                             | ⭕️    | [윤재]() |
|                  | 팔로잉 팔로워 해제                                 | ⭕️    | [윤재]() |
| 댓글 화면        | 특정 답변 가져오기                                 | ⭕️    | [재용]() |
|                  | 댓글, 대댓글 작성, 수정, 삭제하기                  | ⭕️    | [재용]() |
|                  | 답변 및 댓글 신고하기                              | ⭕️    | [재용]() |
|                  | 댓글, 대댓글 공개범위 설정하기                     | ⭕️    | [재용]() |
| 마이페이지 화면  | 내 프로필에 대한 정보 가져오기                     | ⭕️    | [세란]() |
|                  | 질문에 대한 답변 가져오기                          | ⭕️    | [세란]() |
|                  | 스크랩한 답변 가져오기                             | ⭕️    | [세란]() |
|                  | 답한 질문에 대한 글 공개범위 설정하기              | ⭕️    | [세란]() |
|                  | 프로필 편집하기                                    | ⭕️    | [세란]() |
|                  | 내 답변들 필터(공개범위, 카테고리)를 통해 검색하기 | ⭕️    | [세란]() |
| 타인 프로필 화면 | 타인 프로필에 대한 정보 가져오기                   | ⭕️    | [세란]() |
|                  | 타인이 답한 답변 가져오기                          | ⭕️    | [세란]() |
|                  | 팔로우하기 및 취소하기                             | ⭕️    | [세란]() |
|                  | 타인의 답변 스크랩하기                             | ⭕️    | [세란]() |
| 글쓰기           |                                                    |      |          |

👉 API 단위로 수정 예정



## 📌 핵심 기능 구현 방법

- 글쓰기

answer data를 넣어서 글을 등록하는 코드

```swift

AnswerRegistService.shared.regist(answerID: answerData!.id!, content: answerData!.answer!, commentBlocked: commentSwitch.isOn, isPublic: answerSwitch.isOn) {(networkResult) -> (Void) in
    switch networkResult{
    case .success(let data) :
        print(self.isFromFollowingTab)
        if self.isFromFollowingTab {
            self.followScrapButtonDelegate?.fromAnswerVC(indexInVC: self.indexInFollowingVC!)
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

```

- 타인이 쓴 글 보기

다른 페이지를 다녀와서 다른 사람의 글에 변동이 생길 경우 새로 통신을 해서 Reload해줘야함
페이징 해서 정보를 받기 때문에 1페이지부터 원래의 페이지까지 다시 받아와야 함
이 과정에서 처음에는 for문을 이용해서 어려움을 겪었으나, 통신에서의 재귀함수 호출을 통해 해결

```swift
func getUpdateAnswers(){
    let loadingFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    LoadingHUD.show(loadingFrame: loadingFrame,color: .white)
    curPage = 0
    answers = []
    updateDataOnePage()
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


```



## 📌 Extension을 통한 메소드 설명

<img src="https://user-images.githubusercontent.com/56102421/104726128-6b20c800-5776-11eb-9f2b-a9191bcce21d.png" width="30%"/> 

- UIView Extension

  ```swift
  extension UIView {
      // Set Rounded View
      func makeRounded(cornerRadius : CGFloat?){
          
          // UIView 의 모서리가 둥근 정도를 설정
          if let cornerRadius_ = cornerRadius {
              self.layer.cornerRadius = cornerRadius_
          }  else {
              // cornerRadius 가 nil 일 경우의 default
              self.layer.cornerRadius = self.layer.frame.height / 2
          }
          
          self.layer.masksToBounds = true
      }
      
      // Set UIView's Shadow
      func dropShadow(color: UIColor, offSet: CGSize, opacity: Float, radius: CGFloat) {
          
          // 그림자 색상 설정
          layer.shadowColor = color.cgColor
          // 그림자 크기 설정
          layer.shadowOffset = offSet
          // 그림자 투명도 설정
          layer.shadowOpacity = opacity
          // 그림자의 blur 설정
          layer.shadowRadius = radius
          // 구글링 해보세요!
          layer.masksToBounds = false
          
      }
      
      // Set UIView's Border
      func setBorder(borderColor : UIColor?, borderWidth : CGFloat?) {
          
          // UIView 의 테두리 색상 설정
          if let borderColor_ = borderColor {
              self.layer.borderColor = borderColor_.cgColor
          } else {
              // borderColor 변수가 nil 일 경우의 default
              self.layer.borderColor = UIColor(red: 205/255, green: 209/255, blue: 208/255, alpha: 1.0).cgColor
          }
          
          // UIView 의 테두리 두께 설정
          if let borderWidth_ = borderWidth {
              self.layer.borderWidth = borderWidth_
          } else {
              // borderWidth 변수가 nil 일 경우의 default
              self.layer.borderWidth = 1.0
          }
      }
  }
  ```

- UIViewController

  ```swift
  extension UIViewController {
      // 토스트 메세지
      func showToast(text: String, completion: @escaping ()->()) {
          let toast = ToastView(frame: CGRect(x: 0, y: 0, width: 343, height: 84))
          toast.setLabel(text: text)
          toast.alpha = 0
          self.view.addSubview(toast)
          toast.snp.makeConstraints {
              $0.leading.equalToSuperview().offset(16)
              $0.trailing.equalToSuperview().offset(-16)
              $0.bottom.equalToSuperview().offset(-101)
          }
          UIView.animate(withDuration: 0.3, animations: {
              toast.alpha = 1
              
          },completion: { finish in
              UIView.animate(withDuration: 0.3, delay: 0.7, animations: {
                  toast.alpha = 0
  
              }, completion: { finish in
                  if finish {
                      toast.removeFromSuperview()
                      completion()
                  }
              })
          })
      }
  }
  ```

- UIImageView

  ```swift
  // Kingfisher를 이용하여 url로부터 이미지를 가져오는 extension
  extension UIImageView {
      
      public func imageFromUrl(_ urlString: String?) {
          if let url = urlString {
              self.kf.setImage(with: URL(string: url), options: [.transition(ImageTransition.fade(0.5))])
          }
      }
  }
  ```

  

  

## 📌 팀원 소개

|                           **윤재**                           |          **세란**          |                           **재용**                           |
| :----------------------------------------------------------: | :------------------------: | :----------------------------------------------------------: |
| <img src="https://user-images.githubusercontent.com/56102421/104729189-6f031900-577b-11eb-84f6-fa082870caf6.jpeg" width="60%"/> | <img src="" width="50% "/> | <img src="https://user-images.githubusercontent.com/56102421/104729197-70ccdc80-577b-11eb-98fc-aa5902113cd6.jpeg" width="60%"/> |
|                            네이스                            |                            |                                                              |


### 목차

