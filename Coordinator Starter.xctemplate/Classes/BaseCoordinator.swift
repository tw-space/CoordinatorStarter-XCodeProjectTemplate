// ___FILEHEADER___

import Foundation

protocol CoordinatorProtocol: AnyObject {
  
  var childCoordinators: [CoordinatorProtocol] { get }
  
  func start()
  func addChildCoordinator(_ coordinator: CoordinatorProtocol)
  func removeChildCoordinator(_ coordinator: CoordinatorProtocol?)
}

class BaseCoordinator: CoordinatorProtocol {
  
  private(set) var childCoordinators: [CoordinatorProtocol] = []
  
  func start() {}
  
  func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
    guard 
      !childCoordinators.contains(where: { $0 === coordinator }),
      coordinator !== self
    else { return }
    childCoordinators.append(coordinator)
  }
  
  func removeChildCoordinator(_ coordinator: CoordinatorProtocol?) {
    guard
      childCoordinators.isEmpty == false,
      let coordinator = coordinator
    else { return }
    
    // recursively removes all descendants of coordinator before removing
    if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
      coordinator.childCoordinators
        .filter({ $0 !== coordinator })
        .forEach({ coordinator.removeChildCoordinator($0) })
    }
    for (index, element) in childCoordinators.enumerated() where element === coordinator {
      childCoordinators.remove(at: index)
      break
    }
  }
}
