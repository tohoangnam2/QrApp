//
//  SplashViewController.swift
//  QrApp
//
//  Created by to hoang nam on 3/7/25.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.goToMainScreen()
            }
    }
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
  }


  func goToMainScreen(){
    self.push(viewControllerType: WelcomeViewController.self)
  }

}
