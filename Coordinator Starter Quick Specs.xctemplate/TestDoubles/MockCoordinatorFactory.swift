// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import UIKit

class MockCoordinatorFactory: CoordinatorFactoryProtocol {
  
  // MARK: - Properties
  
  var callCountFor: [String: Int] = [
    "makeAuthenticationCoordinator": 0,
    "makeItemCreateCoordinator": 0,
    "makeItemsTabCoordinator": 0,
    "makeOnboardingCoordinator": 0,
    "makeSettingsTabCoordinator": 0,
    "makeTabBarCoordinator": 0,
  ]
  var makeAuthenticationCoordinatorRouterArgs: [Router] = []
  var makeItemCreateCoordinatorRouterArgs: [Router] = []
  var makeItemsTabCoordinatorRouterArgs: [Router] = []
  var makeOnboardingCoordinatorRouterArgs: [Router] = []
  var makeSettingsTabCoordinatorRouterArgs: [Router] = []
  var makeTabBarCoordinatorRouterArgs: [Router] = []
  
  // MARK: - Methods
  
  func makeAuthenticationCoordinator(router: Router)
    -> AuthenticationCoordinatorProtocol
  {
    callCountFor["makeAuthenticationCoordinator"]! += 1
    makeAuthenticationCoordinatorRouterArgs.append(router)
    return SpyCoordinator(type: "AuthenticationCoordinatorProtocol")
  }
  
  func makeItemCreateCoordinator(router: Router)
    -> ItemCreateCoordinatorProtocol
  {
    callCountFor["makeItemCreateCoordinator"]! += 1
    makeItemCreateCoordinatorRouterArgs.append(router)
    return SpyCoordinator(type: "ItemCreateCoordinatorProtocol")
  }

  func makeItemsTabCoordinator(router: Router)
    -> ItemsTabCoordinatorProtocol
  {
    callCountFor["makeItemsTabCoordinator"]! += 1
    makeItemsTabCoordinatorRouterArgs.append(router)
    return SpyCoordinator(type: "ItemsTabCoordinatorProtocol")
  }
  
  func makeOnboardingCoordinator(router: Router)
    -> OnboardingCoordinatorProtocol
  {
    callCountFor["makeOnboardingCoordinator"]! += 1
    makeOnboardingCoordinatorRouterArgs.append(router)
    return SpyCoordinator(type: "OnboardingCoordinatorProtocol")
  }
  
  func makeSettingsTabCoordinator(router: Router)
    -> SettingsTabCoordinatorProtocol
  {
    callCountFor["makeSettingsTabCoordinator"]! += 1
    makeSettingsTabCoordinatorRouterArgs.append(router)
    return SpyCoordinator(type: "SettingsTabCoordinatorProtocol")
  }
  
  func makeTabBarCoordinator(router: Router)
    -> TabBarCoordinatorProtocol
  {
    callCountFor["makeTabBarCoordinator"]! += 1
    makeTabBarCoordinatorRouterArgs.append(router)
    return SpyCoordinator(type: "TabBarCoordinatorProtocol")
  }
}
