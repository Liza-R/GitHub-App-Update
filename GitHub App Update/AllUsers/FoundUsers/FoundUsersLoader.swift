import Foundation
import Alamofire

class FoundUsersLoader {
    func loadAllFoundUsers(foundUserName: String, completion: @escaping ([FoundUsers.AllFoundUsers]) -> Void) {
        let searchUserURL = "https://api.github.com/search/users?q=\(foundUserName)".encodeUrl
        AF.request(URL(string: searchUserURL)!, method: .get)
        .validate()
        .responseDecodable(of: FoundUsers.AllFoundUsers.self) { (response) in
            guard let allSearchUsersInfo = response.value else { return }
            completion([allSearchUsersInfo])
        }
    }
}
