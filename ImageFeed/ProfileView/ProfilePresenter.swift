import UIKit
import WebKit


protocol ProfilePresenterProtocol {
    var view: ProfileViewViewControllerProtocol? { get set}
    func getAvatarURL() -> URL?
    func updateProfileDetails() -> [String]?
    func logOut()
    static func cleanSession()
}

final class ProfilePreseter: ProfilePresenterProtocol {
    weak var view: ProfileViewViewControllerProtocol?
    private var profileService = ProfileService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    
    func switchToSplashViewController() {
       guard let window = UIApplication.shared.windows.first else {
           assertionFailure("Invalid Configuration")
           return
       }
       window.rootViewController = SplashViewController()
   }
    
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
    
    func logOut() {
        ProfilePreseter.cleanSession()
        ProfileService.shared.cleanSession()
        ProfileImageService.shared.cleanSession()
        ImagesListService.shared.cleanSession()
        OAuth2TokenStorage.token?.removeAll()
        self.switchToSplashViewController()
    }
    
    func viewDidLoad() {
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(forName: ProfileImageService.DidChangeNotification,
                         object: nil,
                         queue: .main
            ) { [weak self]  _ in
                guard let self = self else { return }
                self.view?.updateAvatar()
        }
    }
    
    static func cleanSession() {
           HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
           WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
              records.forEach { record in
                 WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
           }
        }
    }
}
