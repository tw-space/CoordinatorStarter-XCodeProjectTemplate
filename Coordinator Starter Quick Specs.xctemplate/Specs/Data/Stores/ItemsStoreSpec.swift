// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

// MARK: - ItemsStoreSpec

final class ItemsStoreSpec: QuickSpec {
  
  override func spec() {
    
    describe("ItemsStore") {
      
      // MARK: - Set Up Test Suite
      
      var testStoreName: String!
      var testFileUrl: URL!
      var exampleDataCount: Int!
      var sut: ItemsStore!
      
      beforeEach {
        testStoreName = "TestItemsStore"
        testFileUrl = self.fileUrl(from: testStoreName)
        exampleDataCount = 15
      }
      
      afterEach {
        testStoreName = nil
        testFileUrl = nil
        exampleDataCount = nil
        sut = nil
      }
      
      // MARK: - Initial State
      
      describe("init") {
        
        context("with existing items already on disk") {
          
          it("should load items into memory") {
            let randomCount = Int.random(in: 1 ... 15)
            let itemsGreen = self.newItems(name: "Green", count: randomCount)
            self.save(itemsGreen, to: testStoreName)
            
            sut = ItemsStore(storeName: testStoreName)
            
            let loadedItems = sut.getAll()
            expect(loadedItems.count).to(equal(randomCount))
            expect(loadedItems.first!.title).to(beginWith("Green"))
          }
        }
        
        context("with no items on disk") {
          
          it("should load example data") {
            try? FileManager.default.removeItem(at: testFileUrl)
            
            sut = ItemsStore(storeName: testStoreName)
            
            let loadedItems = sut.getAll()
            expect(loadedItems.count).to(equal(exampleDataCount))
            expect(loadedItems.first!.title).to(beginWith("Item"))
          }
        }
      }//init
      
      // MARK: - With ItemsStore Initialized
      
      context("with ItemsStore initialized") {
        
        var randomCount: Int!
        var itemsBlue: [Item]!
        var loadedItems: [Item]!
        
        beforeEach {
          randomCount = Int.random(in: 1...15)
          itemsBlue = self.newItems(name: "Blue", count: randomCount)
          self.save(itemsBlue, to: testStoreName)
          
          sut = ItemsStore(storeName: testStoreName)
          loadedItems = sut.getAll()
        }
        
        afterEach {
          randomCount = nil
          itemsBlue = nil
          loadedItems = nil
        }
        
        // MARK: - getAll()
        
        describe("getAll") {
          
          it("should return an items array") {
            expect(loadedItems).to(beAKindOf([Item].self))
          }
          
          it("should return expected number of loaded items") {
            expect(loadedItems.count).to(equal(randomCount))
          }
          
          it("should return expected loaded items") {
            expect(loadedItems.first!.title).to(beginWith("Blue"))
          }
        }
        
        // MARK: - add(_ item:)
        
        describe("add item") {
          
          beforeEach {
            expect(loadedItems.count).to(equal(randomCount))
            
            sut.add(Item(title: "Added", subtitle: "Item"))
            loadedItems = sut.getAll()
          }
          
          it("should add a new item to items") {
            expect(loadedItems.count).to(equal(randomCount + 1))
          }
          
          it("should add given item to items") {
            expect(loadedItems.last!.title).to(equal("Added"))
          }
          
          it("should persist the added item to disk") {
            sut = ItemsStore(storeName: testStoreName)
            loadedItems = sut.getAll()
            
            expect(loadedItems.count).to(equal(randomCount + 1))
            expect(loadedItems.last!.title).to(equal("Added"))
          }
        }
        
        // MARK: - removeAll()
        
        describe("removeAll") {
          
          beforeEach {
            expect(loadedItems.count).to(equal(randomCount))
            
            sut.removeAll()
            loadedItems = sut.getAll()
          }
          
          it("should empty items list") {
            expect(loadedItems).to(beEmpty())
          }
          
          it("should persist empty items to disk") {
            sut = ItemsStore(storeName: testStoreName)
            loadedItems = sut.getAll()
            
            expect(loadedItems).to(beEmpty())
          }
        }
        
        // MARK: - resetExampleData()
        
        describe("resetExampleData") {
          
          beforeEach {
            sut.resetExampleData()
            loadedItems = sut.getAll()
          }
          
          it("should set items count to exampleDataCount") {
            expect(loadedItems.count).to(equal(exampleDataCount))
          }
          
          it("should persist example data to disk") {
            sut = ItemsStore(storeName: testStoreName)
            loadedItems = sut.getAll()
            
            expect(loadedItems.count).to(equal(exampleDataCount))
          }
        }
      }///with ItemsStore initialized
    }//ItemsStore
  }//spec
  
  // MARK: - Private Helpers
  
  private func fileUrl(from storeName: String) -> URL {
    Helper.getDocumentDirectory().appendingPathComponent(storeName)
  }
  
  private func newItems(name: String, count: Int = 15) -> [Item] {
    var items = [Item]()
    for i in 1 ... count {
      items.append(Item(title: "\(name) Item #\(i)",
                        subtitle: "Description \(name)"))
    }
    return items
  }
  
  private func save(_ items: [Item], to storeName: String) {
    if let data = try? JSONEncoder().encode(items) {
      do {
        try data.write(to: fileUrl(from: storeName),
                       options: [.atomicWrite,
                                 .completeFileProtection])
      } catch {
        print("Save failed")
      }
    } else {
      print("Encoding failed")
    }
  }
}
