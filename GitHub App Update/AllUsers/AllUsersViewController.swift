import UIKit
import SnapKit

protocol AllUsersVMProtocol: AnyObject {
    func allUsersInfo()
}

class AllUsersViewController: UIViewController {

    private var logoGHImageView = UIImageView(),
                searchUserSearchBar = UISearchBar(),
                allUsersTableView = UITableView(),
                allLogins: [String] = [],
                allAvatarURLs: [String] = [],
                saveLogins: [String] = [],
                saveAvasURLs: [String] = []
    
    private var viewModel: AllUsersViewModel?,
                detailsCoordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AllUsersViewModel(view: self)
        allUsersInfo()
        
        view.backgroundColor = .systemGray4
        view.addSubview(logoGHImageView)
        view.addSubview(searchUserSearchBar)
        view.addSubview(allUsersTableView)
        
        logoGHImageView.image = UIImage(named: "logoGitHub")
        logoGHImageView.contentMode = .scaleAspectFit
        logoGHImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.width.equalTo(100)
            make.height.equalTo(60)
        }
        
        searchUserSearchBar.delegate = self
        searchUserSearchBar.placeholder = "Input user login"
        searchUserSearchBar.snp.makeConstraints { make in
            make.leading.equalTo(0)
            make.centerX.equalToSuperview()
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
            make.leading.equalTo(0)
            make.centerX.equalToSuperview()
            make.top.equalTo(searchUserSearchBar.snp.bottom).offset(0)
            make.bottom.equalTo(0)
        }
    }
}

extension AllUsersViewController: AllUsersVMProtocol {
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
        detailsCoordinator = Coordinator(rootController: self.navigationController ?? UINavigationController())
        detailsCoordinator?.didSelectUser(allLogins[indexPath.row], allAvatarURLs[indexPath.row])
    }
}

extension AllUsersViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            self.allAvatarURLs.removeAll()
            self.allLogins.removeAll()
            viewModel?.foundUsersInfo(foundUserName: searchText)
            viewModel?.allFoundUsers.subscribe { found in
                found.forEach { i in
                    i.items.forEach { j in
                        self.allLogins.append(j?.login ?? "User \(searchText) Not Found")
                        self.allAvatarURLs.append(j?.avatar_url ?? "-")
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
