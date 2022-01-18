import Foundation
import Alamofire

class AllUsersLoader {
    func loadFirstUsers(completion: @escaping ([[FirstUsers.UserMainInfo]]) -> Void) {
        AF.request(URL(string: "https://api.github.com/users")!, method: .get)
        .validate()
        .responseDecodable(of: [FirstUsers.UserMainInfo].self) { (response) in
            guard let allUsersInfo = response.value else { return }
            completion([allUsersInfo])
        }
    }
}
