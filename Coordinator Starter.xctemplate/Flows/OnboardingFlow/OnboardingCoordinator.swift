// ___FILEHEADER___

import UIKit

protocol OnboardingCoordinatorProtocol: CoordinatorProtocol {
  
  var onCompleteOnboarding: (() -> Void)? { get set }
}

final class OnboardingCoordinator: BaseCoordinator,
                                   OnboardingCoordinatorProtocol
{

  var onCompleteOnboarding: (() -> Void)?

  private let router: Router
  private let controllerFactory: OnboardingControllerFactory

  init(router: Router,
       controllerFactory: OnboardingControllerFactory)
  {
    self.router = router
    self.controllerFactory = controllerFactory
  }

  override func start() {
    showOnboarding()
  }

  // MARK: - Show current flow's controllers

  private func showOnboarding() {
    let onboardingViewController = controllerFactory.makeOnboardingViewController()
    onboardingViewController.onCompleteOnboarding = { [weak self] in
      self?.onCompleteOnboarding?()
    }
    
    router.setRootViewController(onboardingViewController, hideTopBar: true)
  }
}
