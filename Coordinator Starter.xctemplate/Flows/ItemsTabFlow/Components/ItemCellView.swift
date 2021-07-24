// ___FILEHEADER___

import UIKit

class ItemCellView: UITableViewCell {
  
  // MARK: - Properties

  var title: UILabel!
  var subtitle: UILabel!
  var titleSubtitleStack: UIStackView!
  
  // MARK: - Constants
  
  let topPadding: CGFloat = 10.0  // was 6.0
  let bottomPadding: CGFloat = 9.0  // was 6.0
  let innerPadding: CGFloat = 2.0
  
  // MARK: - Initializers

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setAccessoryType()

    styleTitle()
    styleSubtitle()
    addTitleSubtitleStack()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) not supported")
  }
  
  // MARK: - Set Up Methods
  
  private func setAccessoryType() {
    accessoryType = .disclosureIndicator
  }
  
  private func styleTitle() {
    title = UILabel()
    title.translatesAutoresizingMaskIntoConstraints = false
    title.font = UIFont.preferredFont(for: .headline, weight: .bold)
    title.adjustsFontForContentSizeCategory = true
  }
  
  private func styleSubtitle() {
    subtitle = UILabel()
    subtitle.translatesAutoresizingMaskIntoConstraints = false
    subtitle.font = UIFont.preferredFont(for: .subheadline, weight: .medium)
    subtitle.adjustsFontForContentSizeCategory = true
  }
  
  private func addTitleSubtitleStack() {
    titleSubtitleStack = UIStackView()
    titleSubtitleStack.translatesAutoresizingMaskIntoConstraints = false
    titleSubtitleStack.axis = .vertical
    titleSubtitleStack.spacing = innerPadding
    titleSubtitleStack.alignment = .leading
    titleSubtitleStack.addArrangedSubview(title)
    titleSubtitleStack.addArrangedSubview(subtitle)
    addSubview(titleSubtitleStack)
    NSLayoutConstraint.activate([
      titleSubtitleStack.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
      titleSubtitleStack.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      titleSubtitleStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomPadding),
    ])
  }
}
