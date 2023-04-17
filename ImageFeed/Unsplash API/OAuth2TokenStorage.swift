import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    static let bearerToken = "Token"
    
    static var token: String? {
        set {
            guard let token = newValue else {
                KeychainWrapper.standard.removeObject(forKey: bearerToken)
                return
            }
            let isSuccess = KeychainWrapper.standard.set(token, forKey: bearerToken)
            guard isSuccess else {
                fatalError("Код не сохранен")
            }
        }
        get {
            KeychainWrapper.standard.string(forKey: bearerToken)
        }
    }
}
