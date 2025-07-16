//
//  HistoryViewController.swift
//  QrApp
//
//  Created by to hoang nam on 9/7/25.
//

import UIKit

class HistoryViewController: UIViewController {
  
  @IBOutlet var historyTableView: UITableView!

  @IBOutlet var scanBtn: UIButton!
  
  @IBOutlet var createBtn: UIButton!
  
  var historyType : HistoryType = .scan

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        observeHistoryChange()


    }
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  func setup(){
    historyTableView.delegate = self
    historyTableView.dataSource = self
    historyTableView.separatorStyle = .none
    historyTableView.backgroundColor = .clear
    historyTableView.layer.cornerRadius = 10
    scanBtn.layer.cornerRadius = 10
    createBtn.layer.cornerRadius = 10

    historyTableView.register(UINib(nibName: "ScanTableViewCell", bundle: nil), forCellReuseIdentifier: "ScanTableViewCell")
    switch historyType {
    case .scan:
      scanBtn.tintColor = .white
      scanBtn.backgroundColor = UIColor(red: 253/255,
                                        green: 182/255,
                                        blue: 35/255,
                                        alpha: 1)
      createBtn.tintColor = .white
      createBtn.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    case .create:
      scanBtn.tintColor = .white
      scanBtn.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
      createBtn.tintColor = .white
      createBtn.backgroundColor = UIColor(red: 253/255,
                                          green: 182/255,
                                          blue: 35/255,
                                          alpha: 1)
    }
  }


  private func observeHistoryChange() {
          NotificationCenter.default.addObserver(self,
              selector: #selector(reloadHistory),
              name: .historyUpdated,
              object: nil)
      }

      @objc private func reloadHistory() {
          historyTableView.reloadData()
      }

  @IBAction func didTapSetting(_ sender: Any) {
  }

  @IBAction func didTapScan(_ sender: Any) {
    let vc = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
     vc.historyType = .scan
     navigationController?.pushViewController(vc, animated: false)

  }
  
  @IBAction func didTapCreate(_ sender: Any) {
    let vc = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
     vc.historyType = .create
     navigationController?.pushViewController(vc, animated: false)
  }
  

}
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        switch historyType {
        case .scan:   return HistoryStore.shared.scans.count
        case .create: return HistoryStore.shared.create.count
        }
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int { 1 }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let model: HistoryModel = {
                  switch historyType {
                  case .scan:
                      return HistoryStore.shared.scans[indexPath.section]
                  case .create:
                      return HistoryStore.shared.create[indexPath.section]
                  }
              }()

              let cell = tableView.dequeueReusableCell(withIdentifier: "ScanTableViewCell",
                                                       for: indexPath) as! ScanTableViewCell
              cell.config(model: model)
              return cell
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        UIView()          // nền trong suốt
    }
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 10
    }
}
