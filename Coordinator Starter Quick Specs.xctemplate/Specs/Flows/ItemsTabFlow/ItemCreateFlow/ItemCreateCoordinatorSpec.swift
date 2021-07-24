// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class ItemCreateCoordinatorSpec: QuickSpec {
  
  override func spec() {
    
    describe("ItemCreateCoordinator") {
      
      // MARK: - Set Up Test Suite
      
      var rootNavController: UINavigationController!
      var spyRouter: SpyRouter!
      var spyControllerFactory: SpyControllerFactory!
      var sut: ItemCreateCoordinator!
        
      beforeEach {
        rootNavController = UINavigationController(nibName: nil, bundle: nil)
        spyRouter = SpyRouter(rootNavController: rootNavController)
        spyControllerFactory = SpyControllerFactory()
        sut = ItemCreateCoordinator(router: spyRouter,
                                    controllerFactory: spyControllerFactory)
        
        sut.start()
      }
      
      afterEach {
        rootNavController = nil
        spyRouter = nil
        spyControllerFactory = nil
        sut = nil
      }
      
      describe("start") {
        
        // MARK: - showItemCreate()
        
        describe("should run showItemCreate, which") {
          
          it("should call makeItemCreateViewController on controllerFactory") {
            expect(spyControllerFactory.callCountFor["makeItemCreateViewController"])
              .to(equal(1))
          }
          
          it("should call setRootViewController on router") {
            expect(spyRouter.callCountFor["setRootViewController"]).to(equal(1))
          }
          
          it("should call setRootViewController with an ItemCreateViewController") {
            expect(spyRouter.setRootViewControllerViewControllerArgs).to(haveCount(1))
            expect(spyRouter.setRootViewControllerViewControllerArgs.last!)
              .to(beAnInstanceOf(ItemCreateViewController.self))
          }
          
          it("should set onCompleteItemCreate on ItemCreateVC to something") {
            let itemCreateVC =
              spyRouter.setRootViewControllerViewControllerArgs.last!
                as! ItemCreateViewController
            expect(itemCreateVC.onCompleteItemCreate).toNot(beNil())
          }
          
          it("should set onTapHideButton on ItemCreateVC to something") {
            let itemCreateVC =
              spyRouter.setRootViewControllerViewControllerArgs.last!
                as! ItemCreateViewController
            expect(itemCreateVC.onTapHideButton).toNot(beNil())
          }
        }
      }///start
      
      describe("ItemCreateVC") {
        
        var itemCreateVC: ItemCreateViewController!
        var item: Item!
        var callCountForFlowDidComplete: Int!
        var calledFlowDidCompleteWithItem: Bool!
        var calledFlowDidCompleteWithNil: Bool!
        
        beforeEach {
          itemCreateVC = (spyRouter.setRootViewControllerViewControllerArgs.last!
                            as! ItemCreateViewController)
          item = Item(title: "Title", subtitle: "Subtitle")
          callCountForFlowDidComplete = 0
          calledFlowDidCompleteWithItem = false
          calledFlowDidCompleteWithNil = false
          sut.flowDidComplete = { item in
            callCountForFlowDidComplete += 1
            if item == nil {
              calledFlowDidCompleteWithNil = true
            } else {
              calledFlowDidCompleteWithItem = true
            }
          }
        }
        
        afterEach {
          itemCreateVC = nil
          item = nil
          callCountForFlowDidComplete = nil
          calledFlowDidCompleteWithItem = nil
          calledFlowDidCompleteWithNil = nil
        }
        
        // MARK: - onCompleteItemCreate()
        
        describe("onCompleteItemCreate") {
          
          beforeEach { itemCreateVC.onCompleteItemCreate!(item) }
          
          it("should call flowDidComplete") {
            expect(callCountForFlowDidComplete).to(equal(1))
          }
          
          it("should call flowDidComplete with an item") {
            expect(calledFlowDidCompleteWithItem).to(beTrue())
          }
        }
        
        // MARK: - onTapHideButton()
        
        describe("onTapHideButton") {
          
          beforeEach { itemCreateVC.onTapHideButton!() }
          
          it("should call flowDidComplete") {
            expect(callCountForFlowDidComplete).to(equal(1))
          }
          
          it("should call flowDidComplete with nil") {
            expect(calledFlowDidCompleteWithNil).to(beTrue())
          }
        }
      }///ItemCreateVC
    }//ItemCreateCoordinator
  }///spec
}
