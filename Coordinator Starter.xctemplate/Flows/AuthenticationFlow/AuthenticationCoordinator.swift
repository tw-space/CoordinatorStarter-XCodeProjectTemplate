// ___FILEHEADER___

import UIKit

protocol AuthenticationCoordinatorProtocol: CoordinatorProtocol {
  
  var onCompleteAuth: ((String) -> Void)? { get set }
}

class AuthenticationCoordinator: BaseCoordinator,
                                 AuthenticationCoordinatorProtocol
{
  
  var onCompleteAuth: ((String) -> Void)?
  
  private let router: Router
  private let controllerFactory: AuthenticationControllerFactory
  
  var usernameText = ""
  
  init(router: Router,
       controllerFactory: AuthenticationControllerFactory)
  {
    self.router = router
    self.controllerFactory = controllerFactory
  }
  
  override func start() {
    showSignInSignUp()
  }
  
  // MARK: - Sign In Sign Up Controller
  
  private func showSignInSignUp() {
    let signInSignUpViewController = controllerFactory.makeSignInSignUpViewController()
    
    signInSignUpViewController.onEditingChanged = { [weak self] sender in
      self?.onEditingChanged(sender)
    }
    
    signInSignUpViewController.onEditingDidBegin = { [weak self] sender in
      self?.onEditingDidBegin(sender)
    }
    
    signInSignUpViewController.onEditingDidEnd = { [weak self] sender in
      self?.onEditingDidEnd(sender)
    }
    
    signInSignUpViewController.onTappedContinueButton = { [weak self] in
      self?.onTappedContinueButton()
    }
    
    router.setRootViewController(signInSignUpViewController, hideTopBar: true)
  }
  
  private func onEditingChanged(_ sender: UITextField) {
    usernameText = sender.text!
  }
  
  private func onEditingDidBegin(_ sender: UITextField) {
    if sender.isFirstResponder {
      sender.placeholder = ""
    }
  }
  
  private func onEditingDidEnd(_ sender: UITextField) {
    if sender.placeholder == "" {
      sender.placeholder = AuthenticationStrings.usernamePlaceholder
    }
  }
  
  private func onTappedContinueButton() {
    guard !usernameText.isEmpty else { return }
    
    onCompleteAuth?(usernameText)
  }
}
