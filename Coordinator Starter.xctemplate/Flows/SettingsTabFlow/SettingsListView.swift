// ___FILEHEADER___

import UIKit

class SettingsListView: UIView {
  
  // MARK: - Properties
  
  var username: String?
  
  var mainLabel: UILabel!
  
  // MARK: - Initializers
  
  init(username: String?) {
    self.username = username
    super.init(frame: .zero)
    
    setBackgroundColor()
    
    addMainLabel()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) not supported")
  }
  
  // MARK: - Set Up Methods
  
  private func setBackgroundColor() {
    backgroundColor = .white
  }
  
  private func addMainLabel() {
    mainLabel = UILabel()
    let sidePadding: CGFloat = 12
    mainLabel.translatesAutoresizingMaskIntoConstraints = false
    mainLabel.font = UIFont.systemFont(ofSize: 56, weight: .thin)
    mainLabel.text = (username != nil) ? "Welcome, \(username!)" : "Settings"
    mainLabel.adjustsFontSizeToFitWidth = true
    mainLabel.textAlignment = .center
    addSubview(mainLabel)
    NSLayoutConstraint.activate([
      mainLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,
                                     constant: sidePadding),
      mainLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,
                                      constant: -sidePadding),
      mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      mainLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
}
