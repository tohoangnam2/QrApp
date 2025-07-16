//
//  HistoryModel.swift
//  QrApp
//
//  Created by to hoang nam on 15/7/25.
//

import Foundation
import UIKit



struct HistoryModel : Codable {

  let histype : HistoryType
  //scan
  let imageData : Data?
  let title : String
  let type : String
  let date : Date

  var image: UIImage? {
          if let imageData = imageData {
              return UIImage(data: imageData)
          }
          return nil
      }


  enum HistoryType : String, Codable {
    case scan
    case create
  }
}


