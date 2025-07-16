  //
  //  DetailGenerateViewController.swift
  //  QrApp
  //
  //  Created by to hoang nam on 10/7/25.
  //

  import UIKit
  import Foundation
  import CoreImage

  class DetailGenerateViewController: UIViewController {



    @IBOutlet var titleLabel: UILabel!

    var selectedType: AllType?

      override func viewDidLoad() {
          super.viewDidLoad()
          setupView()
        self.navigationItem.hidesBackButton = true



      }

     func openQrScreen(with text: String) {
       let vc = OpenQrViewController(nibName: "OpenQrViewController", bundle: nil)
          vc.qrText = text
          vc.hidesBottomBarWhenPushed = true
          navigationController?.pushViewController(vc, animated: true)
    }




    func setupView(){
      guard let selected = selectedType else {
        return
      }
      switch selected {
      case .text :
        titleLabel.text = "Text"
        let textView = TextView()
              textView.translatesAutoresizingMaskIntoConstraints = false
              view.addSubview(textView)

              NSLayoutConstraint.activate([
                  textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                  textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                  textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                  textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400)


              ])


        textView.onGenerate = { [weak self] text in
          print("Tap Generate with text:", text) 

          let image = self?.generateThumbnail(from: text)
             let imageData = image?.jpegData(compressionQuality: 0.8)
          let record = HistoryModel(
                 histype: .create,
                 imageData: imageData,
                 title: text,
                 type: "TEXT",
                 date: Date()
             )
              HistoryStore.shared.add(record)

            self?.openQrScreen(with: text)   // push sang màn QR
        }




      case .wifi:
        titleLabel.text = "Text"
      case .web:
        titleLabel.text = "Text"

      case .contact:
        titleLabel.text = "Text"

      case .event:
        titleLabel.text = "Text"

      case .business:
        titleLabel.text = "Text"

      case .location:
        titleLabel.text = "Text"

      case .whatsapp:
        titleLabel.text = "Text"

      case .ig:
        titleLabel.text = "Text"

      case .tw:
        titleLabel.text = "Text"

      case .mail:
        titleLabel.text = "Text"

      case .phone:
        titleLabel.text = "Text"

      default:
        break
      }

    }
    private func generateThumbnail(from text: String, scale: CGFloat = 6) -> UIImage? {
        guard let data = text.data(using: .ascii),
              let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }

        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q",   forKey: "inputCorrectionLevel")

        guard let output = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        let scaled = output.transformed(by: transform)

        return UIImage(ciImage: scaled)
    }

    @IBAction func didTabBack(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)

    }

  }
  enum AllType{
    case text
    case wifi
    case web
    case contact
    case event
    case business
    case location
    case whatsapp
    case ig
    case tw
    case mail
    case phone
  }
