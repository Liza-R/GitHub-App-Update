import UIKit
import SnapKit

protocol AllDetailsVMProtocol: AnyObject {
    func allUserDetails()
}

struct UserDetailsViewControllerModel {
    var reposNames: [String],
        reposStatuses: [String],
        reposDescriptions: [String],
        reposCreateDates: [String],
        reposUpdateDates: [String],
        reposPushDates: [String],
        reposLanguages: [String]
}

class UserDetailsViewController: UIViewController {

    private var loginLabel = UILabel(),
                avatarImageView = UIImageView(),
                nameLabel = UILabel(),
                companyNameLabel = UILabel(),
                locationLabel = UILabel(),
                emailLabel = UILabel(),
                countPublicReposLabel = UILabel(),
                reposTableView = UITableView(),
                
                reposNames: [String] = [],
                reposStatuses: [String] = [],
                reposDescriptions: [String] = [],
                reposCreateDates: [String] = [],
                reposUpdateDates: [String] = [],
                reposPushDates: [String] = [],
                reposLanguages: [String] = []
    
    var userLogin = "",
        userAvatarURL = "",
        userReposURL = ""
    
    private var viewModel: UserDeatilsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginLabel)
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(companyNameLabel)
        view.addSubview(locationLabel)
        view.addSubview(emailLabel)
        view.addSubview(countPublicReposLabel)
        view.addSubview(reposTableView)
        
        viewModel = UserDeatilsViewModel(view: self, chooseLogin: userLogin)
        viewModel?.repoPresenter = RepoPresenter()
        viewModel?.repoPresenter?.viewController = self
    }
    
    func uploadReposInfo(_ model: UserDetailsViewControllerModel){
        reposNames = model.reposNames
        reposStatuses = model.reposStatuses
        reposDescriptions = model.reposDescriptions
        reposCreateDates = model.reposCreateDates
        reposUpdateDates = model.reposUpdateDates
        reposPushDates = model.reposPushDates
        reposLanguages = model.reposLanguages
        reposTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allUserDetails()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loginLabel.font = UIFont.boldSystemFont(ofSize: 22)
        loginLabel.textAlignment = .center
        loginLabel.text = userLogin
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        AvatarLoader().loadImage(avaURL: userAvatarURL, image: avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(loginLabel.snp.bottom).offset(5)
        }
        
        nameLabel.textAlignment = .center
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(5)
            make.leading.equalTo(20)
            make.centerX.equalToSuperview()
        }

        companyNameLabel.textAlignment = .center
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        locationLabel.textAlignment = .center
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.textAlignment = .center
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(5)
            make.leading.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        countPublicReposLabel.textAlignment = .center
        countPublicReposLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.leading.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        reposTableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "repoCell")
        reposTableView.delegate = self
        reposTableView.dataSource = self
        reposTableView.rowHeight = 155
        reposTableView.separatorStyle = .singleLine
        reposTableView.separatorColor = .label
        reposTableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        reposTableView.tableFooterView = UIView()
        reposTableView.snp.makeConstraints { make in
            make.top.equalTo(countPublicReposLabel.snp.bottom).offset(10)
            make.leading.equalTo(0)
            make.bottom.equalTo(0)
            make.centerX.equalToSuperview()
        }
    }
}

extension UserDetailsViewController: AllDetailsVMProtocol {
    func allUserDetails() {
        viewModel?.userDetails.subscribe { info in
            info.forEach { i in
                self.loginLabel.text = "Login: " + i.login
                self.nameLabel.text = "Name: " + (i.name ?? "User Name Not Found")
                self.companyNameLabel.text = "Company: " + (i.company ?? "Company Name Not Found")
                self.locationLabel.text = "Location: " + (i.location ?? "Location Not Found")
                self.emailLabel.text = "E-mail: " + (i.email ?? "User E-mail Not Found")
                self.countPublicReposLabel.text = "Public repos: " + String(i.public_repos)
                self.userReposURL = i.repos_url
            }
        }
    }
}


extension UserDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepoTableViewCell
        cell.nameLabel.text = reposNames[indexPath.row]
        cell.statusLabel.text = reposStatuses[indexPath.row]
        cell.descriptionLabel.text = reposDescriptions[indexPath.row]
        cell.createDateLabel.text = reposCreateDates[indexPath.row]
        cell.updateDateLabel.text = reposUpdateDates[indexPath.row]
        cell.pushDateLabel.text = reposPushDates[indexPath.row]
        cell.langLabel.text = reposLanguages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposNames.count
    }
}

