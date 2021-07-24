// ___FILEHEADER___

import UIKit

final class ItemsListViewController: UITableViewController {

  // MARK: - Properties
  
  var items: [Item]
  var onItemSelect: ((Item) -> Void)?
  var onCreateItem: (() -> Void)?
  var onTapReset: (() -> Void)?

  var vw = ItemsListView()
  
  // MARK: - Initializer
  
  init(itemsStore: ItemsStoreProtocol) {
    self.items = itemsStore.getAll()
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle

  override func loadView() {
    // initialize tableView here to make clearsSelectionOnViewWillAppear work
    tableView = vw
    tableView.register(ItemCellView.self, forCellReuseIdentifier: "itemCell")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // navigation controller
    title = "Items"
    navigationItem.rightBarButtonItem =
      UIBarButtonItem(barButtonSystemItem: .add,
                      target: self,
                      action: #selector(tappedAddItemButton(_:)))
    navigationItem.leftBarButtonItem =
      UIBarButtonItem(title: "Reset",
                      style: .plain,
                      target: self,
                      action: #selector(tappedResetButton(_:)))
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  // MARK: - Handlers

  @objc func tappedAddItemButton(_ sender: UIBarButtonItem) { onCreateItem?() }
  
  @objc func tappedResetButton(_ sender: UIBarButtonItem) { onTapReset?() }

  // MARK: - Table View Data Source & Delegate

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int)
    -> Int
  {
    return items.count
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCellView
    let item = items[(indexPath as NSIndexPath).row]
    cell.title?.text = item.title
    cell.subtitle?.text = item.subtitle
    return cell
  }

  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath)
  {
    onItemSelect?(items[(indexPath as NSIndexPath).row])
  }
}
