//
//  UITableViewControllerMod2.swift
//  UIKit section
//
//  Created by murad on 30.01.2025.
//

import UIKit

struct SettingsModel {
    let icon: UIImage
    let title: String
    let showToggle: Bool
}

struct SettingsSectionModel {
    let title: String
    let cells: [SettingsModel]
}

class UITableViewControllerMod2: UITableViewController {
    //MARK: - Properties
    
    private let tableViewHeader = ProfileHeaderView(frame: .zero)
    
    private let sections: [SettingsSectionModel] = [
        SettingsSectionModel(title: "Media", cells: [
            SettingsModel(
                icon: .customHeart,
                title: "Wishlist",
                showToggle: false
            ),
            SettingsModel(
                icon: .customDownload,
                title: "Download",
                showToggle: false
            )
        ]),
        SettingsSectionModel(title: "Preferences", cells: [
            SettingsModel(
                icon: .customMoon,
                title: "Dark Mode",
                showToggle: true
            ),
            SettingsModel(
                icon: .customPlanet,
                title: "Language",
                showToggle: false
            )
        ]),
        SettingsSectionModel(title: "Account", cells: [
            SettingsModel(
                icon: .customLogout,
                title: "Logout",
                showToggle: false
            ),
            SettingsModel(
                icon: .customShield,
                title: "Privacy",
                showToggle: true
            )
        ])
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
        
    }
    
    //MARK: - Setup appearance
    
    private func setupAppearance() {
        tableView.backgroundView = UIImageView(image: .backgroundTableView)
        tableView.separatorStyle = .none
        tableViewHeader.configure(
            with: .image3,
            name: "Aboba",
            email: "abobobob"
        )
        tableView.setup(header: tableViewHeader)
        tableView.updateHeaderLayout()
        
        tableView.reloadData()
    }
    
    //MARK: - Setup layout
    
    private func setupLayout() {
    }
    
    private func setupBehavior() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.cellID)
    }
}

//MARK: - UITableViewDataSource

extension UITableViewControllerMod2 {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            sections[section].title
        }
}

//MARK: - UITableViewDelegate

extension UITableViewControllerMod2 {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingsTableViewCell.cellID,
            for: indexPath
        ) as? SettingsTableViewCell else { return UITableViewCell() }
        
        let section = sections[indexPath.section]
        let model = section.cells[indexPath.row]
        
        cell.configure(with: model)
        cell.backgroundColor = .clear
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 37))
        
        headerView.backgroundColor = .white
        
        let titleLabel = PaddedLabel(
            frame: CGRect(
                x: 20,
                y: 0,
                width: tableView.bounds.width - 40,
                height: 37
            )
        )
        
        titleLabel.text = sections[section].title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .iconCell
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        60
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        37
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // 3. Update layout every time device frame is changed.
        DispatchQueue.main.async {
            self.tableView.updateHeaderLayout()
            self.tableView.reloadData()
        }
    }
}

extension UITableView {
    
    func setup(header: UIView) {
        header.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView = header
        
        header.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func updateHeaderLayout() {
        guard let tableHeader = tableHeaderView else { return }
        
        tableHeader.setNeedsLayout()
        tableHeader.layoutIfNeeded()
    }
}

final class PaddedLabel: UILabel {
    let textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom
        )
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        frame = frame.inset(by: UIEdgeInsets(
            top: -textInsets.top,
            left: -textInsets.left,
            bottom: -textInsets.bottom,
            right: -textInsets.right
        ))
    }
}
