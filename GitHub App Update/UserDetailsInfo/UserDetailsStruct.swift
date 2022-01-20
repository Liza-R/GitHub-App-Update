import Foundation

class UserInfo {
    struct AllUserInfo: Decodable {
        var infoUser: MainUserInfo?
    }
    struct MainUserInfo: Decodable {
        var login: String
        var avatarURL: String
        var reposURL: String
        var name: String?
        var company: String?
        var location: String?
        var publicReposCount: Int
        var email: String?

        private enum CodingKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
            case reposURL = "repos_url"
            case name
            case company
            case location
            case publicReposCount = "public_repos"
            case email
        }
    }
}
