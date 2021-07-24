// ___FILEHEADER___

import UIKit

class SettingsListViewController: UIViewController {
  
  // MARK: - Properties
  
  var username: String?
  var vw: SettingsListView!
  
  // MARK: - Initializers
  
  init(username: String?) {
    self.username = username
    self.vw = SettingsListView(username: username)
    
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func loadView() {
    view = vw
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
