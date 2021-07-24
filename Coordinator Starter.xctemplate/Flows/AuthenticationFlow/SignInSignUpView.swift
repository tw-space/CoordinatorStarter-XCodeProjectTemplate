// ___FILEHEADER___

import UIKit

class SignInSignUpView: UIView {
  
  // MARK: - Properties
  
  var continueButton: UIButton!
  var nameField: UITextField!
  var topLabel: UILabel!
  
  var continueButtonBottomAnchor: NSLayoutConstraint!
  var topLabelTopAnchor: NSLayoutConstraint!
  
  // MARK: - Constants
  
  let continueButtonHeight: CGFloat = 54
  let continueButtonSidePadding: CGFloat = 16
  let continueButtonCornerRadius: CGFloat = 16
  let continueButtonBottomPadding: CGFloat = -40
  var continueButtonInnerPadding: CGFloat { continueButtonHeight - 20 }
  
  let nameFieldCornerRadius: CGFloat = 16
  let nameFieldToButtonPadding: CGFloat = -20
  let nameFieldSidePadding: CGFloat = 20
  
  let topLabelTopPaddingFull: CGFloat = 104
  let topLabelTopPaddingTight: CGFloat = 64
  
  let fieldBackgroundColor: UIColor = UIColor(hex: "f2f4f7")
  
  // MARK: - Initializers
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setBackgroundColor()
    
    addContinueButton()
    addNameField()
    addTopLabel()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) not supported")
  }
  
  // MARK: - Set Up Methods
  
  private func setBackgroundColor() {
    backgroundColor = .white
  }
  
  private func addContinueButton() {
    continueButton = UIButton()
    continueButton.translatesAutoresizingMaskIntoConstraints = false
    continueButton.setTitle(AuthenticationStrings.continueButton, for: .normal)
    continueButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
    continueButton.titleLabel?.adjustsFontForContentSizeCategory = true
    continueButton.layer.cornerCurve = .continuous
    continueButton.layer.cornerRadius = continueButtonCornerRadius
    enableContinueButton(false)
    addSubview(continueButton)
    continueButtonBottomAnchor =
      continueButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                             constant: continueButtonBottomPadding)
    NSLayoutConstraint.activate([
      continueButtonBottomAnchor,
      continueButton.heightAnchor.constraint(
        equalToConstant: (continueButton.titleLabel?.intrinsicContentSize.height)!
          + continueButtonInnerPadding),
      continueButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: continueButtonSidePadding),
      continueButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: -continueButtonSidePadding),
    ])
  }
  
  private func addNameField() {
    nameField = UITextField()
    nameField.translatesAutoresizingMaskIntoConstraints = false
    nameField.backgroundColor = fieldBackgroundColor
    nameField.attributedPlaceholder =
      NSMutableAttributedString(
        string: AuthenticationStrings.usernamePlaceholder,
        attributes: [
          .font: UIFont.preferredFont(forTextStyle: .headline),
          .foregroundColor: UIColor(hex: "7a7b7d")
        ]
      )
    nameField.adjustsFontForContentSizeCategory = true
    nameField.textColor = .black
    nameField.font = .preferredFont(forTextStyle: .headline)
    nameField.tintColor = .black
    nameField.textAlignment = .natural
    nameField.setSidePadding(nameFieldSidePadding)
    nameField.layer.cornerCurve = .continuous
    nameField.layer.cornerRadius = nameFieldCornerRadius
    addSubview(nameField)
    NSLayoutConstraint.activate([
      nameField.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor),
      nameField.trailingAnchor.constraint(equalTo: continueButton.trailingAnchor),
      nameField.bottomAnchor.constraint(equalTo: continueButton.topAnchor,
                                        constant: nameFieldToButtonPadding),
      nameField.heightAnchor.constraint(equalTo: continueButton.heightAnchor)
    ])
  }
  
  private func addTopLabel() {
    topLabel = UILabel()
    topLabel.translatesAutoresizingMaskIntoConstraints = false
    topLabel.font = UIFont.systemFont(ofSize: 56, weight: .thin)
    topLabel.text = AuthenticationStrings.topLabel
    topLabel.adjustsFontSizeToFitWidth = true
    topLabel.textAlignment = .center
    addSubview(topLabel)
    topLabelTopAnchor = topLabel.topAnchor.constraint(equalTo: topAnchor,
                                                constant: topLabelTopPaddingFull)
    NSLayoutConstraint.activate([
      topLabelTopAnchor,
      topLabel.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor),
      topLabel.trailingAnchor.constraint(equalTo: continueButton.trailingAnchor),
    ])
  }
  
  // MARK: - Modification Methods
  
  public func enableContinueButton(_ shouldEnable: Bool) {
    if shouldEnable {
      continueButton.backgroundColor = .systemBlue
      continueButton.setTitleColor(.white, for: .normal)
    } else {
      continueButton.backgroundColor = fieldBackgroundColor
      continueButton.setTitleColor(UIColor(hex: "bcc1c7"), for: .normal)
    }
  }
}
