// ___FILEHEADER___

import UIKit

protocol ItemsStoreProtocol {
  func add(_ item: Item)
  func getAll() -> [Item]
  func removeAll()
  func resetExampleData()
}

class ItemsStore: ItemsStoreProtocol {
  
  // MARK: - Properties
  
  private let storeName: String!
  private let filePath: URL!
  
  private var items = [Item]()
  
  // MARK: - Initializer
  
  init(storeName: String) {
    self.storeName = storeName
    self.filePath = Helper.getDocumentDirectory().appendingPathComponent(storeName)
    
    load()
  }
  
  // MARK: - Data operations
  
  public func add(_ item: Item) {
    items.append(item)
    save()
  }
  
  public func getAll() -> [Item] {
    return items
  }
  
  public func removeAll() {
    items = []
    save()
  }
  
  // MARK: - Persistence
  
  private func load() {
    if let data = try? Data(contentsOf: filePath) {
      if let loadedItems = try? JSONDecoder().decode([Item].self, from: data) {
        items = loadedItems
        return
      }
    }
    resetExampleData()
  }
  
  private func save() {
    if let data = try? JSONEncoder().encode(items) {
      do {
        try data.write(to: filePath,
                       options: [.atomicWrite,
                                 .completeFileProtection])
      } catch {
        print("Save failed")
      }
    } else {
      print("Encoding failed")
    }
  }
  
  // MARK: - Helpers
  
  public func resetExampleData() {
    items = [Item]()
    for index in 1 ... 15 {
      add(Item(title: "Item № \(index)",
                      subtitle: "Item description"))
    }
    save()
  }
}
