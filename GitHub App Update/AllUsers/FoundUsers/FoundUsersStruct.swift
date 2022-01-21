import Foundation

class FoundUsers {
    struct AllFoundUsers: Decodable {
        var items: [MainFoundUsersInfo?]
    }
    struct MainFoundUsersInfo: Decodable {
        var login: String
        var avatarURL: String
        
        private enum CodingKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
        }
    }
}
