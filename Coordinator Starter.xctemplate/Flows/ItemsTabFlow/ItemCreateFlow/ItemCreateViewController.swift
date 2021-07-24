// ___FILEHEADER___

import UIKit

class ItemCreateViewController: UIViewController {
  
  // MARK: - Properties
  
  var vw = ItemCreateView()
  
  var onTapHideButton: (() -> Void)?
  var onCompleteItemCreate: ((Item) -> ())?
  
  // MARK: - Lifecycle
  
  override func loadView() {
    view = vw
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // navigation controller
    title = "Create Item"
    navigationItem.leftBarButtonItem =
      UIBarButtonItem(title: "Hide",
                      style: .plain,
                      target: self,
                      action: #selector(tappedHideButton(_:)))
    navigationItem.rightBarButtonItem =
      UIBarButtonItem(title: "Create",
                      style: .plain,
                      target: self,
                      action: #selector(tappedCreateButton(_:)))
    navigationItem.largeTitleDisplayMode = .never
  }
  
  // MARK: - Handlers
  
  @objc func tappedHideButton(_ sender: UIBarButtonItem) {
    onTapHideButton?()
  }
  
  @objc func tappedCreateButton(_ sender: UIBarButtonItem) {
    onCompleteItemCreate?(Item(title: "New item",
                               subtitle: "New description"))
  }
  
}
