// ___FILEHEADER___

import UIKit

protocol ItemsTabCoordinatorProtocol: CoordinatorProtocol {}

final class ItemsTabCoordinator: BaseCoordinator,
                                 ItemsTabCoordinatorProtocol
{
  // MARK: - Properties

  private let router: Router
  private let controllerFactory: ItemsTabControllerFactory
  private let coordinatorFactory: CoordinatorFactoryProtocol
  private let itemsStore: ItemsStoreProtocol
  
  private var itemsListViewController: ItemsListViewController?
  
  // MARK: - Lifecycle

  init(router: Router,
       controllerFactory: ItemsTabControllerFactory,
       coordinatorFactory: CoordinatorFactoryProtocol,
       itemsStore: ItemsStoreProtocol)
  {
    self.router = router
    self.controllerFactory = controllerFactory
    self.coordinatorFactory = coordinatorFactory
    self.itemsStore = itemsStore
  }

  override func start() {
    showItemsList()
  }

  // MARK: - Controller methods

  private func showItemsList() {

    if itemsListViewController == nil {
      itemsListViewController =
        controllerFactory.makeItemsListViewController(itemsStore: itemsStore)
    }
    
    itemsListViewController!.onItemSelect = { [weak self] item in
      self?.showItemDetail(item)
    }
    itemsListViewController!.onCreateItem = { [weak self] in
      self?.runItemCreateFlow()
    }
    itemsListViewController!.onTapReset = { [weak self] in
      self?.itemsStore.resetExampleData()
      self?.refreshItemsList()
    }
    
    router.setRootViewController(itemsListViewController)
  }
  
  private func refreshItemsList() {
    guard let itemsListViewController = itemsListViewController else { return }
    
    itemsListViewController.items = itemsStore.getAll()
    itemsListViewController.tableView.reloadData()
  }

  private func showItemDetail(_ item: Item) {

    let itemDetailViewController = controllerFactory.makeItemDetailViewController(for: item)
    router.push(itemDetailViewController, hideBottomBar: false)
  }

  // MARK: - Coordinator switching

  private func runItemCreateFlow() {
    
    let newNavController = UINavigationController(nibName: nil, bundle: nil)
    let newRouter = Router(rootNavController: newNavController)
    let itemCreateCoordinator =
      coordinatorFactory.makeItemCreateCoordinator(router: newRouter)
    
    itemCreateCoordinator.flowDidComplete = { [weak self, weak itemCreateCoordinator] item in

      self?.router.dismissViewController()
      self?.removeChildCoordinator(itemCreateCoordinator)
      if let item = item {
        self?.itemsStore.add(item)
        self?.refreshItemsList()
        self?.showItemDetail(item)
      }
    }
    addChildCoordinator(itemCreateCoordinator)
    router.present(newRouter)
    itemCreateCoordinator.start()
  }
}
