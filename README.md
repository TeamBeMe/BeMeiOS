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





### **I-2 README 작성 (모든 항목이 포함되어야 인정)**

- [ ]  **1. 개발환경 및 사용한 라이브러리**
- [ ]  **2. 서비스 workflow**
- [ ]  **3. 기능별 개발여부 + 담당자 (ex. IA 명세서 기능)**
- [ ]  **4. 핵심 기능 구현 방법 (코드 포함)**
- [ ]  **5. Extension을 통해 작성한 메소드 설명**
- [ ]  **6. 팀원 역할 및 소개**

### **i-3 AutoLayout 적용 여부**

- [ ]  **1. iPhone 12 Pro 적용**
- [ ]  **2. iPhone 12 mini 적용**
- [ ]  **3. iPhone SE2 적용**

## 📌 서비스 workflow

<img src="https://user-images.githubusercontent.com/56102421/104720646-69ec9c80-5770-11eb-9504-a90ff517bb9c.png" width="50%" height="50%"/>



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

- 



## 📌 팀원 소개



### Notion Link

- [Notion](https://www.notion.so/iOS-688f11e27af9495faac336794ccac4fa)


### 목차

- [Coding-Convention](https://www.notion.so/Naming-Rule-d1ad0ee6a8754d3d98d48a605139b4b2)
  
- [Git-Management](/GitManage.md)

- [Kanban Board](https://github.com/TeamBeMe/BeMeiOS/projects/1)
- [Foldering](https://github.com/TeamBeMe/BeMeiOS/wiki/Foldering)

### 현재 진행사항

#### 윤재 
- 홈,팔로잉,아이디 검색 후 팔로잉, 회원가입, 로그인 뷰 완성
- 회원가입, 로그인 서버완료

#### 재용
- 탐색 뷰 구현 완료, 댓글 뷰 구현중

#### 세란
- 글쓰기 뷰 구현 완료
- 마이페이지 뷰 구현중
