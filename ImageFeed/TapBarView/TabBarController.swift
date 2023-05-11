import UIKit
 
final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let imageListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController")
        
        let profileViewController = ProfileViewController()
        profileViewController.configure(ProfilePreseter())
        profileViewController.updateAvatar()
        profileViewController.updateProfileDetails()
        profileViewController.tabBarItem = UITabBarItem(title: nil,
                                                        image: UIImage(named: "tab_profile_active"),
                                                        selectedImage: nil)
        
        self.viewControllers = [imageListViewController, profileViewController]
    }
} 
