import ImageFeed
import Foundation
import WebKit

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var view: ProfileViewViewControllerProtocol?
    var getAvatarURLCheck: Bool = false
    var updateProfileCheck: Bool = false
    var logOutCheck: Bool = false
    var showAlertCheck: Bool = false
    var cleanSessionCheck: Bool = false
    var viewDidLoadCheck: Bool = false
    var mockDetails = ("Anton Litvinov", "Udachi tomo", "Hello")
    
    func getAvatarURL() -> URL? {
        getAvatarURLCheck = true
        return nil
    }
    
    func updateProfileDetails() -> (profileName: String, profileTag: String, profileInfo: String)? {
        updateProfileCheck = true
        let profileName = mockDetails.0
        let profileTag = mockDetails.1
        let profileInfo = mockDetails.2
        return (profileName, profileTag, profileInfo)
    }
    
    func logOut() {
        logOutCheck = true
    }
    
    func showAlert(vc: UIViewController) {
        showAlertCheck = true
    }
    
    func viewDidLoad() {
        viewDidLoadCheck = true
    }
    
    static func cleanSession() {
        
    }
    
    
}
