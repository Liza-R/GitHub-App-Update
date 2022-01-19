import Foundation

class AllUsersViewModel {
    var firstUsers: Observer<[[FirstUsers.UserMainInfo]]> = Observer(value: [[]])
    var allFoundUsers: Observer<[FoundUsers.AllFoundUsers]> = Observer(value: [])
    
    private let allUsersService = AllUsersLoader()
    private let foundUsersService = FoundUsersLoader()

    init() {
        uploadAllUsersInfo()
    }

    func uploadAllUsersInfo() {
        allUsersService.loadFirstUsers { firstUsers in
            DispatchQueue.main.async { [weak self] in
                self?.firstUsers.value = firstUsers
            }
        }
    }
    
    func foundUsersInfo(foundUserName: String) {
        foundUsersService.loadAllFoundUsers(foundUserName: foundUserName) { allFoundUsers in
            DispatchQueue.main.async { [weak self] in
                self?.allFoundUsers.value = allFoundUsers
            }
        }
    }
}
