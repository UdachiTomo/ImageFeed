import UIKit

enum Constants {
    static let accessKey = "B2t0umCHmqq8Z1AEyO1E6YQpfPAkKkpZQdmtN05oFEE"
    static let secretKey = "7-5BeWuCOveOKjGPkUI9AKgeZetglJVZlrq75G37Yvs"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL: URL = URL(string: "https://api.unsplash.com/")!
    static let authURLString = "https://unsplash.com/oauth/authorize"
}

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String
    
    static var standart: AuthConfiguration {
        return AuthConfiguration(accessKey: Constants.accessKey,
                                 secretKey: Constants.secretKey,
                                 redirectURI: Constants.redirectURI,
                                 accessScope: Constants.accessScope,
                                 defaultBaseURL: Constants.defaultBaseURL,
                                 authURLString: Constants.authURLString)
    }
    
    init(accessKey: String, secretKey: String, redirectURI: String, accessScope: String, defaultBaseURL: URL, authURLString: String) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURI
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
    }
}
