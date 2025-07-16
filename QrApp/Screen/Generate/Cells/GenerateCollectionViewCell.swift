//
//  GenerateCollectionViewCell.swift
//  QrApp
//
//  Created by to hoang nam on 10/7/25.
//

import UIKit

class GenerateCollectionViewCell: UICollectionViewCell {
  

  @IBOutlet weak var image: UIImageView!

  var onGenerate : (() -> Void)?

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func config(model:GenerateModel){
    image.image = model.image
  }


  @IBAction func didTapBtn(_ sender: Any) {
    onGenerate?()
  }
  
}
