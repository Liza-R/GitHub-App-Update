import Foundation
import Alamofire

class RepoLoader {
    func loadRepoInfo(chooseLogin: String, completion: @escaping ([[PublicReposInfo.DetailsRepoInfo]]) -> Void) {
        let repoURL = "https://api.github.com/users/\(chooseLogin)/repos".encodeUrl
        AF.request(URL(string: repoURL)!)
        .validate()
        .responseDecodable(of: [PublicReposInfo.DetailsRepoInfo].self) { (response) in
            print(String(describing: response.error as Any), "error --> load repo info", response.response?.statusCode as Any)
            guard let repoInfo = response.value else { return }
            completion([repoInfo])
        }
    }
}
