import Foundation
import UIKit
import Alamofire

class AvatarLoader {
    func loadImage(avaURL: String, image: UIImageView) {
        AF.request(avaURL ,method: .get).response { response in
            switch response.result {
                case .success(let responseData):
                    image.image = UIImage(data: responseData!, scale:1) ?? UIImage(named: "logoGitHub")
                 case .failure(let error):
                    print("error---> avatar loading", error, response.response?.statusCode as Any)
            }
        }
    }
}
