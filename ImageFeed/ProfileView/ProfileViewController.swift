import UIKit

extension UIView {
    func setupView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

final class ProfileViewController: UIViewController {
    
    let avatarTemp = UIImageView()
    let profileName = UILabel()
    let profileTag = UILabel()
    let profileInfo = UILabel()
    let logoutButton = UIButton()
    
    private func configure() {
        view.backgroundColor = Res.Colors.backgroundColor
        
        avatarTemp.image = Res.Images.Profile.tempAvatar
        
        profileName.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        profileName.textColor = .white
        profileName.text = "Екатерина Новикова"
        
        profileTag.font = UIFont.systemFont(ofSize: 13)
        profileTag.textColor = Res.Colors.tagColor
        profileTag.text = "@ekaterina_nov"
        
        profileInfo.font = UIFont.systemFont(ofSize: 13)
        profileInfo.textColor = .white
        profileInfo.text = "Hello, world!"
        
        logoutButton.setImage(Res.Images.Profile.logoutButton, for: .normal)
    }
    
    private func addViews() {
        [avatarTemp,
         profileName,
         profileTag,
         profileInfo,
         logoutButton].map{self.view.setupView($0)}
    }
    
    override func viewDidLoad() {
        configure()
        addViews()
        
        avatarTemp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        avatarTemp.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        avatarTemp.heightAnchor.constraint(equalToConstant: 70).isActive = true
        avatarTemp.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        profileName.topAnchor.constraint(equalTo: avatarTemp.bottomAnchor, constant: 8).isActive = true
        profileName.leadingAnchor.constraint(equalTo: avatarTemp.leadingAnchor).isActive = true
        profileName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
        
        profileTag.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 8).isActive = true
        profileTag.leadingAnchor.constraint(equalTo: profileName.leadingAnchor).isActive = true
        profileTag.trailingAnchor.constraint(equalTo: profileName.trailingAnchor).isActive = true
        
        profileInfo.topAnchor.constraint(equalTo: profileTag.bottomAnchor, constant: 8).isActive = true
        profileInfo.leadingAnchor.constraint(equalTo: profileName.leadingAnchor).isActive = true
        profileInfo.trailingAnchor.constraint(equalTo: profileName.trailingAnchor).isActive = true
        
        logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        logoutButton.leadingAnchor.constraint(greaterThanOrEqualTo: avatarTemp.leadingAnchor, constant: 0).isActive = true
    }
}
