import UIKit
import SnapKit

protocol AllDetailsVMProtocol: AnyObject {
    func allUserDetails()
}

struct UserDetailsViewControllerModel {
    var reposNames: [String]
    var reposStatuses: [String]
    var reposDescriptions: [String]
    var reposCreateDates: [String]
    var reposUpdateDates: [String]
    var reposPushDates: [String]
    var reposLanguages: [String]
}

class UserDetailsViewController: UIViewController {

    private var loginLabel = UILabel()
    private var avatarImageView = UIImageView()
    private var nameLabel = UILabel()
    private var companyNameLabel = UILabel()
    private var locationLabel = UILabel()
    private var emailLabel = UILabel()
    private var countPublicReposLabel = UILabel()
    private var reposTableView = UITableView()
    private var reposNames: [String] = []
    private var reposStatuses: [String] = []
    private var reposDescriptions: [String] = []
    private var reposCreateDates: [String] = []
    private var reposUpdateDates: [String] = []
    private var reposPushDates: [String] = []
    private var reposLanguages: [String] = []
    private var viewModel: UserDeatilsViewModel?
    
    var userLogin = ""
    var userAvatarURL = ""
    var userReposURL = ""
    
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
        
        loginLabel.font = UIFont.boldSystemFont(ofSize: 22)
        loginLabel.textAlignment = .center
        loginLabel.text = userLogin
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.trailing.equalToSuperview()
        }
        
        AvatarLoader().loadImage(avaURL: userAvatarURL, image: avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(loginLabel.snp.bottom).offset(5)
        }
        
        nameLabel.textAlignment = .center
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }

        companyNameLabel.textAlignment = .center
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        locationLabel.textAlignment = .center
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        emailLabel.textAlignment = .center
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        countPublicReposLabel.textAlignment = .center
        countPublicReposLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        reposTableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "repoCell")
        reposTableView.delegate = self
        reposTableView.dataSource = self
        reposTableView.rowHeight = 160
        reposTableView.separatorStyle = .singleLine
        reposTableView.separatorColor = .label
        reposTableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        reposTableView.tableFooterView = UIView()
        reposTableView.snp.makeConstraints { make in
            make.top.equalTo(countPublicReposLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        allUserDetails()
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
                self.countPublicReposLabel.text = "Public repos: " + String(i.publicReposCount)
                self.userReposURL = i.reposURL
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

