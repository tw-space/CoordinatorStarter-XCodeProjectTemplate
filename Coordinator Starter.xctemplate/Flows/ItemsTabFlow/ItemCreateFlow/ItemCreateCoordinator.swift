// ___FILEHEADER___

import UIKit

protocol ItemCreateCoordinatorProtocol: CoordinatorProtocol {
  var flowDidComplete: ((Item?) -> Void)? { get set }
}

final class ItemCreateCoordinator: BaseCoordinator,
                                   ItemCreateCoordinatorProtocol
{
  var flowDidComplete: ((Item?) -> Void)?

  private let router: Router
  private let controllerFactory: ItemCreateControllerFactory

  init(router: Router,
       controllerFactory: ItemCreateControllerFactory)
  {
    self.router = router
    self.controllerFactory = controllerFactory
  }

  override func start() {
    showItemCreate()
  }

  // MARK: - Show current flow's controllers

  private func showItemCreate() {
    let itemCreateViewController = controllerFactory.makeItemCreateViewController()
    itemCreateViewController.onCompleteItemCreate = { [weak self] item in
      self?.flowDidComplete?(item)
    }
    itemCreateViewController.onTapHideButton = { [weak self] in
      self?.flowDidComplete?(nil)
    }
    router.setRootViewController(itemCreateViewController)
  }
}
