import ImageFeed
import Foundation
import WebKit

final class ProfilePresentSpy: ProfilePresenterProtocol {
    var view: ProfileViewViewControllerProtocol?
    var getAvatarURLCheck: Bool = false
    var updateProfileCheck: Bool = false
    var logOutCheck: Bool = false
    
    func getAvatarURL() -> URL? {
        getAvatarURLCheck = true
        return nil
    }
    
    func updateProfileDetails() -> (profileName: String, profileTag: String, profileInfo: String)? {
        updateProfileCheck = true
        return nil
    }
    
    func logOut() {
        logOutCheck = true
    }
    
    static func cleanSession() {
        
    }
    
    
}
