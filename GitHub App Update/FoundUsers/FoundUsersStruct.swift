import Foundation

class FoundUsers {
    struct AllFoundUsers: Decodable {
        var items: [MainFoundUsersInfo?]
    }
    struct MainFoundUsersInfo: Decodable {
        var login: String,
            avatar_url: String
    }
}
