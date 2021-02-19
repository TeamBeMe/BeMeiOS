//
//  SceneDelegate.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        if #available(iOS 13.0, *){
            window?.overrideUserInterfaceStyle = .light
        }
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert(_:)), name: .fromPushAlert, object: nil)
        guard let scene = (scene as? UIWindowScene) else { return }
        let defaults = UserDefaults.standard
        var storyBoard = UIStoryboard(name: "UnderTab", bundle: nil)
        var rootVc = storyBoard.instantiateViewController(identifier: "UnderTabBarController")
        //        var storyBoard = UIStoryboard(name: "Onboarding", bundle: nil)
        //        var rootVc = storyBoard.instantiateViewController(identifier: "OnboardingVC")
        if let token = defaults.string(forKey: "token"){
            // 자동로그인 -> 메인뷰
            
            if token == "guest" {
                storyBoard = UIStoryboard(name: "LogIn", bundle: nil)
                rootVc = storyBoard.instantiateViewController(identifier: "LogInVC")
                
            }
            else{
                guard let nickName = defaults.string(forKey: "nickName") else { return }
                guard let password = defaults.string(forKey: "password") else {return}
                print(nickName)
                LogInService.shared.login(nickName: nickName,
                                          password: password)  { networkResult in
                    
                    switch networkResult {
                    case .success(let token) :
                        guard let token = token as? String else { return }
                        print(token)
                        defaults.set(token, forKey: "token")
                        print("autoLogin")
                        
                        
                        
                    case .requestErr(let message):
                        print("reqERR")
                        
                    case .pathErr:
                        print("pathERR")
                    case .serverErr:
                        print("serverERR")
                    case .networkFail:
                        print("network")
                        
                    }
                    
                    
                }
                
            }
            
            
            
        }
        
        // 온보딩
        else{
            print("Onboarding")
            storyBoard = UIStoryboard(name: "Onboarding", bundle: nil)
            rootVc = storyBoard.instantiateViewController(identifier: "OnboardingVC")
            
            
        }
        
        window = UIWindow(windowScene: scene)
        
        window?.rootViewController = rootVc
        window?.makeKeyAndVisible()
        
        
        
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
            

                
    }
    
    @objc func showAlert(_ notification: Notification){
        guard let rootVC = self.window?.rootViewController as? UINavigationController else { return}
        if let should = UserDefaults.standard.string(forKey: "shouldShowAlert"){
            if should == "yes" {
                guard let alarm = UIStoryboard.init(name: "Alarm", bundle: nil).instantiateViewController(identifier: "AlarmVC") as? AlarmVC else { return }
                
                rootVC.pushViewController(alarm, animated: true)
                UserDefaults.standard.setValue("no", forKey: "shouldShowAlert")
            }
            
        }
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

