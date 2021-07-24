// ___FILEHEADER___

import UIKit

protocol TabBarCoordinatorProtocol: CoordinatorProtocol {}

class TabBarCoordinator: BaseCoordinator,
                         TabBarCoordinatorProtocol
{
  private let router: Router
  private let tabNavControllers: [UINavigationController]
  private let controllerFactory: TabBarControllerFactory
  private let coordinatorFactory: CoordinatorFactoryProtocol
  
  private(set) var tabBarController: TabBarController!

  init(router: Router,
       tabNavControllers: [UINavigationController],
       controllerFactory: TabBarControllerFactory,
       coordinatorFactory: CoordinatorFactoryProtocol)
  {
    self.router = router
    self.tabNavControllers = tabNavControllers
    self.controllerFactory = controllerFactory
    self.coordinatorFactory = coordinatorFactory
  }

  override func start() {
    showTabBar()
  }
  
  private func showTabBar() {
    tabBarController = controllerFactory.makeTabBarController(tabNavControllers: tabNavControllers)
    
    tabBarController.onViewDidLoad = runItemsTabFlow()
    tabBarController.onItemsTabSelect = runItemsTabFlow()
    tabBarController.onSettingsTabSelect = runSettingsTabFlow()
    
    router.setRootViewController(tabBarController, hideTopBar: true, animated: true)
    
    // required to load views
    tabBarController.viewDidLoad()
  }

  private func runItemsTabFlow() -> ((UINavigationController) -> Void) {
    return { [unowned self] navController in
      if navController.viewControllers.isEmpty == true {
        let itemsTabCoordinator =
          self.coordinatorFactory.makeItemsTabCoordinator(router: Router(rootNavController: navController))
        self.addChildCoordinator(itemsTabCoordinator)
        itemsTabCoordinator.start()
      }
    }
  }

  private func runSettingsTabFlow() -> ((UINavigationController) -> Void) {
    return { [unowned self] navController in
      if navController.viewControllers.isEmpty == true {
        let settingsTabCoordinator =
          self.coordinatorFactory.makeSettingsTabCoordinator(router: Router(rootNavController: navController))
        self.addChildCoordinator(settingsTabCoordinator)
        settingsTabCoordinator.start()
      }
    }
  }
}
