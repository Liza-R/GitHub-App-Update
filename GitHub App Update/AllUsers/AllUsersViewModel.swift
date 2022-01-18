import Foundation

class AllUsersViewModel {
    var firstUsers: Observer<[[FirstUsers.UserMainInfo]]> = Observer(value: [[]]),
        allFoundUsers: Observer<[FoundUsers.AllFoundUsers]> = Observer(value: [])
    
    private let allUsersService = AllUsersLoader(),
                foundUsersService = FoundUsersLoader()

    weak var view: AllUsersVMProtocol?
    
    required init(view: AllUsersVMProtocol) {
        self.view = view
        uploadAllUsersInfo()
    }
    
    func uploadAllUsersInfo() {
        var logins: [String] = [],
            avaURLs: [String] = []
        allUsersService.loadFirstUsers { firstUsers in
            DispatchQueue.main.async { [weak self] in
                self?.firstUsers.value = firstUsers
                self?.firstUsers.value.forEach { i in
                    i.forEach { j in
                        logins.append(j.login)
                        avaURLs.append(j.avatar_url)
                    }
                }
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
