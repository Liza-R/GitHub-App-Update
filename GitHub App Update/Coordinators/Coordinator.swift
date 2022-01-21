import Foundation
import UIKit

protocol AllUsersViewControllerCoordinatorDelegate{
    func didSelectUser(_ userLogin: String)
}

class Coordinator{
    let rootController: UINavigationController
        
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
        
    func start() {
        showBaseVC()
        print("start coord")
    }
        
    func showBaseVC() {
        let vc = AllUsersViewController()
        vc.title = "GitHub Users"
        let vm = AllUsersViewModel()
        vc.viewModel = vm
        rootController.pushViewController(vc, animated: true)
    }
        
    func showDetailsVC(userLogin: String) {
        let vc = UserDetailsViewController()
        vc.title = "Main \(userLogin) infotrmation"
        let vm = UserDeatilsViewModel(chooseLogin: userLogin)
        vc.viewModel = vm
        rootController.pushViewController(vc, animated: true)
    }
}

extension Coordinator: AllUsersViewControllerCoordinatorDelegate {
    func didSelectUser(_ userLogin: String) {
        showDetailsVC(userLogin: userLogin)
    }
}
