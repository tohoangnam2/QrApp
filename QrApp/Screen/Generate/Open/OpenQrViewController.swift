//
//  OpenQrViewController.swift
//  QrApp
//
//  Created by to hoang nam on 11/7/25.
//

import UIKit
import CoreImage.CIFilterBuiltins

class OpenQrViewController: UIViewController {

  @IBOutlet var showQrImage: UIImageView!

  var qrText : String?


    override func viewDidLoad() {
        super.viewDidLoad()

      showQrImage.layer.cornerRadius = 10
      showQr()
    }

  func showQr(){
    guard let text = qrText,
          let qrImage = generateQRCode(from: text) else {return}

    showQrImage.image = qrImage
  }
      private func generateQRCode(from string: String,
                                  scale: CGFloat = 10) -> UIImage? {

          let data = Data(string.utf8)
          let filter = CIFilter.qrCodeGenerator()
          filter.setValue(data, forKey: "inputMessage")
          filter.setValue("Q",   forKey: "inputCorrectionLevel")   // L/M/Q/H

          guard let ciImage = filter.outputImage else { return nil }
          let transform  = CGAffineTransform(scaleX: scale, y: scale)
          let scaledCI   = ciImage.transformed(by: transform)

          return UIImage(ciImage: scaledCI)
      }

  @IBAction func didTapBack(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  

}
