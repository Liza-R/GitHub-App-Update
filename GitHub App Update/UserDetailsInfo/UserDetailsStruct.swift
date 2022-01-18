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
        
        private enum NewKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
            case reposURL = "repos_url"
            case name
            case company
            case location
            case publicReposCount = "public_repos"
            case email
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: NewKeys.self)
            login = try container.decode(String.self, forKey: .login)
            avatarURL = try container.decode(String.self, forKey: .avatarURL)
            reposURL = try container.decode(String.self, forKey: .reposURL)
            name = try container.decode(String?.self, forKey: .name)
            company = try container.decode(String?.self, forKey: .company)
            location = try container.decode(String?.self, forKey: .location)
            publicReposCount = try container.decode(Int.self, forKey: .publicReposCount)
            email = try container.decode(String?.self, forKey: .email)
        }
    }
}
