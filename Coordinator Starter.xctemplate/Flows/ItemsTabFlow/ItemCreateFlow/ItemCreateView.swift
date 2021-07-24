// ___FILEHEADER___

import UIKit

class ItemCreateView: UIView {
  
  // MARK: - Properties
  
  var mainLabel: UILabel!
  
  // MARK: - Initializers

  override init(frame: CGRect) {
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
    mainLabel.translatesAutoresizingMaskIntoConstraints = false
    mainLabel.font = UIFont.systemFont(ofSize: 56, weight: .thin)
    mainLabel.text = "Create Item"
    addSubview(mainLabel)
    NSLayoutConstraint.activate([
      mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      mainLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
}
