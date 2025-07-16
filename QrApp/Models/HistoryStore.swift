//
//  HistoryStore.swift
//  QrApp
//
//  Created by to hoang nam on 15/7/25.
//

import Foundation

final class HistoryStore {
    static let shared = HistoryStore()
    private init() {}

    private(set) var scans: [HistoryModel] = []

  private(set) var create: [HistoryModel] = []


    func add(_ model: HistoryModel) {
      switch model.histype {
      case .scan:
        scans.insert(model, at: 0)
      case .create:
        create.insert(model, at: 0)
      }
        NotificationCenter.default.post(name: .historyUpdated, object: nil)
    }

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
