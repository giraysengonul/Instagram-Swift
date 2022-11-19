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
    private var notifications = [Notification](){
        didSet{ tableView.reloadData() }
    }
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchNotifications()
    }
}
// MARK: - API
extension NotificationController{
    private func fetchNotifications(){
        NotificationService.fetchNotifications { notifications in
            self.notifications = notifications
            self.checkIfUserFollowed()
        }
    }
    private func checkIfUserFollowed(){
        notifications.forEach { notification in
            guard notification.type == .follow else{ return }
            UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
                if let index = self.notifications.firstIndex(where: {$0.id == notification.id}){
                    self.notifications[index].userIsFollowed = isFollowed
                }
            }
        }
    }
}
// MARK: - HELPERS
extension NotificationController{
    private func setup(){
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        configureTableView()
        
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
        return notifications.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        cell.viewModel = NotificationViewModel(notification: notifications[indexPath.row])
        cell.delegate = self
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
// MARK: - NotificationCellDelegate
extension NotificationController: NotificationCellDelegate{
    func cell(_ cell: NotificationCell, watsToFollow uid: String) {
        
    }
    
    func cell(_ cell: NotificationCell, watsToUnfollow uid: String) {
        
    }
    
    func cell(_ cell: NotificationCell, watsToViewPost postId: String) {
        
    }
    
    
}
