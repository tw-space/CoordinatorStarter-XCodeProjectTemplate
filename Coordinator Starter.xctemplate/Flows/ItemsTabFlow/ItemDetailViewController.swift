// ___FILEHEADER___

import UIKit

final class ItemDetailViewController: UIViewController {
  
  // MARK: - Properties

  var item: Item
  var vw: ItemDetailView!
  
  // MARK: - Initializer
  
  init(for item: Item) {
    self.item = item
    self.vw = ItemDetailView(for: item)
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

    // configure navigation controller
    title = item.title
    navigationItem.largeTitleDisplayMode = .never
  }
}

