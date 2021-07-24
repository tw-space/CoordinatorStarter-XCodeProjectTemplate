// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class TabBarCoordinatorSpec: QuickSpec {
  
  override func spec() {
    
    describe("TabBarCoordinator start") {
      
      // MARK: - Set Up Test Suite
      
      var rootNavController: UINavigationController!
      var spyRouter: SpyRouter!
      var tabNavControllers: [UINavigationController]!
      var spyControllerFactory: SpyControllerFactory!
      var mockCoordinatorFactory: MockCoordinatorFactory!
      var sut: TabBarCoordinator!
      
      beforeEach {
        rootNavController = UINavigationController(nibName: nil, bundle: nil)
        spyRouter = SpyRouter(rootNavController: rootNavController)
        tabNavControllers = [UINavigationController(), UINavigationController()]
        spyControllerFactory = SpyControllerFactory()
        mockCoordinatorFactory = MockCoordinatorFactory()
        sut = TabBarCoordinator(router: spyRouter,
                                tabNavControllers: tabNavControllers,
                                controllerFactory: spyControllerFactory as TabBarControllerFactory,
                                coordinatorFactory: mockCoordinatorFactory)
        
        sut.start()
      }
      
      afterEach {
        rootNavController = nil
        spyRouter = nil
        tabNavControllers = nil
        spyControllerFactory = nil
        mockCoordinatorFactory = nil
        sut = nil
      }
      
      // MARK: - start()
      
      describe("should showTabBar, which") {
        
        it("should set tabBarController to not nil") {
          expect(sut.tabBarController).toNot(beNil())
        }
        
        it("should call makeTabBarController on controllerFactory") {
          expect(spyControllerFactory.callCountFor["makeTabBarController"])
            .to(equal(1))
        }
        
        it("should call makeTabBarController with an array of nav controllers") {
          expect(spyControllerFactory.makeTabBarControllerTabNCArgs.first)
            .to(beAKindOf([UINavigationController].self))
        }
        
        it("should set onViewDidLoad on tabBarController") {
          expect(sut.tabBarController.onViewDidLoad).toNot(beNil())
        }
        
        it("should set onItemsTabSelect on tabBarController") {
          expect(sut.tabBarController.onItemsTabSelect).toNot(beNil())
        }
        
        it("should set onSettingsTabSelect on tabBarController") {
          expect(sut.tabBarController.onSettingsTabSelect).toNot(beNil())
        }
        
        it("should call setRootViewController on router") {
          expect(spyRouter.callCountFor["setRootViewController"])
            .to(equal(1))
        }
        
        it("should call setRootViewController with a TabBarController") {
          expect(spyRouter.setRootViewControllerViewControllerArgs.first!)
            .to(beAnInstanceOf(TabBarController.self))
        }
        
        it("should call setRootViewController with hideTopBar true") {
          expect(spyRouter.setRootViewControllerHideTopBarArgs.first)
            .to(beTrue())
        }
        
        it("should call setRootViewController with animated true") {
          expect(spyRouter.setRootViewControllerAnimatedArgs.first)
            .to(beTrue())
        }
      }
      
      // MARK: - runItemsTabFlow
      
      describe("should runItemsTabFlow, which") {
        
        it("should call makeItemsTabCoordinator on coordinatorFactory") {
          expect(mockCoordinatorFactory.callCountFor["makeItemsTabCoordinator"]).to(equal(1))
        }
        
        it("should call makeItemsTabCoordinator with router") {
          expect(mockCoordinatorFactory.makeItemsTabCoordinatorRouterArgs.first)
            .to(beAKindOf(Router.self))
        }
        
        it("should call makeItemsTabCoordinator with first navigation controller in tab stack") {
          let firstTabNavController = sut.tabBarController.viewControllers?.first!
          expect(mockCoordinatorFactory.makeItemsTabCoordinatorRouterArgs).to(haveCount(1))
          expect(mockCoordinatorFactory.makeItemsTabCoordinatorRouterArgs.first?.rootNavController)
            .to(beIdenticalTo(firstTabNavController))
        }
        
        it("should add an ItemsTabCoordinatorProtocol as child") {
          expect(sut.childCoordinators).to(haveCount(1))
          expect((sut.childCoordinators.first as? SpyCoordinator)?.type)
            .to(equal("ItemsTabCoordinatorProtocol"))
        }
        
        it("should call start on ItemsTabCoordinatorProtocol child") {
          let firstChildSpy = (sut.childCoordinators.first as? SpyCoordinator)
          expect(firstChildSpy?.type).to(equal("ItemsTabCoordinatorProtocol"))
          expect(firstChildSpy?.callCountFor["start"]).to(equal(1))
        }
      }
      
      // MARK: - runSettingsTabFlow
      
      describe("then runSettingsTabFlow via tabBarController onSettingsTabSelect with second tab nav controller") {
        
        var secondTabNavController: UIViewController!
        
        beforeEach {
          secondTabNavController = sut.tabBarController.viewControllers![1]
          sut.tabBarController.onSettingsTabSelect!(secondTabNavController as! UINavigationController)
        }
        
        afterEach {
          secondTabNavController = nil
        }
        
        it("should call makeSettingsTabCoordinator on coordinatorFactory") {
          expect(mockCoordinatorFactory.callCountFor["makeSettingsTabCoordinator"]).to(equal(1))
        }
        
        it("should call makeSettingsTabCoordinator with a router") {
          expect(mockCoordinatorFactory.makeSettingsTabCoordinatorRouterArgs.first)
            .to(beAKindOf(Router.self))
        }
        
        it("should call makeSettingsTabCoordinator with second navigation controller in tab stack") {
          expect(mockCoordinatorFactory.makeSettingsTabCoordinatorRouterArgs).to(haveCount(1))
          expect(mockCoordinatorFactory.makeSettingsTabCoordinatorRouterArgs.first?.rootNavController)
            .to(beIdenticalTo(secondTabNavController))
        }
        
        it("should add a SettingsTabCoordinator as second child") {
          expect(sut.childCoordinators).to(haveCount(2))
          expect((sut.childCoordinators.last as? SpyCoordinator)?.type)
            .to(equal("SettingsTabCoordinatorProtocol"))
        }
        
        it("should call start on SettingsTabCoordinatorProtocol child") {
          let secondChildSpy = (sut.childCoordinators[1] as! SpyCoordinator)
          expect(secondChildSpy.type).to(equal("SettingsTabCoordinatorProtocol"))
          expect(secondChildSpy.callCountFor["start"]).to(equal(1))
        }
      }
    }///TabBarCoordinator
  }//spec
}
