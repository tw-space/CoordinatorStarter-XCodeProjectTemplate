// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class ItemCreateViewControllerSpec: QuickSpec {
  
  override func spec() {
    
    describe("ItemCreateViewController after view loads") {
      
      // MARK: - Set Up Test Suite
      
      var sut: ItemCreateViewController!
      var rootNavController: UINavigationController!
      var window: UIWindow!
      
      beforeEach {
        sut = ItemCreateViewController()
        rootNavController = UINavigationController(nibName: nil, bundle: nil)
        rootNavController.viewControllers = [sut]
        window = UIWindow()
        executeRunLoop()
        window.rootViewController = rootNavController
        executeRunLoop()
        window.makeKeyAndVisible()
        _ = sut.view
        executeRunLoop()
      }
      
      afterEach {
        sut = nil
        rootNavController = nil
        window.resignKey()
        window = nil
        executeRunLoop()
      }
      
      // MARK: - viewDidLoad
      
      it("should set title to something") {
        expect(sut.title).toNot(beNil())
      }
      
      it("should set leftBarButtonItem to something") {
        expect(sut.navigationItem.leftBarButtonItem).toNot(beNil())
      }
      
      it("should set rightBarButtonItem to something") {
        expect(sut.navigationItem.rightBarButtonItem).toNot(beNil())
      }
      
      // MARK: - tapping buttons
      
      describe("tapping Hide button") {
        
        it("should run onTapHideButton") {
          var tapHideCount = 0
          sut.onTapHideButton = { tapHideCount += 1 }
          
          tap(sut.navigationItem.leftBarButtonItem!)
          
          expect(tapHideCount).to(equal(1))
        }
      }
      
      describe("tapping Create button") {
        
        it("should run onCompleteItemCreate with an Item") {
          var tapCreateCount = 0
          sut.onCompleteItemCreate = { item in
            tapCreateCount += 1
          }
          
          tap(sut.navigationItem.rightBarButtonItem!)
          
          expect(tapCreateCount).to(equal(1))
        }
      }
    }
  }
}
