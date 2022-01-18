import Foundation

class PublicReposInfo {
    struct AllPublicRepos: Decodable {
        var infoRepo: [RepoInfo?]
    }
    struct RepoInfo: Decodable {
        var infoRepoMass: DetailsRepoInfo?
    }
    struct DetailsRepoInfo: Decodable {
        var name: String,
            statusRepo: Bool,
            description: String?,
            createDate: String,
            updateDate: String?,
            pushDate: String?,
            language: String?
        
        private enum NewKeys: String, CodingKey {
            case name, statusRepo = "private", description, createDate = "created_at", updateDate = "updated_at", pushDate = "pushed_at", language
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
