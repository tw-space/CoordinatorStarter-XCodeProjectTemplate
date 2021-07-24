// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import UIKit

class MockItemsStore: ItemsStoreProtocol {
  
  // MARK: - Properties
  
  private var items = [Item]()
  
  // MARK: - Initializer
  
  init() {
    resetExampleData()
  }
  
  // MARK: - Data operations
  
  public func add(_ item: Item) {
    items.append(item)
  }
  
  public func getAll() -> [Item] {
    return items
  }
  
  public func removeAll() {
    items = []
  }
  
  // MARK: - Helpers
  
  public func resetExampleData() {
    items = [Item]()
    for index in 1 ... 15 {
      add(Item(title: "Item № \(index)",
                      subtitle: "Item description"))
    }
  }
}

