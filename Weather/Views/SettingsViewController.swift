//
//  SettingsViewController.swift
//  Weather
//
//  Created by Virender Dall on 02/09/21.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    lazy var viewModel: SettingViewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        if indexPath.row == 0 {
            cell.textLabel?.text = "Unit"
            cell.detailTextLabel?.text = viewModel.currentUnit().rawValue
        } else {
            cell.textLabel?.text = "Help"
            cell.detailTextLabel?.text = nil
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.showActionSheet(msg: "Unit", buttons: viewModel.allUnits(), clickedItem: {[weak self] item in
                self?.viewModel.saveUnit(unit: item)
                self?.tableView.reloadData()
                self?.postNotification()
            }, view: self.view)
        } else {
            self.performSegue(withIdentifier: "webpage", sender: nil)
        }
    }
    
    func postNotification() {
        NotificationCenter.default.post(name: NOTIFICATION_NAME, object: nil)
    }
}
