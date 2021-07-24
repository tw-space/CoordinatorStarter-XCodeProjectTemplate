// ___FILEHEADER___

import UIKit

final class TabBarController: UITabBarController,
                              UITabBarControllerDelegate
{
  // MARK: - Properties
  
  var onItemsTabSelect: ((UINavigationController) -> Void)?
  var onSettingsTabSelect: ((UINavigationController) -> Void)?
  var onViewDidLoad: ((UINavigationController) -> Void)?
  
  // MARK: - Initializers
  
  init(tabNavControllers: [UINavigationController]) {
    super.init(nibName: nil, bundle: nil)
    viewControllers = tabNavControllers
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self

    if let controller = customizableViewControllers?.first as? UINavigationController {
      onViewDidLoad?(controller)
    }
  }
  
  // MARK: - Tab Bar Controller Delegate

  func tabBarController(_ tabBarController: UITabBarController,
                        didSelect viewController: UIViewController)
  {
    guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
    
    if selectedIndex == 0 {
      onItemsTabSelect?(controller)
    } else if selectedIndex == 1 {
      onSettingsTabSelect?(controller)
    }
  }
}
