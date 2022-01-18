import UIKit
import SnapKit

class AllUsersTableViewCell: UITableViewCell {

    var userAvatarImageView = UIImageView()
    var userLoginLabel = UILabel()
    var userInfoStackView: UIStackView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        userInfoStackView = UIStackView()
        contentView.addSubview(userInfoStackView ?? UIStackView())
        
        
        userInfoStackView?.snp.makeConstraints { make in
            make.leading.top.equalTo(10)
            make.trailing.bottom.equalTo(-10)
        }

        userInfoStackView?.addArrangedSubview(userAvatarImageView)
        userInfoStackView?.addArrangedSubview(userLoginLabel)
        userInfoStackView?.spacing = 10

        userAvatarImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(userAvatarImageView.snp.height)
        }

        userLoginLabel.font = UIFont.boldSystemFont(ofSize: 22)
        userLoginLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
