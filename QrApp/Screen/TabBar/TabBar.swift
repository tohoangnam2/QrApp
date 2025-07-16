//
//  TabBar.swift
//  QrApp
//
//  Created by to hoang nam on 9/7/25.
//

import UIKit

class TabBar: UITabBarController {

    private let middleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupMiddleButton()
      selectedIndex = 1
    }
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
  }
    private func setupTabBar() {
      let generateVC = GenerateViewController()
        let homeVC = QrHomeViewController()
        let historyVC = HistoryViewController()

        // 3 tab
      generateVC.tabBarItem = UITabBarItem(title: "Generate", image: UIImage(resource: .tabbarGene), tag: 0)
      homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(), tag: 1)

        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(resource: .tabbarHistory), tag: 2)


        viewControllers = [
          UINavigationController(rootViewController: generateVC),
          UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: historyVC)
        ]
      tabBar.backgroundColor = .black
      tabBar.tintColor = .yellow
      tabBar.unselectedItemTintColor = .gray
      tabBar.layer.cornerRadius = 20
    }

    private func setupMiddleButton() {
        let image = UIImage(resource: .tabbarScanner)
        middleButton.setImage(image, for: .normal)
        middleButton.backgroundColor = UIColor.orange
        middleButton.layer.cornerRadius = 35

        // Viền sáng và bóng đổ
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.25
        middleButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        middleButton.layer.shadowRadius = 6

        // Tăng độ nét nút
        middleButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)

        // Kích thước và vị trí
        let buttonSize: CGFloat = 70
        middleButton.frame = CGRect(
            x: (tabBar.bounds.width - buttonSize) / 2,
            y: -20,
            width: buttonSize,
            height: buttonSize
        )

        // Thêm action
        middleButton.addTarget(self, action: #selector(didTapMiddleButton), for: .touchUpInside)

        tabBar.addSubview(middleButton)
        tabBar.bringSubviewToFront(middleButton)
    }

    @objc private func didTapMiddleButton() {
        selectedIndex = 1 // Chọn Home (index 1)
    }
}
