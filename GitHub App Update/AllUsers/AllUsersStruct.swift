import Foundation

class FirstUsers {
    struct UserMainInfo: Decodable {
        var login: String
        var avatarURL: String

        private enum CodingKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
        }
    }
}
