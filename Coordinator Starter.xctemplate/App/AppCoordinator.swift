// ___FILEHEADER___

import UIKit

final class AppCoordinator: BaseCoordinator {
  
  private let router: Router
  private let coordinatorFactory: CoordinatorFactoryProtocol
  private var appState: AppStateProtocol
  
  init(router: Router,
       coordinatorFactory: CoordinatorFactoryProtocol,
       appState: AppStateProtocol)
  {
    self.router = router
    self.coordinatorFactory = coordinatorFactory
    self.appState = appState
  }
  
  private enum LaunchFlow {
    case auth, main, onboarding
  }
  
  private var launchFlow: LaunchFlow {
    if !appState.isAuthenticated {
      return .auth
    } else if !appState.onboardingWasShown {
      return .onboarding
    } else {
      return .main
    }
  }
  
  override func start() {
    switch launchFlow {
      case .auth:       runAuthFlow()
      case .main:       runMainFlow()
      case .onboarding: runOnboardingFlow()
    }
  }
  
  private func runAuthFlow() {
    let authCoordinator = coordinatorFactory.makeAuthenticationCoordinator(router: router)
    authCoordinator.onCompleteAuth = { [weak self, weak authCoordinator] username in
      self?.appState.username = username
      self?.appState.isAuthenticated = true
      self?.start()
      self?.removeChildCoordinator(authCoordinator)
    }
    addChildCoordinator(authCoordinator)
    authCoordinator.start()
  }
  
  private func runMainFlow() {
    let tabBarCoordinator = coordinatorFactory.makeTabBarCoordinator(router: router)
    addChildCoordinator(tabBarCoordinator)
    tabBarCoordinator.start()
  }
  
  private func runOnboardingFlow() {
    let onboardingCoordinator = coordinatorFactory.makeOnboardingCoordinator(router: router)
    onboardingCoordinator.onCompleteOnboarding = { [weak self, weak onboardingCoordinator] in
      self?.appState.onboardingWasShown = true
      self?.start()
      self?.removeChildCoordinator(onboardingCoordinator)
    }
    
    addChildCoordinator(onboardingCoordinator)
    onboardingCoordinator.start()
  }
}
