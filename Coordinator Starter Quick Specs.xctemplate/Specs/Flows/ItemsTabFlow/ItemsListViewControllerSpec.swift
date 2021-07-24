// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class ItemsListViewControllerSpec: QuickSpec {
  
  override func spec() {
    
    describe("ItemsListViewController") {
      
      // MARK: - Set Up Test Suite
      
      var mockItemsStore: MockItemsStore!
      var sut: ItemsListViewController!
        
      beforeEach {
        mockItemsStore = MockItemsStore()
        sut = ItemsListViewController(itemsStore: mockItemsStore)
        _ = UINavigationController(rootViewController: sut)
        _ = sut.view
      }
      
      afterEach {
        mockItemsStore = nil
        sut = nil
      }
      
      // MARK: - after load
      
      describe("after load") {
        
        describe("navigation bar") {
          
          it("should have title set to Items") {
            expect(sut.title).to(equal("Items"))
          }
          
          it("should have a right bar button") {
            expect(sut.navigationItem.rightBarButtonItem).toNot(beNil())
          }
          
          it("should have a left bar button") {
            expect(sut.navigationItem.leftBarButtonItem).toNot(beNil())
          }
          
          it("should prefer large titles") {
            expect(sut.navigationController?.navigationBar.prefersLargeTitles)
              .to(beTrue())
          }
          
          context("when tapping right bar button") {
            
            it("should run onCreateItem") {
              var tappedOnCreateItem = false
              sut.onCreateItem = {
                tappedOnCreateItem = true
              }
              
              tap(sut.navigationItem.rightBarButtonItem!)
              
              expect(tappedOnCreateItem).to(beTrue())
            }
          }
          
          context("when tapping left bar button") {
            
            it("should run onTapReset") {
              var tappedOnTapReset = false
              sut.onTapReset = {
                tappedOnTapReset = true
              }
              
              tap(sut.navigationItem.leftBarButtonItem!)
              
              expect(tappedOnTapReset).to(beTrue())
            }
          }
        }
        
        // MARK: - tableView
        
        describe("tableView") {
          
          it("should be set to an ItemsListView") {
            expect(sut.tableView).to(beAnInstanceOf(ItemsListView.self))
          }
          
          xit("should register ItemCellView") {
            // unsure how to test
          }
          
          describe("dataSource") {
            
            it("should return 1 as number of sections") {
              expect(sut.numberOfSections(in: sut.tableView)).to(equal(1))
            }
            
            it("should return item count as number of rows in first section") {
              expect(sut.tableView(sut.tableView, numberOfRowsInSection: 0))
                .to(equal(sut.items.count))
            }
            
            describe("tableView cellForRowAt random row section 0") {
              
              var randomRow: Int!
              var cell: UITableViewCell!
              
              beforeEach {
                randomRow = Int.random(in: 0 ..< sut.items.count)
                cell = sut.tableView(sut.tableView,
                                     cellForRowAt: IndexPath(row: randomRow, section: 0))
              }
              
              afterEach {
                randomRow = nil
                cell = nil
              }
              
              it("should return an ItemCellView") {
                expect(cell).to(beAnInstanceOf(ItemCellView.self))
              }
              
              it("should set cell title to first item title") {
                expect((cell as! ItemCellView).title.text).to(equal(sut.items[randomRow].title))
              }
              
              it("should set cell subtitle to first item subtitle") {
                expect((cell as! ItemCellView).subtitle.text).to(equal(sut.items[randomRow].subtitle))
              }
            }
          }
          
          describe("delegate") {
            
            describe("didSelectRowAt random row") {
              
              var randomRow: Int!
              
              beforeEach {
                randomRow = Int.random(in: 0 ..< sut.items.count)
              }
              
              afterEach {
                randomRow = nil
              }
              
              it("should call onItemSelect") {
                var tappedOnItemSelect = false
                sut.onItemSelect = { _ in
                  tappedOnItemSelect = true
                }
                
                sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: randomRow, section: 0))
                
                expect(tappedOnItemSelect).to(beTrue())
              }
              
              it("should call onItemSelect with item of that row index") {
                var itemTitle: String?
                var itemSubtitle: String?
                sut.onItemSelect = { item in
                  itemTitle = item.title
                  itemSubtitle = item.subtitle
                }
                
                sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: randomRow, section: 0))
                
                expect(itemTitle).to(equal(sut.items[randomRow].title))
                expect(itemSubtitle).to(equal(sut.items[randomRow].subtitle))
              }
            }
          }
        }
      }
    }
  }
}
