//
//  SettingVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 19/06/2023.
//

import UIKit
import Foundation
struct Section{
    var title: String
    var options: [SettingsOptionType]
}
struct SettingsOption{
    let title: String
    let icon: UIImage
    let iconBackColor: UIColor
    let handler: (() -> Void)
}
enum SettingsOptionType{
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}
struct SettingsSwitchOption{
    let title: String
    let icon: UIImage
    let iconBackColor: UIColor
    let handler: (() -> Void)
    var isOn:Bool
}
class SettingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var models :[Section] = []
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        connfigureCell()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func connfigureCell(){
        self.models.append(Section(title: "General", options: [.switchCell(model: SettingsSwitchOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane")!, iconBackColor: .systemPink, handler: {
            
        },isOn: true))]))
        
        self.models.append(Section(title: "General", options: [.staticCell(model: SettingsOption(title: "Wifi", icon: UIImage(systemName: "house")!, iconBackColor: .systemPink, handler: {
            
        })),.staticCell(model: SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "cloud")!, iconBackColor: .link, handler: {
            
        })),.staticCell(model: SettingsOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane")!, iconBackColor: .systemBlue, handler: {
            
        })),.staticCell(model: SettingsOption(title: "iCloud", icon: UIImage(systemName: "cloud")!, iconBackColor: .systemGray, handler: {
            
        }))]))
        
        self.models.append(Section(title: "Information", options: [.staticCell(model: SettingsOption(title: "Wifi", icon: UIImage(systemName: "house")!, iconBackColor: .systemPink, handler: {
            
        })),.staticCell(model: SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "cloud")!, iconBackColor: .link, handler: {
            
        })),.staticCell(model: SettingsOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane")!, iconBackColor: .systemBlue, handler: {
            
        })),.staticCell(model: SettingsOption(title: "iCloud", icon: UIImage(systemName: "cloud")!, iconBackColor: .systemGray, handler: {
            
        }))]))
        
        self.models.append(Section(title: "Apps", options: [.staticCell(model: SettingsOption(title: "Wifi", icon: UIImage(systemName: "house")!, iconBackColor: .systemPink, handler: {
            
        })),.staticCell(model: SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "cloud")!, iconBackColor: .link, handler: {
            
        })),.staticCell(model: SettingsOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane")!, iconBackColor: .systemBlue, handler: {
            
        })),.staticCell(model: SettingsOption(title: "iCloud", icon: UIImage(systemName: "cloud")!, iconBackColor: .systemGray, handler: {
            
        }))]))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        switch model.self{
        case .staticCell(let model):
            if let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as?  SettingTableViewCell{
                cell.configure(with: model)
                return cell
            }
            return UITableViewCell()
        case .switchCell(let model):
            if let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as?  SwitchTableViewCell{
                cell.configure(with: model)
                return cell
            }
            return UITableViewCell()
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self{
        case .staticCell(model: let model):
            model.handler()
        case .switchCell(model: let model):
            model.handler()
        }
    }
    
    
}

