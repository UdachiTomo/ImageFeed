import UIKit

class OAuth2TokenStorage {
    static private let bearerToken = "Token"
    static var token: String? {
        get {
            return UserDefaults.standard.string(forKey: bearerToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: bearerToken)
        }
    }

}
