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
            `private`: Bool,
            description: String?,
            created_at: String,
            updated_at: String?,
            pushed_at: String?,
            language: String?
    }
}
