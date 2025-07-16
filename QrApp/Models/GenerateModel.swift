//
//  GenerateModel.swift
//  QrApp
//
//  Created by to hoang nam on 10/7/25.
//

import Foundation
import UIKit

struct GenerateModel {
  var image : UIImage?
  let type : AllType
}
let listGenerate = [
  GenerateModel(image: UIImage(resource: .col1), type: .text),
  GenerateModel(image: UIImage(resource: .col2), type: .wifi),
  GenerateModel(image: UIImage(resource: .col3), type: .web),
  GenerateModel(image: UIImage(resource: .col4), type: .contact),
  GenerateModel(image: UIImage(resource: .col5), type: .event),
  GenerateModel(image: UIImage(resource: .col6), type: .business),
  GenerateModel(image: UIImage(resource: .col7), type: .location),
  GenerateModel(image: UIImage(resource: .col8), type: .whatsapp),
  GenerateModel(image: UIImage(resource: .col9), type: .ig),
  GenerateModel(image: UIImage(resource: .col10), type: .tw),
  GenerateModel(image: UIImage(resource: .col11), type: .mail),
  GenerateModel(image: UIImage(resource: .col12), type: .phone)


]
