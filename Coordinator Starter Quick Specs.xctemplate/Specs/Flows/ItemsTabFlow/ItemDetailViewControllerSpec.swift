// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class ItemDetailViewControllerSpec: QuickSpec {
  
  override func spec() {
    
    describe("ItemDetailViewController") {
      
      // MARK: - Set Up Test Suite
      
      var item: Item!
      var sut: ItemDetailViewController!
      var rootNavController: UINavigationController!
        
      beforeEach {
        item = Item(title: "Title", subtitle: "Subtitle")
        sut = ItemDetailViewController(for: item)
        rootNavController = UINavigationController(nibName: nil, bundle: nil)
        rootNavController.viewControllers = [sut]
        _ = sut.view
      }
      
      afterEach {
        item = nil
        sut = nil
        rootNavController = nil
      }
      
      // MARK: - After Load
      
      describe("after load") {
        
        it("should have title set to item title") {
          expect(sut.title).to(equal(item.title))
        }
        
        it("should have navigation bar in standard appearance") {
          expect(sut.navigationItem.largeTitleDisplayMode.rawValue)
            .to(equal(UINavigationItem.LargeTitleDisplayMode.never.rawValue))
        }
        
        it("should set view label text to item title") {
          expect(sut.vw.mainLabel.text).to(equal(item.title))
        }
      }
    }
  }
}
