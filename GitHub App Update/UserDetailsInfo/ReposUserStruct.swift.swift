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
        
        private enum CodingKeys: String, CodingKey {
            case name
            case statusRepo = "private"
            case description
            case createDate = "created_at"
            case updateDate = "updated_at"
            case pushDate = "pushed_at"
            case language
        }
    }
}
