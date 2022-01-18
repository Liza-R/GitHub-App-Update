import Foundation

class UserInfo {
    struct AllUserInfo: Decodable {
        var infoUser: MainUserInfo?
    }
    struct MainUserInfo: Decodable {
        var login: String,
            avatar_url: String,
            repos_url: String,
            name: String?,
            company: String?,
            location: String?,
            public_repos: Int,
            email: String?
    }
}
