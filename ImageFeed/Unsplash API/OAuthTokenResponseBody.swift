import UIKit

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let refresh_token: String
    let scope: String
    let createdAt: Int
}
