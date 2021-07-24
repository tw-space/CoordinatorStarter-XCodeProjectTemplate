// ___FILEHEADER___

import UIKit

class OnboardingViewController: UIViewController {
  
  var vw = OnboardingView()
  var onCompleteOnboarding: (() -> Void)?
  
  override func loadView() {
    view = vw
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // event handlers
    vw.continueButton.addTarget(self,
                                action: #selector(tappedContinue),
                                for: .touchUpInside)
  }
  
  // MARK: - Handlers
  
  @objc func tappedContinue(_ sender: UIButton) {
    onCompleteOnboarding?()
  }
}
