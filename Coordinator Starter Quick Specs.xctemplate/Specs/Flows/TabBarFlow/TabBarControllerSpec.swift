// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class TabBarControllerSpec: QuickSpec {
  
  override func spec() {
    
    describe("TabBarController") {
      
      // MARK: - Set Up Test Suite
      
      var itemsTabNavController: UINavigationController!
      var settingsTabNavController: UINavigationController!
      var sut: TabBarController!
        
      beforeEach {
        let controllerFactory = ControllerFactory()
        itemsTabNavController = controllerFactory.makeItemsTabNavController()
        settingsTabNavController = controllerFactory.makeSettingsTabNavController()
        sut = TabBarController(tabNavControllers: [itemsTabNavController,
                                                   settingsTabNavController])
      }
      
      afterEach {
        itemsTabNavController = nil
        settingsTabNavController = nil
        sut = nil
      }
      
      // MARK: - init
      
      describe("init") {
        
        it("should set viewControllers to tabNavControllers") {
          expect(sut.viewControllers).to(equal([itemsTabNavController, settingsTabNavController]))
        }
      }
      
      // MARK: - viewDidLoad
      
      describe("viewDidLoad") {
        
        it("should call onViewDidLoad") {
          var calledOnViewDidLoad = false
          sut.onViewDidLoad = { _ in
            calledOnViewDidLoad = true
          }
          
          sut.viewDidLoad()
          
          expect(calledOnViewDidLoad).to(beTrue())
        }
        
        it("should call onViewDidLoad with first nav controller") {
          var onViewDidLoadController: UINavigationController?
          sut.onViewDidLoad = { controller in
            onViewDidLoadController = controller
          }
          
          sut.viewDidLoad()
          
          expect(onViewDidLoadController).to(equal(sut.viewControllers?.first!))
        }
      }
      
      // MARK: - didSelect delegate
      
      describe("delegate didSelect") {
        
        context("with view controller at index 0") {
          
          it("should call onItemsTabSelect") {
            var calledOnItemsTabSelect = false
            sut.onItemsTabSelect = { _ in
              calledOnItemsTabSelect = true
            }
            
            sut.tabBarController(sut, didSelect: (sut.viewControllers?[0])!)
            
            expect(calledOnItemsTabSelect).to(beTrue())
          }
          
          it("should call onItemsTabSelect with first view controller as nav controller") {
            var onItemsTabSelectControllerArg: UINavigationController?
            sut.onItemsTabSelect = { controller in
              onItemsTabSelectControllerArg = controller
            }
            
            sut.tabBarController(sut, didSelect: (sut.viewControllers?[0])!)
            
            expect(onItemsTabSelectControllerArg)
              .to(beIdenticalTo((sut.viewControllers?[0] as! UINavigationController)))
          }
        }
        
        context("with view controller at index 1") {
          
          it("should call onSettingsTabSelect") {
            var calledOnSettingsTabSelect = false
            sut.onSettingsTabSelect = { _ in
              calledOnSettingsTabSelect = true
            }
            
            sut.selectedIndex = 1
            sut.tabBarController(sut, didSelect: (sut.viewControllers?[1])!)
            
            expect(calledOnSettingsTabSelect).to(beTrue())
          }
          
          it("should call onSettingsTabSelect with second view controller as nav controller") {
            var onSettingsTabSelectControllerArg: UINavigationController?
            sut.onSettingsTabSelect = { controller in
              onSettingsTabSelectControllerArg = controller
            }
            
            sut.selectedIndex = 1
            sut.tabBarController(sut, didSelect: (sut.viewControllers?[1])!)
            
            expect(onSettingsTabSelectControllerArg)
              .to(beIdenticalTo((sut.viewControllers?[1] as! UINavigationController)))
          }
        }
      }
    }
  }
}
