//
//  HistoryStore.swift
//  QrApp
//
//  Created by to hoang nam on 15/7/25.
//

import Foundation

final class HistoryStore {
  static let shared = HistoryStore()
  private init() {
    loadHistory()

  }

  private(set) var scans: [HistoryModel] = []

  private(set) var create: [HistoryModel] = []




  func saveHistory() {
    let encoder = JSONEncoder()
    if let data = try? encoder.encode(scans) {
      UserDefaults.standard.set(data, forKey: "scanHistory")
      
    }

    if let data = try? encoder.encode(create) {
      UserDefaults.standard.set(data, forKey: "createHistory")
    }
  }

  func loadHistory() {
    let decoder = JSONDecoder()
    if let scanData = UserDefaults.standard.data(forKey: "scanHistory"),
       let savedScans = try? decoder.decode([HistoryModel].self, from: scanData) {
      scans = savedScans
    }

    if let createData = UserDefaults.standard.data(forKey: "createHistory"),
       let savedCreates = try? decoder.decode([HistoryModel].self, from: createData) {
      create = savedCreates
    }
  }



  func add(_ model: HistoryModel) {
    switch model.histype {
    case .scan:
      scans.insert(model, at: 0)
    case .create:
      create.insert(model, at: 0)
    }
    saveHistory()
    NotificationCenter.default.post(name: .historyUpdated, object: nil)
  }

//  func delete(at index: Int, for type: HistoryModel.HistoryType) {
//      switch type {
//      case .scan:
//          guard scans.indices.contains(index) else { return }
//          scans.remove(at: index)
//      case .create:
//          guard create.indices.contains(index) else { return }
//          create.remove(at: index)
//      }
//
//      saveHistory()
//      NotificationCenter.default.post(name: .historyUpdated, object: nil)
//  }





  func observe(_ observer: Any, selector: Selector) {
    NotificationCenter.default.addObserver(observer,
                                           selector: selector,
                                           name: .historyUpdated,
                                           object: nil)
  }
}

extension Notification.Name {
  static let historyUpdated = Notification.Name("HistoryStoreDidUpdate")
}
