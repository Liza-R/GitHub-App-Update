import UIKit
import SnapKit

class AllUsersTableViewCell: UITableViewCell {

    var userAvatarImageView = UIImageView(),
        userLoginLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(userAvatarImageView)
        contentView.addSubview(userLoginLabel)
        
        userAvatarImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(40)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }

        userLoginLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(userAvatarImageView.snp.trailing).offset(20)
            make.width.equalTo(self.frame.size.width - userAvatarImageView.frame.size.width - 80)
        }
        userLoginLabel.font = UIFont.boldSystemFont(ofSize: 22)
        userLoginLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
