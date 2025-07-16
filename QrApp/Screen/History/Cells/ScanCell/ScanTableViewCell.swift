//
//  ScanTableViewCell.swift
//  QrApp
//
//  Created by to hoang nam on 15/7/25.
//

import UIKit
import Foundation

protocol ScanTableViewCellDelegate: AnyObject {
    func scanCellDidRequestDelete(_ cell: ScanTableViewCell)
}

class ScanTableViewCell: UITableViewCell {

  @IBOutlet var hisScanImage: UIImageView!

  @IBOutlet var hisNameLabel: UILabel!

  @IBOutlet var hisTypeLabel: UILabel!

  @IBOutlet var hisTimeLabel: UILabel!

  weak var delegate: ScanTableViewCellDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    contentView.layer.cornerRadius = 12
    contentView.layer.masksToBounds = true
    backgroundColor = .clear


  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func config(model : HistoryModel){
    if let data = model.image {
      hisScanImage.image = data
    } else {
      let iconName = model.histype == .scan ? "icon_scan" : "icon_create"
      hisScanImage.image = UIImage(named: iconName)
    }

    hisTypeLabel.text = model.type

    let df = DateFormatter()
    df.dateFormat = "HH:mm dd/MM"
    hisTimeLabel.text = df.string(from: model.date)

  }

  @IBAction func didTapDeleteHis(_ sender: Any) {
    delegate?.scanCellDidRequestDelete(self)

  }


}

