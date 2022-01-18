import Foundation
import Alamofire

class UserLoader {
    func loadUserInfo(chooseLogin: String, completion: @escaping (UserInfo.MainUserInfo) -> Void) {
        let userURL = "https://api.github.com/users/\(chooseLogin)".encodeUrl
        AF.request(URL(string: userURL)!)
        .validate()
        .responseDecodable(of: UserInfo.MainUserInfo.self) { (response) in
            print(String(describing: response.error as Any), "error --> load user info", response.response?.statusCode as Any)
            guard let userInfo = response.value else { return }
            completion(userInfo)
        }
    }
}
