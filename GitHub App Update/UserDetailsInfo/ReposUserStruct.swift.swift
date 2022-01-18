import Foundation

class PublicReposInfo {
    struct AllPublicRepos: Decodable {
        var infoRepo: [RepoInfo?]
    }
    struct RepoInfo: Decodable {
        var infoRepoMass: DetailsRepoInfo?
    }
    struct DetailsRepoInfo: Decodable {
        var name: String
        var statusRepo: Bool
        var description: String?
        var createDate: String
        var updateDate: String?
        var pushDate: String?
        var language: String?
        
        private enum NewKeys: String, CodingKey {
            case name
            case statusRepo = "private"
            case description
            case createDate = "created_at"
            case updateDate = "updated_at"
            case pushDate = "pushed_at"
            case language
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: NewKeys.self)
            name = try container.decode(String.self, forKey:.name)
            statusRepo = try container.decode(Bool.self, forKey: .statusRepo)
            description = try container.decode(String?.self, forKey: .description)
            createDate = try container.decode(String.self, forKey: .createDate)
            updateDate = try container.decode(String?.self, forKey: .updateDate)
            pushDate = try container.decode(String?.self, forKey: .pushDate)
            language = try container.decode(String?.self, forKey: .language)
        }
    }
}
