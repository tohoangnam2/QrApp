//
//  GenerateViewController.swift
//  QrApp
//
//  Created by to hoang nam on 9/7/25.
//

import UIKit

class GenerateViewController: UIViewController {

  @IBOutlet weak var generateCollectionView: UICollectionView!



  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  func setup(){
    generateCollectionView.dataSource = self
    generateCollectionView.delegate = self
    generateCollectionView.register(UINib(nibName: "GenerateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenerateCollectionViewCell")
    generateCollectionView.collectionViewLayout = createLayout()
  }
  func createLayout() -> UICollectionViewCompositionalLayout {
    // Item
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1/3),
      heightDimension: .fractionalHeight(1)))
    item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)

    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(1/4)),
      repeatingSubitem: item,
      count: 3)
    group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    //section
    let section = NSCollectionLayoutSection(group: group)


    //return
    return UICollectionViewCompositionalLayout(section: section)




  }
  @IBAction func didTapSetting(_ sender: Any) {
    self.push(viewControllerType: SettingViewController.self,animated: false)
    
  }
  

}
extension GenerateViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listGenerate.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = generateCollectionView.dequeueReusableCell(withReuseIdentifier: "GenerateCollectionViewCell", for: indexPath) as! GenerateCollectionViewCell
    let model = listGenerate[indexPath.row] // ✅ đưa ra ngoài

    cell.config(model: model)

    cell.onGenerate = {
      let vc = DetailGenerateViewController(nibName: "DetailGenerateViewController", bundle: nil)
      vc.selectedType = model.type
      vc.hidesBottomBarWhenPushed = true
      self.navigationController?.pushViewController(vc, animated: true)
    }
    return cell
  }
}
