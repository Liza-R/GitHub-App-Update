import Foundation

class FirstUsers {
    struct UserMainInfo: Decodable {
        var login: String,
            avatarURL: String

        private enum NewKeys : String, CodingKey {
            case login, avatarURL = "avatar_url"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: NewKeys.self)
            login = try container.decode(String.self, forKey: .login)
            avatarURL = try container.decode(String.self, forKey: .avatarURL)
        }
    }
}
