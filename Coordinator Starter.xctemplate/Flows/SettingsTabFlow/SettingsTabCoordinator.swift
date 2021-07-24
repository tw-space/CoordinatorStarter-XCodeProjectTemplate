// ___FILEHEADER___

import UIKit

protocol SettingsTabCoordinatorProtocol: CoordinatorProtocol {}

final class SettingsTabCoordinator: BaseCoordinator,
                                    SettingsTabCoordinatorProtocol
{
  private let router: Router
  private let controllerFactory: SettingsTabControllerFactory
  private let appState: AppStateProtocol
  
  init(router: Router,
       controllerFactory: SettingsTabControllerFactory,
       appState: AppStateProtocol)
  {
    self.router = router
    self.controllerFactory = controllerFactory
    self.appState = appState
  }
  
  override func start() {
    showSettingsList()
  }
  
  //MARK: - Run current flow's controllers
  
  private func showSettingsList() {
    let username = appState.username
    let settingsListViewController =
      controllerFactory.makeSettingsListViewController(username: username)
    
    router.setRootViewController(settingsListViewController)
  }
}
