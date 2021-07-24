// ___FILEHEADER___

import UIKit

// MARK: - Protocols

protocol AuthenticationControllerFactory {
  func makeSignInSignUpViewController() -> SignInSignUpViewController
}

protocol ItemCreateControllerFactory {
  func makeItemCreateViewController() -> ItemCreateViewController
}

protocol ItemsTabControllerFactory {
  func makeItemsTabNavController() -> UINavigationController
  func makeItemsListViewController(itemsStore: ItemsStoreProtocol) -> ItemsListViewController
  func makeItemDetailViewController(for: Item) -> ItemDetailViewController
}

protocol OnboardingControllerFactory {
  func makeOnboardingViewController() -> OnboardingViewController
}

protocol SettingsTabControllerFactory {
  func makeSettingsTabNavController() -> UINavigationController
  func makeSettingsListViewController(username: String?) -> SettingsListViewController
}

protocol TabBarControllerFactory {
  func makeTabBarController(tabNavControllers: [UINavigationController]) -> TabBarController
}

// MARK: - ControllerFactory

class ControllerFactory:
  AuthenticationControllerFactory,
  ItemsTabControllerFactory,
  ItemCreateControllerFactory,
  OnboardingControllerFactory,
  SettingsTabControllerFactory,
  TabBarControllerFactory
{
  
  // MARK: - Authentication Flow
  
  func makeSignInSignUpViewController() -> SignInSignUpViewController {
    return SignInSignUpViewController()
  }
  
  // MARK: - Items Tab Flow
  
  func makeItemsTabNavController() -> UINavigationController {
    let vc = UINavigationController()
    vc.tabBarItem = UITabBarItem(title: TabBarStrings.items,
                                 image: UIImage(systemName: "rectangle.grid.1x2"),
                                 selectedImage: UIImage(systemName: "rectangle.grid.1x2.fill"))
    return vc
  }
  
  func makeItemsListViewController(itemsStore: ItemsStoreProtocol)
    -> ItemsListViewController
  {
    return ItemsListViewController(itemsStore: itemsStore)
  }
  
  func makeItemDetailViewController(for item: Item) -> ItemDetailViewController {
    return ItemDetailViewController(for: item)
  }
  
  // MARK: - Item Create Flow
  
  func makeItemCreateViewController() -> ItemCreateViewController {
    return ItemCreateViewController()
  }
  
  // MARK: - Onboarding Flow
  
  func makeOnboardingViewController() -> OnboardingViewController {
    return OnboardingViewController()
  }
  
  // MARK: - Settings Flow
  
  func makeSettingsTabNavController() -> UINavigationController {
    let vc = UINavigationController()
    vc.tabBarItem = UITabBarItem(title: TabBarStrings.settings,
                                 image: UIImage(systemName: "gearshape"),
                                 selectedImage: UIImage(systemName: "gearshape.fill"))
    return vc
  }
  
  func makeSettingsListViewController(username: String?)
    -> SettingsListViewController
  {
    return SettingsListViewController(username: username)
  }
  
  func makeTabBarController(tabNavControllers: [UINavigationController])
    -> TabBarController
  {
    return TabBarController(tabNavControllers: tabNavControllers)
  }
}
