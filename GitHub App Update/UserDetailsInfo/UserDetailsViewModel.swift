import Foundation
import Alamofire

class UserDeatilsViewModel {
    var userDetails: Observer<[UserInfo.MainUserInfo]> = Observer(value: [])
    var repoPresenter: RepoPresenter?
    
    private let allDetailsService = UserLoader()
    private let allPublicReposService = RepoLoader()

    required init(chooseLogin: String) {
        uploadAllDetailsInfo(chooseLogin: chooseLogin)
        uploadAllReposInfo(chooseLogin: chooseLogin)
    }
    
    func uploadAllDetailsInfo(chooseLogin: String) {
        allDetailsService.loadUserInfo(chooseLogin: chooseLogin) { userDetails in
            DispatchQueue.main.async { [weak self] in
                self?.userDetails.value = [userDetails]
            }
        }
    }
    
    func uploadAllReposInfo(chooseLogin: String) {
        allPublicReposService.loadRepoInfo(chooseLogin: chooseLogin) { allReposInfo in
            DispatchQueue.main.async { [weak self] in
                self?.repoPresenter?.allReposInfo.value = allReposInfo
            }
        }
    }
}
