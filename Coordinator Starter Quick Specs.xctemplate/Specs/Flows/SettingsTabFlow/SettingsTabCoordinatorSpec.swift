// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class SettingsTabCoordinatorSpec: QuickSpec {
  
  override func spec() {
    
    describe("SettingsTabCoordinator") {
      
      // MARK: - Set Up Test Suite
      
      var rootNavController: UINavigationController!
      var spyRouter: SpyRouter!
      var spyControllerFactory: SpyControllerFactory!
      var mockAppState: MockAppState!
      var sut: SettingsTabCoordinator!
        
      beforeEach {
        rootNavController = UINavigationController(nibName: nil, bundle: nil)
        spyRouter = SpyRouter(rootNavController: rootNavController)
        spyControllerFactory = SpyControllerFactory()
        mockAppState = (MockAppState.shared as! MockAppState)
        mockAppState.username = "MockUser"
        sut = SettingsTabCoordinator(router: spyRouter,
                                     controllerFactory: spyControllerFactory,
                                     appState: mockAppState)
        
        sut.start()
      }
      
      afterEach {
        rootNavController = nil
        spyRouter = nil
        spyControllerFactory = nil
        mockAppState = nil
        sut = nil
      }
      
      // MARK: - start
      
      describe("start") {
        
        describe("should call showSettingsList, which") {
          
          it("should call makeSettingsListViewController on controllerFactory") {
            expect(spyControllerFactory.callCountFor["makeSettingsListViewController"])
              .to(equal(1))
          }
          
          it("should call makeSettingsListViewController with expected string from appState") {
            expect(spyControllerFactory.makeSettingsListViewControllerUsernameArgs.first!)
              .to(equal("MockUser"))
          }
          
          it("should call setRootViewController on router") {
            expect(spyRouter.callCountFor["setRootViewController"]).to(equal(1))
          }
          
          it("should call setRootViewController with a SettingsListViewConroller") {
            expect(spyRouter.setRootViewControllerViewControllerArgs.first!)
              .to(beAnInstanceOf(SettingsListViewController.self))
          }
        }
      }
    }
  }
}
