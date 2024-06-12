//
//  SceneDelegate.swift
//  Media
//
//  Created by 김윤우 on 6/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        // 탭바컨트롤러의 생성
        let tabBarVC = UITabBarController()
        let mainVc = MovieViewController()
        let searchVc = SearchViewController()
        let mainNvc = UINavigationController(rootViewController: mainVc)
        let searchNvc = UINavigationController(rootViewController: searchVc)
        
    
        let vc1 = mainNvc
        let vc2 = searchNvc
                
        // 탭바 이름들 설정
        vc1.title = "메인"
        vc2.title = "검색"
        
                
        // 탭바로 사용하기 위한 뷰 컨트롤러들 설정
        tabBarVC.setViewControllers([vc1, vc2], animated: false)
        // 탭바를 클릭했을때 이후의 액션
        tabBarVC.modalPresentationStyle = .fullScreen
        // 탭바의 색상
        tabBarVC.tabBar.backgroundColor = .white
                
        // 탭바 이미지 설정 (이미지는 애플이 제공하는 것으로 사용)
        guard let items = tabBarVC.tabBar.items else { return }
        items[0].image = UIImage(systemName: "home")
        items[1].image = UIImage(systemName: "bell")
       
        
        // 탭바 보여주기
    
            
        // 기본루트뷰를 탭바컨트롤러로 설정하기
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
        
       
    

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       
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
