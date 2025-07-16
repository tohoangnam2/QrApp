//
//  SettingViewController.swift
//  QrApp
//
//  Created by to hoang nam on 11/7/25.
//

import UIKit

class SettingViewController: UIViewController {
  @IBOutlet var view1: UIView!
  
  @IBOutlet var view2: UIView!
  
  @IBOutlet var view3: UIView!
  
  @IBOutlet var view4: UIView!
  
  @IBOutlet var view5: UIView!


  override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }

  func setup(){

    let boder = [view1,view2,view3,view4,view5]

    boder.forEach{v in
      v?.layer.cornerRadius = 10
    }

  }
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = true
      navigationController?.setNavigationBarHidden(true, animated: false)   // ẩn khi màn hiện
  }
  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
    self.tabBarController?.tabBar.isHidden = false
      navigationController?.setNavigationBarHidden(false, animated: false)  // hiện lại khi rời đi
  }


  @IBAction func didTabBackGenerate(_ sender: Any) {
    navigationController?.popViewController(animated: false)
  }
  

}
