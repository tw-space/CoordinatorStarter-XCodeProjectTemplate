// ___FILEHEADER___

import UIKit

class OnboardingView: UIView {
  
  // MARK: - Properties
  
  var topLabel: UILabel!
  var continueButton: UIButton!
  
  // MARK: - Constants
  
  let continueButtonHeight: CGFloat = 54
  let continueButtonSidePadding: CGFloat = 16
  let continueButtonCornerRadius: CGFloat = 16
  let continueButtonBottomPadding: CGFloat = -40
  var continueButtonInnerPadding: CGFloat { continueButtonHeight - 20 }
  
  // MARK: - Initializers
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setBackgroundColor()
    
    addTopLabel()
    addContinueButton()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) not supported")
  }
  
  // MARK: - Set Up Methods
  
  private func setBackgroundColor() {
    backgroundColor = .white
  }
  
  private func addTopLabel() {
    topLabel = UILabel()
    topLabel.translatesAutoresizingMaskIntoConstraints = false
    topLabel.font = UIFont.systemFont(ofSize: 56, weight: .thin)
    topLabel.text = OnboardingStrings.topLabel
    addSubview(topLabel)
    NSLayoutConstraint.activate([
      topLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      topLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
  
  private func addContinueButton() {
    continueButton = UIButton()
    continueButton.translatesAutoresizingMaskIntoConstraints = false
    continueButton.setTitle(OnboardingStrings.continueButton, for: .normal)
    continueButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
    continueButton.titleLabel?.adjustsFontForContentSizeCategory = true
    continueButton.backgroundColor = .systemBlue
    continueButton.setTitleColor(.white, for: .normal)
    continueButton.layer.cornerCurve = .continuous
    continueButton.layer.cornerRadius = continueButtonCornerRadius
    addSubview(continueButton)
    NSLayoutConstraint.activate([
      continueButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                             constant: continueButtonBottomPadding),
      continueButton.heightAnchor.constraint(
        equalToConstant: (continueButton.titleLabel?.intrinsicContentSize.height)!
          + continueButtonInnerPadding),
      continueButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: continueButtonSidePadding),
      continueButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: -continueButtonSidePadding),
    ])
  }
}
