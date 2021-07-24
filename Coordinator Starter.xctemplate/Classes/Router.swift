// ___FILEHEADER___

import UIKit

class Router: NSObject, Presentable {
  
  private(set) weak var rootNavController: UINavigationController?
  private(set) var completions: [UIViewController : () -> Void]
  
  init(rootNavController: UINavigationController) {
    self.rootNavController = rootNavController
    completions = [:]
  }
  
  func toPresent() -> UIViewController? {
    return rootNavController
  }
  
  func setRootViewController(_ viewController: Presentable?,
                             hideTopBar: Bool = false,
                             animated: Bool = false)
  {
    guard let controller = viewController?.toPresent() else { return }
    rootNavController?.setViewControllers([controller], animated: false)
    rootNavController?.isNavigationBarHidden = hideTopBar
    
    if animated && rootNavController != nil {
      UIView.transition(with: rootNavController!.view,
                        duration: 0.2,
                        options: .transitionCrossDissolve,
                        animations: nil)
    }
  }

  func push(_ viewController: Presentable?,
            animated: Bool = true,
            hideBottomBar: Bool = false,
            completion: (() -> Void)? = nil)
  {
    guard
      let controller = viewController?.toPresent(),
      (controller is UINavigationController == false)
      else { assertionFailure("Deprecated push UINavigationController."); return }

    if let completion = completion {
      completions[controller] = completion
    }
    
    controller.hidesBottomBarWhenPushed = hideBottomBar
    rootNavController?.pushViewController(controller, animated: animated)
  }

  func popViewController(animated: Bool = true) {
    guard let rootNavController = rootNavController,
          rootNavController.viewControllers.count > 1 else { return }
    
    let controller = rootNavController.viewControllers.last!
    rootNavController.popViewController(animated: animated)
    runCompletion(for: controller)
  }
  
  func present(_ viewController: Presentable?,
               animated: Bool = true,
               completion: (() -> Void)? = nil)
  {
    guard let controller = viewController?.toPresent() else { return }
    rootNavController?.present(controller, animated: animated, completion: completion)
  }

  func dismissViewController(animated: Bool = true,
                             completion: (() -> Void)? = nil)
  {
    rootNavController?.dismiss(animated: animated, completion: completion)
  }

  func popToRootViewController(animated: Bool) {
    if let controllers = rootNavController?.popToRootViewController(animated: animated) {
      controllers.forEach { controller in
        runCompletion(for: controller)
      }
    }
  }

  private func runCompletion(for controller: UIViewController) {
    guard let completion = completions[controller] else { return }
    completion()
    completions.removeValue(forKey: controller)
  }
}
