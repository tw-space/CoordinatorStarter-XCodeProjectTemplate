// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import UIKit

class SpyRouter: Router {
  
  // MARK: - Spy Properties
  
  var callCountFor: [String: Int] = [
    "dismissViewController": 0,
    "present": 0,
    "push": 0,
    "setRootViewController": 0,
  ]
  
  var presentViewControllerArgs: [Presentable?] = []
  
  var pushViewControllerArgs: [Presentable?] = []
  var pushHideBottomBarArgs: [Bool] = []
  
  var setRootViewControllerViewControllerArgs: [Presentable?] = []
  var setRootViewControllerHideTopBarArgs: [Bool] = []
  var setRootViewControllerAnimatedArgs: [Bool] = []
  
  // MARK: - Spy Overrides
  
  override func dismissViewController(animated: Bool = true,
                                      completion: (() -> Void)? = nil)
  {
    callCountFor["dismissViewController"]! += 1
    
    super.dismissViewController(animated: animated, completion: completion)
  }
  
  override func present(_ viewController: Presentable?,
                        animated: Bool = true,
                        completion: (() -> Void)? = nil)
  {
    callCountFor["present"]! += 1
    presentViewControllerArgs.append(viewController)
    
    super.present(viewController, animated: animated, completion: completion)
  }
  
  override func push(_ viewController: Presentable?,
                     animated: Bool = true,
                     hideBottomBar: Bool = false,
                     completion: (() -> Void)? = nil)
  {
    callCountFor["push"]! += 1
    pushViewControllerArgs.append(viewController)
    pushHideBottomBarArgs.append(hideBottomBar)
    
    super.push(viewController,
               animated: animated,
               hideBottomBar: hideBottomBar,
               completion: completion)
  }
  
  override func setRootViewController(_ viewController: Presentable?,
                                      hideTopBar: Bool = false,
                                      animated: Bool = false)
  {
    callCountFor["setRootViewController"]! += 1
    setRootViewControllerViewControllerArgs.append(viewController)
    setRootViewControllerHideTopBarArgs.append(hideTopBar)
    setRootViewControllerAnimatedArgs.append(animated)
    
    super.setRootViewController(viewController,
                                hideTopBar: hideTopBar,
                                animated: animated)
  }
}
