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

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

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
        
        UNUserNotificationCenter.current().delegate = self
        FirebaseApp.configure()
        let remoteConfig = RemoteConfig.remoteConfig()
        
        remoteConfig.fetch(withExpirationDuration: TimeInterval(3600), completionHandler: { (status,error)-> Void in
            if status == .success {
                print("Config Fetched!")
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

extension AppDelegate {
    
}

extension AppDelegate : UNUserNotificationCenterDelegate {
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
