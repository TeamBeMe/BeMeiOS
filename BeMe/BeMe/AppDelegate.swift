//
//  AppDelegate.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseRemoteConfig
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    
    
    func appUpdate() {
        
        // id뒤에 값은 앱정보에 Apple ID에 써있는 숫자
        
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1548760434"), UIApplication.shared.canOpenURL(url) {
            
            // 앱스토어로 이동
            
            if #available(iOS 10.0, *) {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            } else {
                
                UIApplication.shared.openURL(url)
                
            }
            
        }
        
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        FirebaseApp.configure()
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetch(withExpirationDuration: TimeInterval(3600), completionHandler: { (status,error)-> Void in
            if status == .success {
                remoteConfig.activate(completion: nil)
            }
            else{
                print("errrrrrr")
            }
        })
        
        _ = try? AppStoreCheck.isUpdateAvailable { (update, error) in
            
            if let error = error {
                
                print(error)
                
            } else if let update = update {
                
                if update {
                    
                    self.appUpdate()
                    
                    return
                    
                }
                
            }
            
        }
        UNUserNotificationCenter.current().delegate = self
        
        
        
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in
                print("Permission granted")
            }
        )
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}



extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("왜 안돼")
        UIApplication.shared.applicationIconBadgeNumber += 1
        
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("응 돼")
        
        UserDefaults.standard.setValue("yes", forKey: "shouldShowAlert")
//        guard let navC = UIApplication.shared.delegate!.window!!.rootViewController! as? UINavigationController else {return}
        NotificationCenter.default.post(name: .fromPushAlert, object: nil)
        completionHandler()
    }
}


extension AppDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
       
        if let token = UserDefaults.standard.string(forKey: "token"){
            print("Firebase registration token: \(String(describing: fcmToken!))")
            print(fcmToken ?? "")
            
            FCMTokenService.shared.regist(token: fcmToken ?? "") {(networkResult) -> (Void) in
                switch networkResult{
                case .success(let data) :
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
            
            let dataDict:[String: String] = ["token": fcmToken ?? ""]
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
            
            
        }



       
        
    }
    
//
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
//        // If you are receiving a notification message while your app is in the background,
//        // this callback will not be fired till the user taps on the notification launching the application.
//        // TODO: Handle data of notification
//
//        // With swizzling disabled you must let Messaging know about the message, for Analytics
//        // Messaging.messaging().appDidReceiveMessage(userInfo)
//        print("gd")
//        // Print message ID.
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//
//
//
//        // Print full message.
//        print(userInfo)
//    }
//
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs regist err")
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        print("HHHHHHHH")
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // 성공시
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})

        // Print it to console(토큰 값을 콘솔창에 보여줍니다. 이 토큰값으로 푸시를 전송할 대상을 정합니다.)
        print("APNs device token: \(deviceTokenString)")

        Messaging.messaging().apnsToken = deviceToken



    }
    
    
    
    
    
    
}
