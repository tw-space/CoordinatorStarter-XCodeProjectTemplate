// ___FILEHEADER___

import UIKit

class SignInSignUpViewController: UIViewController {
  
  var vw = SignInSignUpView()
  
  var onEditingChanged: ((UITextField) -> Void)?
  var onEditingDidBegin: ((UITextField) -> Void)?
  var onEditingDidEnd: ((UITextField) -> Void)?
  var onTappedContinueButton: (() -> Void)?
  
  override func loadView() {
    view = vw
    
    // event handlers
    vw.nameField.addTarget(self,
                           action: #selector(editingChanged),
                           for: .editingChanged)
    vw.nameField.addTarget(self,
                           action: #selector(editingDidBegin),
                           for: .editingDidBegin)
    vw.nameField.addTarget(self,
                           action: #selector(editingDidEnd),
                           for: .editingDidEnd)
    vw.continueButton.addTarget(self,
                                action: #selector(tappedContinueButton),
                                for: .touchUpInside)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tapToDismissKeyboard()
    
    // keyboard notification handlers
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self,
                                   selector: #selector(keyboardWillChange),
                                   name: UIResponder.keyboardWillHideNotification,
                                   object: nil)
    notificationCenter.addObserver(self,
                                   selector: #selector(keyboardWillChange),
                                   name: UIResponder.keyboardWillChangeFrameNotification,
                                   object: nil)
  }
  
  // MARK: - Handlers
  
  @objc func editingChanged(_ sender: UITextField) {
    onEditingChanged?(sender)
    
    if sender.text == "" {
      vw.enableContinueButton(false)
    } else {
      vw.enableContinueButton(true)
    }
  }
  
  @objc func editingDidBegin(_ sender: UITextField) {
    onEditingDidBegin?(sender)
  }

  @objc func editingDidEnd(_ sender: UITextField) {
    onEditingDidEnd?(sender)
  }
  
  @objc func tappedContinueButton(_ sender: UIButton) {
    onTappedContinueButton?()
  }
  
  // MARK: - Keyboard Changes
  
  // unsure how to unit test
  @objc func keyboardWillChange(notification: Notification) {
    let keyboardFrameEndKey = UIResponder.keyboardFrameEndUserInfoKey
    let animationCurveKey = UIResponder.keyboardAnimationCurveUserInfoKey
    
    guard let keyboardValue = notification.userInfo?[keyboardFrameEndKey] as? NSValue
    else { return }
    guard let curveValue = (notification.userInfo?[animationCurveKey] as? NSNumber)?.uintValue
    else { return }
    
    let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
    let keyboardWillHide = notification.name == UIResponder.keyboardWillHideNotification
    
    let duration = notification.userInfo![durationKey] as! Double
    let curveAnimationOptions = UIView.AnimationOptions(rawValue: curveValue << 16)
    
    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame =  // adjusts for possible landscape mode
      view.convert(keyboardScreenEndFrame, from: view.window)
    
    UIView.animate(
      withDuration: duration, delay: 0, options: curveAnimationOptions,
      animations: {
        self.updateViewForKeyboard(willHide: keyboardWillHide,
                                   keyboardFrame: keyboardViewEndFrame)
      },
      completion: nil
    )
  }
  
  private func updateViewForKeyboard(willHide: Bool,
                                     keyboardFrame: CGRect)
  {
    if willHide {
      vw.continueButtonBottomAnchor.constant = vw.continueButtonBottomPadding
      vw.topLabelTopAnchor.constant = vw.topLabelTopPaddingFull
    } else {
      vw.continueButtonBottomAnchor.constant = vw.continueButtonBottomPadding - keyboardFrame.height
      vw.topLabelTopAnchor.constant = vw.topLabelTopPaddingTight
    }
    
    vw.layoutIfNeeded()
  }
}
