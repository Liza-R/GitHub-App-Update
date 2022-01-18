import Foundation

class UserInfo {
    struct AllUserInfo: Decodable {
        var infoUser: MainUserInfo?
    }
    struct MainUserInfo: Decodable {
        var login: String,
            avatarURL: String,
            reposURL: String,
            name: String?,
            company: String?,
            location: String?,
            publicReposCount: Int,
            email: String?
        
        private enum NewKeys: String, CodingKey {
            case login, avatarURL = "avatar_url", reposURL = "repos_url", name, company, location, publicReposCount = "public_repos", email
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
