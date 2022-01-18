import Foundation
import UIKit

protocol ViewControllerCoordinatorDelegate {
    func didSelectUser(_ userLogin: String, _ userAvatarURL: String)
}

class Coordinator{

    let rootController: UINavigationController
        
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
        
    func start() {
        showBaseVC()
    }
        
    func showBaseVC() {
        let vc = AllUsersViewController()
        rootController.pushViewController(vc, animated: true)
    }
        
    func showDetailsVC(userLogin: String, userAvatarURL: String) {
        let vc = UserDetailsViewController()
        vc.userLogin = userLogin
        vc.userAvatarURL = userAvatarURL
        rootController.pushViewController(vc, animated: true)
    }
}

extension Coordinator: ViewControllerCoordinatorDelegate {
    func didSelectUser(_ userLogin: String, _ userAvatarURL: String) {
        showDetailsVC(userLogin: userLogin, userAvatarURL: userAvatarURL)
    }
}
