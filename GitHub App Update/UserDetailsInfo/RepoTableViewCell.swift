import UIKit
import SnapKit

class RepoTableViewCell: UITableViewCell {

    var nameLabel = UILabel(),
        statusLabel = UILabel(),
        descriptionLabel = UILabel(),
        createDateLabel = UILabel(),
        updateDateLabel = UILabel(),
        pushDateLabel = UILabel(),
        langLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(createDateLabel)
        contentView.addSubview(updateDateLabel)
        contentView.addSubview(pushDateLabel)
        contentView.addSubview(langLabel)

        statusLabel.textColor = UIColor(red: 0.216, green: 0.271, blue: 0.706, alpha: 1.0)
        descriptionLabel.textColor = UIColor(red: 0.667, green: 0.349, blue: 0.580, alpha: 1.0)
        createDateLabel.textColor = UIColor(red: 0.584, green: 0.890, blue: 0.647, alpha: 1.0)
        updateDateLabel.textColor = UIColor(red: 0.545, green: 0.471, blue: 0.149, alpha: 1.0)
        pushDateLabel.textColor = UIColor(red: 0.329, green: 0.494, blue: 0.635, alpha: 1.0)
        langLabel.textColor = UIColor(red: 0.627, green: 0.408, blue: 0.255, alpha: 1.0)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textAlignment = .center
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.topMargin)
            make.leading.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        statusLabel.textAlignment = .center
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        descriptionLabel.textAlignment = .center
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(20)
            make.top.equalTo(statusLabel.snp.bottom).offset(5)
        }
        
        createDateLabel.font = UIFont.systemFont(ofSize: 14)
        createDateLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView.frame.width / 2)
            make.leading.equalTo(10)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        updateDateLabel.font = UIFont.systemFont(ofSize: 14)
        updateDateLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView.frame.width / 2)
            make.leading.equalTo(10)
            make.top.equalTo(createDateLabel.snp.bottom).offset(2)
        }
        
        pushDateLabel.font = UIFont.systemFont(ofSize: 14)
        pushDateLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView.frame.width / 2)
            make.leading.equalTo(10)
            make.top.equalTo(updateDateLabel.snp.bottom).offset(2)
        }
        
        langLabel.textAlignment = .center
        langLabel.numberOfLines = 3
        langLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView.frame.width / 2)
            make.trailing.equalTo(-20)
            make.centerY.equalTo(updateDateLabel.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
