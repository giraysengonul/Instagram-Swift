//
//  NotificationController.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 13.08.2022.
//

import UIKit
private let reuseIdentifier = "NotificationCell"
class NotificationController: UITableViewController {
    // MARK: - PROPERTIES
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
}

// MARK: - HELPERS
extension NotificationController{
    private func setup(){
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        configureTableView()
        
    }
    private func layout(){
        
    }
    private func configureTableView(){
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
}
// MARK: - UITableViewDelegate/Datasource
extension NotificationController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        return cell
    }
}
