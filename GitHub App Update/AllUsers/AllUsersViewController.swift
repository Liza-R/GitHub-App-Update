import UIKit
import SnapKit

class AllUsersViewController: UIViewController {
    private (set) var logoGHImageView = UIImageView()
    private (set) var searchUserSearchBar = UISearchBar()
    var allUsersTableView = UITableView()
    private var allLogins: [String] = []
    private var allAvatarURLs: [String] = []
    private var saveLogins: [String] = []
    private var saveAvasURLs: [String] = []
    
    var viewModel: AllUsersViewModel?
    var delegateCoordinator: AllUsersViewControllerCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allUsersInfo()
        
        view.backgroundColor = .systemGray4
        view.addSubview(logoGHImageView)
        view.addSubview(searchUserSearchBar)
        view.addSubview(allUsersTableView)
        
        logoGHImageView.image = UIImage(named: "logoGitHub")
        logoGHImageView.contentMode = .scaleAspectFit
        logoGHImageView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.height.equalTo(60)
        }
        
        searchUserSearchBar.delegate = self
        searchUserSearchBar.placeholder = "Input user login"
        searchUserSearchBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(logoGHImageView.snp.bottom).offset(0)
        }
        
        allUsersTableView.register(AllUsersTableViewCell.self, forCellReuseIdentifier: "allUsersCell")
        allUsersTableView.delegate = self
        allUsersTableView.dataSource = self
        
        allUsersTableView.rowHeight = 100
        allUsersTableView.separatorStyle = .singleLine
        allUsersTableView.separatorColor = .label
        allUsersTableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        allUsersTableView.tableFooterView = UIView()
        allUsersTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(searchUserSearchBar.snp.bottom)
        }
    }
    func allUsersInfo() {
        viewModel?.firstUsers.subscribe { info in
            info.forEach { i in
                i.forEach { j in
                    self.allLogins.append(j.login)
                    self.allAvatarURLs.append(j.avatarURL)
                }
            }
            self.allUsersTableView.reloadData()
            self.saveLogins = self.allLogins
            self.saveAvasURLs = self.allAvatarURLs
        }
    }
}

extension AllUsersViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allUsersCell", for: indexPath) as! AllUsersTableViewCell
        cell.userLoginLabel.text = allLogins[indexPath.row]
        AvatarLoader().loadImage(avaURL: allAvatarURLs[indexPath.row], image: cell.userAvatarImageView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLogins.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateCoordinator = Coordinator.init(rootController: self.navigationController ?? UINavigationController())
        delegateCoordinator?.didSelectUser(allLogins[indexPath.row])
    }
}

extension AllUsersViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            print("search")
            self.allAvatarURLs.removeAll()
            self.allLogins.removeAll()
            viewModel?.foundUsersInfo(foundUserName: searchText)
            viewModel?.allFoundUsers.subscribe { found in
                found.forEach { i in
                    i.items.forEach { j in
                        self.allLogins.append(j?.login ?? "User \(searchText) Not Found")
                        self.allAvatarURLs.append(j?.avatarURL ?? "-")
                    }
                }
            }
        }else{
            self.allLogins = self.saveLogins
            self.allAvatarURLs = self.saveAvasURLs
        }
        self.allUsersTableView.reloadData()
    }
}
