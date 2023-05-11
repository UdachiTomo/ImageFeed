import UIKit
import WebKit


protocol ProfilePresenterProtocol {
    var view: ProfileViewViewControllerProtocol? { get set}
    func getAvatarURL() -> URL?
    func updateProfileDetails() -> [String]?
//    func cleanAllService()
//    func logOut()
//    static func cleanSession()
}

final class ProfilePreseter: ProfilePresenterProtocol {
    weak var view: ProfileViewViewControllerProtocol?
    var profileService = ProfileService.shared
    
    
    func getAvatarURL() -> URL? {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return nil }
        return url
    }
    
    func updateProfileDetails() -> [String]? {
        guard
            let profileName = profileService.profile?.name,
            let profileTag = profileService.profile?.loginName,
            let profileInfo = profileService.profile?.bio
        else { return nil }
        return [profileName, profileTag, profileInfo]
    }
    
    func cleanAllService() {
        
    }
    
    func logOut() {
        
    }
    
    static func cleanSession() {
        
    }
    
    
}
