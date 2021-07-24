// ___FILEHEADER___

import UIKit

// MARK: - Protocol

protocol CoordinatorFactoryProtocol {
  
  func makeAuthenticationCoordinator(router: Router)
    -> AuthenticationCoordinatorProtocol
  func makeItemCreateCoordinator(router: Router)
    -> ItemCreateCoordinatorProtocol
  func makeItemsTabCoordinator(router: Router)
    -> ItemsTabCoordinatorProtocol
  func makeOnboardingCoordinator(router: Router)
    -> OnboardingCoordinatorProtocol
  func makeSettingsTabCoordinator(router: Router)
    -> SettingsTabCoordinatorProtocol
  func makeTabBarCoordinator(router: Router)
    -> TabBarCoordinatorProtocol
}

// MARK: - CoordinatorFactory

class CoordinatorFactory: CoordinatorFactoryProtocol {

  // (1) Same nav stack
  func makeAuthenticationCoordinator(router: Router)
    -> AuthenticationCoordinatorProtocol
  {
    return AuthenticationCoordinator(
      router: router,
      controllerFactory: ControllerFactory() as AuthenticationControllerFactory
    )
  }
  
  // (2) Present new nav stack
  func makeItemCreateCoordinator(router: Router)
    -> ItemCreateCoordinatorProtocol
  {
    return ItemCreateCoordinator(
      router: router,
      controllerFactory: ControllerFactory() as ItemCreateControllerFactory
    )
  }

  // (3) Start new nav stack but with given nav controller (from TabBar)
  func makeItemsTabCoordinator(router: Router)
    -> ItemsTabCoordinatorProtocol
  {
    return ItemsTabCoordinator(
      router: router,
      controllerFactory: ControllerFactory() as ItemsTabControllerFactory,
      coordinatorFactory: CoordinatorFactory(),
      itemsStore: ItemsStore(storeName: "ItemsStore")
    )
  }
  
  // (1) Same nav stack
  func makeOnboardingCoordinator(router: Router)
    -> OnboardingCoordinatorProtocol
  {
    return OnboardingCoordinator(
      router: router,
      controllerFactory: ControllerFactory() as OnboardingControllerFactory
    )
  }
  
  // (3) Start new nav stack but with given nav controller (from TabBar)
  func makeSettingsTabCoordinator(router: Router)
    -> SettingsTabCoordinatorProtocol
  {
    return SettingsTabCoordinator(
      router: router,
      controllerFactory: ControllerFactory() as SettingsTabControllerFactory,
      appState: AppState.shared
    )
  }
  
  // (1) Same nav stack
  func makeTabBarCoordinator(router: Router)
    -> TabBarCoordinatorProtocol
  {
    let controllerFactory = ControllerFactory()
    let tabNavControllers = [controllerFactory.makeItemsTabNavController(),
                             controllerFactory.makeSettingsTabNavController()]
    let coordinatorFactory = CoordinatorFactory()
    
    return TabBarCoordinator(
      router: router,
      tabNavControllers: tabNavControllers,
      controllerFactory: controllerFactory as TabBarControllerFactory,
      coordinatorFactory: coordinatorFactory
    )
  }
}
