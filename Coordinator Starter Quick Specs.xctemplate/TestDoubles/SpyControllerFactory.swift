// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import UIKit

class SpyControllerFactory: ControllerFactory {
  
  // MARK: - Spy Properties
  
  var callCountFor: [String: Int] = [
    "makeItemCreateViewController": 0,
    "makeItemDetailViewController": 0,
    "makeOnboardingViewController": 0,
    "makeSettingsListViewController": 0,
    "makeSignInSignUpViewController": 0,
    "makeTabBarController": 0,
  ]
  
  var makeItemDetailViewControllerItemArgs: [Item] = []
  var makeSettingsListViewControllerUsernameArgs: [String?] = []
  var makeTabBarControllerTabNCArgs: [[UINavigationController]] = []
  
  // MARK: - Spy Overrides
  
  override func makeItemCreateViewController() -> ItemCreateViewController {
    callCountFor["makeItemCreateViewController"]! += 1
    
    return super.makeItemCreateViewController()
  }
  
  override func makeItemDetailViewController(for item: Item)
    -> ItemDetailViewController
  {
    callCountFor["makeItemDetailViewController"]! += 1
    makeItemDetailViewControllerItemArgs.append(item)
    
    return super.makeItemDetailViewController(for: item)
  }
  
  override func makeOnboardingViewController() -> OnboardingViewController {
    callCountFor["makeOnboardingViewController"]! += 1
    
    return super.makeOnboardingViewController()
  }
  
  override func makeSettingsListViewController(username: String?)
    -> SettingsListViewController
  {
    callCountFor["makeSettingsListViewController"]! += 1
    makeSettingsListViewControllerUsernameArgs.append(username)
    
    return super.makeSettingsListViewController(username: username)
  }
  
  override func makeSignInSignUpViewController() -> SignInSignUpViewController {
    callCountFor["makeSignInSignUpViewController"]! += 1
    
    return super.makeSignInSignUpViewController()
  }
  
  override func makeTabBarController(tabNavControllers: [UINavigationController])
    -> TabBarController
  {
    callCountFor["makeTabBarController"]! += 1
    makeTabBarControllerTabNCArgs.append(tabNavControllers)
    
    return super.makeTabBarController(tabNavControllers: tabNavControllers)
  }

}
