//
//  WelcomeViewController.swift
//  QrApp
//
//  Created by to hoang nam on 5/7/25.
//

import UIKit

class WelcomeViewController: UIViewController {

  @IBOutlet weak var welcomeBtn: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()

    welcomeBtn.layer.cornerRadius = 10
  }
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
  }


  @IBAction func didTapHome(_ sender: Any) {
    self.push(viewControllerType: TabBar.self,animated: false)
  }
  


}
