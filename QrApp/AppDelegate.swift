//
//  AppDelegate.swift
//  QrApp
//
//  Created by to hoang nam on 3/7/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Khởi tạo window
       window = UIWindow(frame: UIScreen.main.bounds)

       // Tạo SplashViewController
       let splashVC = SplashViewController()

       // Bọc splashVC vào NavigationController và ẩn luôn thanh điều hướng
       let nav = UINavigationController(rootViewController: splashVC)
       nav.setNavigationBarHidden(true, animated: false)

       // Gán vào window
       window?.rootViewController = nav
       window?.makeKeyAndVisible()

       return true
  }

  // MARK: UISceneSession Lifecycle




}

