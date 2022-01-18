import Foundation

class RepoPresenter{
    weak var viewController: UserDetailsViewController?
    
    var allReposInfo: Observer<[[PublicReposInfo.DetailsRepoInfo]]> = Observer(value: [[]])
    
    init(){
        presentRepos()
    }
    
    func presentRepos() {
        var reposNames: [String] = [],
            reposStatuses: [String] = [],
            reposDescriptions: [String] = [],
            reposCreateDates: [String] = [],
            reposUpdateDates: [String] = [],
            reposPushDates: [String] = [],
            reposLanguages: [String] = [],
            formatter = Formatter()
        
        allReposInfo.subscribe { repo in
            repo.forEach { i in
                i.forEach { j in
                    reposNames.append("\(j.name)")
                    reposDescriptions.append(j.description ?? "Description Not Found")
                    reposCreateDates.append("Created: " + formatter.formatteDate(date: j.created_at))
                    reposUpdateDates.append("Updated: " + formatter.formatteDate(date: j.updated_at ?? ""))
                    reposPushDates.append("Pushed: " + formatter.formatteDate(date: j.pushed_at ?? ""))
                    reposLanguages.append(j.language ?? "Languages Not Found")
                    reposStatuses.append(formatter.formattePrivate(status: j.private))
                }
            }
            self.viewController?.uploadReposInfo(.init(reposNames: reposNames, reposStatuses: reposStatuses, reposDescriptions: reposDescriptions, reposCreateDates: reposCreateDates, reposUpdateDates: reposUpdateDates, reposPushDates: reposPushDates, reposLanguages: reposLanguages))
        }
    }
}
