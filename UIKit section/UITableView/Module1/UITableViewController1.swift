//
//  UITableViewController.swift
//  UIKit section
//
//  Created by murad on 30.01.2025.
//

import UIKit

struct User {
    let title: String
    let detail: String
}

struct SettingSection {
    let title: String
    let items: [User]
}

class UITableViewController1: UIViewController {
    //MARK: - Properties
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let settings: [SettingSection] = [
        SettingSection(
            title: "Профиль",
            items: [User(title: "Account", detail: "Details")]
        ),
        SettingSection(
            title: "Нотификации",
            items: [
                User(title: "Email", detail: "on"),
                User(title: "Push", detail: "off")
            ]
        ),
        SettingSection(
            title: "About",
            items: [
                User(title: "Privacy", detail: "Look around"),
                User(title: "Contacts", detail: "Near you"),
                User(title: "Bluetooth", detail: "Always on")
            ]
        )
    ]
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        embededViews()
        setupLayout()
        setupBehavior()
    }
    
    //MARK: - Embed views
    
    private func embededViews() {
        view.addSubview(tableView)
    }
    
    //MARK: - Setup appearance
    
    private func setupAppearance() {
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - Setup layout
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBehavior() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: String.settingsCell)
    }
}

//MARK: - UITableViewDelegate

extension UITableViewController1: UITableViewDelegate {
}

//MARK: - UITableViewDataSource

extension UITableViewController1: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        settings[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String.settingsCell, for: indexPath) as? SubtitleTableViewCell else { return UITableViewCell() }
        
        let section = settings[indexPath.section]
        let item = section.items[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.detail
        cell.backgroundColor = .gray.withAlphaComponent(0.2)
        return cell
    }
}

private extension String {
    static let settingsCell = "SettingsCell"
}

class SubtitleTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // Указываем стиль .subtitle
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
