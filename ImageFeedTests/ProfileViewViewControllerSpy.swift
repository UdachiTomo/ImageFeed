import ImageFeed
import Foundation

final class ProfileViewViewControllerSpy: ProfileViewViewControllerProtocol {
    
    var presenter: ImageFeed.ProfilePresenterProtocol?
    var updateAvatarCheck: Bool = false
    var updateProfileDetails: Bool = false
    
    func updateAvatar() {
        updateAvatarCheck = true
    }
    
}
