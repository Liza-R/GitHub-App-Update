import UIKit
import SnapKit

class RepoTableViewCell: UITableViewCell {

    var nameLabel = UILabel()
    var statusLabel = UILabel()
    var descriptionLabel = UILabel()
    var createDateLabel = UILabel()
    var updateDateLabel = UILabel()
    var pushDateLabel = UILabel()
    var langLabel = UILabel()
    var repoStackView: UIStackView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        repoStackView = UIStackView()
        contentView.addSubview(repoStackView ?? UIStackView())

        repoStackView?.axis = .vertical
        repoStackView?.alignment = .center
        repoStackView?.distribution = .fillEqually
        
        repoStackView?.snp.makeConstraints { make in
            make.leading.top.equalTo(10)
            make.trailing.bottom.equalTo(-10)
        }

        repoStackView?.addArrangedSubview(nameLabel)
        repoStackView?.addArrangedSubview(statusLabel)
        repoStackView?.addArrangedSubview(descriptionLabel)
        repoStackView?.addArrangedSubview(createDateLabel)
        repoStackView?.addArrangedSubview(updateDateLabel)
        repoStackView?.addArrangedSubview(pushDateLabel)
        repoStackView?.addArrangedSubview(langLabel)

        statusLabel.textColor = UIColor(red: 0.216, green: 0.271, blue: 0.706, alpha: 1.0)
        descriptionLabel.textColor = UIColor(red: 0.667, green: 0.349, blue: 0.580, alpha: 1.0)
        createDateLabel.textColor = UIColor(red: 0.584, green: 0.890, blue: 0.647, alpha: 1.0)
        updateDateLabel.textColor = UIColor(red: 0.545, green: 0.471, blue: 0.149, alpha: 1.0)
        pushDateLabel.textColor = UIColor(red: 0.329, green: 0.494, blue: 0.635, alpha: 1.0)
        langLabel.textColor = UIColor(red: 0.627, green: 0.408, blue: 0.255, alpha: 1.0)

        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textAlignment = .center
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }

        statusLabel.textAlignment = .center
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        descriptionLabel.textAlignment = .center
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        createDateLabel.font = UIFont.systemFont(ofSize: 14)
        createDateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom)
        }

        updateDateLabel.font = UIFont.systemFont(ofSize: 14)
        updateDateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(createDateLabel.snp.bottom)
        }

        pushDateLabel.font = UIFont.systemFont(ofSize: 14)
        pushDateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(updateDateLabel.snp.bottom)
        }

        langLabel.textAlignment = .center
        langLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(pushDateLabel.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
