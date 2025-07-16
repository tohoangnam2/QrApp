//
//  TextView.swift
//  QrApp
//
//  Created by to hoang nam on 10/7/25.
//

import UIKit
import Foundation


class TextView: UIView {

  @IBOutlet weak var text: UITextField!
  @IBOutlet var contentView: UIView!

  var onGenerate: ((String) -> Void)?

  override init(frame: CGRect) {
      super.init(frame: frame)
      commonInit()
  }

  required init?(coder: NSCoder) {
      super.init(coder: coder)
      commonInit()
  }
  override func didMoveToWindow() {
      super.didMoveToWindow()
      text.becomeFirstResponder()
  }
  


  private func commonInit() {
      Bundle.main.loadNibNamed("TextView", owner: self, options: nil)
      addSubview(contentView)
      contentView.frame = self.bounds
      contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
           tap.cancelsTouchesInView = false
           contentView.addGestureRecognizer(tap)
  }

  @objc private func dismissKeyboard() {
          endEditing(true)
      }

  @IBAction func didTapGenerateQr(_ sender: Any) {
    guard let text = text.text, !text.isEmpty else { return }
    onGenerate?(text)
  }
  


  



}
