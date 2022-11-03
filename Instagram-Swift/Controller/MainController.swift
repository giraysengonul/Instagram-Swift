//
//  MainController.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 13.08.2022.
//

import UIKit
import FirebaseAuth
import YPImagePicker
class MainController: UITabBarController {
    // MARK: - PROPERTIES
    private var user: User?{
        didSet{
            guard let user = user else { return }
            setup(withUser: user) }
    }
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.tintColor = .black
    }
    override func viewDidAppear(_ animated: Bool) {
        checkIfUserIsLoggedIn()
        fetchUser()
    }
}
// MARK: - HELPERS
extension MainController{
    
    private func setup(withUser user: User){
        self.delegate = self
        let layout = UICollectionViewFlowLayout()
        //        layout.minimumLineSpacing  = 10
        //        layout.minimumInteritemSpacing = 10
        //        layout.itemSize = CGSize(width: view.frame.width, height: 100)
        //        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let feed = templateNavigationController(image: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
        let search =  templateNavigationController(image: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        let imageSelector =  templateNavigationController(image: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
        let notification =  templateNavigationController(image: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController())
        let profileController = ProfileController(user: user)
        let profile =  templateNavigationController(image: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_unselected"), rootViewController: profileController)
        
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
        nav.navigationBar.compactScrollEdgeAppearance = navigationAppearance
        
        return nav
    }
    private func didFinishPickingMedia(_ picker: YPImagePicker){
        picker.didFinishPicking { items, cancelled in
            picker.dismiss(animated: true) {
                guard let selectedImage = items.singlePhoto?.image else{ return }
                let controller = UploadPostController()
                controller.selectedImage = selectedImage
                controller.delegate = self
                controller.currentUser = self.user
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    }
    
}
// MARK: - API
extension MainController{
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            
        }
    }
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
}
// MARK: - AuthenticationDelegate
extension MainController: AuthenticationDelegate{
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true)
    }
}
// MARK: - UITabBarControllerDelegate
extension MainController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesBottomBar = false
            config.hidesStatusBar = false
            config.library.maxNumberOfItems = 1
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true)
            didFinishPickingMedia(picker)
        }
        return true
    }
}
// MARK: - UploadPostControllerDelegate
extension MainController: UploadPostControllerDelegate{
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        selectedIndex = 0
        controller.dismiss(animated: true)
        guard let feedNav = viewControllers?.first as? UINavigationController else { return }
        guard let feed = feedNav.viewControllers.first as? FeedController else { return  }
        feed.handleRefresh()
    }
}
