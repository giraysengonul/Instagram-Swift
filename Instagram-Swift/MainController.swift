//
//  MainController.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 13.08.2022.
//

import UIKit

class MainController: UITabBarController {
    // MARK: - PROPERTIES
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .white
        tabBar.tintColor = .black
    }
}


// MARK: - HELPERS
extension MainController{
    
    private func setup(){
        let feed = templateNavigationController(image: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController())
        let search =  templateNavigationController(image: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        let imageSelector =  templateNavigationController(image: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
        let notification =  templateNavigationController(image: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController())
        let profile =  templateNavigationController(image: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_unselected"), rootViewController: ProfileController())
        
        viewControllers = [feed, search, imageSelector, notification, profile]
    }
    
    func templateNavigationController(image: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.backgroundColor = .secondarySystemBackground
        nav.tabBarItem.standardAppearance = tabbarAppearance
        nav.tabBarItem.scrollEdgeAppearance = tabbarAppearance
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = .secondarySystemBackground
        nav.navigationBar.standardAppearance = navigationAppearance
        nav.navigationBar.scrollEdgeAppearance = navigationAppearance
        nav.navigationBar.compactAppearance = navigationAppearance
        
        return nav
    }
    
}
