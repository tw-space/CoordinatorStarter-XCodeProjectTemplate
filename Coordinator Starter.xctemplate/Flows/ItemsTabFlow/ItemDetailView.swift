// ___FILEHEADER___

import UIKit

class ItemDetailView: UIView {
  
  // MARK: - Properties
  
  var item: Item
  var mainLabel: UILabel!
  
  // MARK: - Initializers
  
  init(for item: Item) {
    self.item = item
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
    mainLabel.text = item.title
    addSubview(mainLabel)
    NSLayoutConstraint.activate([
      mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      mainLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
}

