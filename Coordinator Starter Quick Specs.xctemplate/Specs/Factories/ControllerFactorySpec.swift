// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class ControllerFactorySpec: QuickSpec {
  
  override func spec() {
    
    describe("ControllerFactory") {
      
      // MARK: - Authentication Flow
      
      context("as AuthenticationControllerFactory") {
        
        describe("makeSignInSignUpViewController") {
          
          it("should return a SignInSignUpViewController") {
            let sut: AuthenticationControllerFactory =
              ControllerFactory() as AuthenticationControllerFactory
            
            expect(sut.makeSignInSignUpViewController())
              .to(beAnInstanceOf(SignInSignUpViewController.self))
          }
        }
      }
      
      // MARK: - Items Tab Flow
      
      context("as ItemsTabControllerFactory") {
        
        var sut: ItemsTabControllerFactory!
        
        beforeEach { sut = ControllerFactory() as ItemsTabControllerFactory }
        afterEach  { sut = nil }
        
        describe("makeItemsTabNavController") {
          
          var itemsTabNC: UINavigationController!
          
          beforeEach { itemsTabNC = sut.makeItemsTabNavController() }
          afterEach  { itemsTabNC = nil }
          
          it("should return a UINavigationController") {
            expect(sut.makeItemsTabNavController())
              .to(beAnInstanceOf(UINavigationController.self))
          }
          
          it("should return nc with tabBarItem title set to Items") {
            expect(itemsTabNC.tabBarItem.title)
              .to(equal("Items"))
          }
          
          it("should return nc with tabBarItem image set to rect grid 1x2") {
            expect(itemsTabNC.tabBarItem.image)
              .to(equal(UIImage(systemName: "rectangle.grid.1x2")))
          }
          
          it("should return nc with tabBarItem selected image set to rect grid 1x2 fill") {
            expect(itemsTabNC.tabBarItem.selectedImage)
              .to(equal(UIImage(systemName: "rectangle.grid.1x2.fill")))
          }
        }
        
        describe("makeItemsListViewController with ItemsStoreProtocol") {
          
          it("should return an ItemsListViewController") {
            expect(sut.makeItemsListViewController(itemsStore: MockItemsStore()))
              .to(beAnInstanceOf(ItemsListViewController.self))
          }
        }
        
        describe("makeItemDetailViewController with Item") {
          
          it("should return an ItemDetailViewController") {
            let item = Item(title: "Item No 1", subtitle: "Description")
            expect(sut.makeItemDetailViewController(for: item))
              .to(beAnInstanceOf(ItemDetailViewController.self))
          }
        }
      }
      
      // MARK: - Item Create Flow
      
      context("as ItemCreateControllerFactory") {
        
        describe("makeItemCreateViewController") {
          
          it("should return an ItemCreateViewController") {
            let sut = ControllerFactory() as ItemCreateControllerFactory
            expect(sut.makeItemCreateViewController())
              .to(beAnInstanceOf(ItemCreateViewController.self))
          }
        }
      }
      
      // MARK: - Onboarding Flow
      
      context("as OnboardingControllerFactory") {
        
        describe("makeOnboardingViewController") {
          
          it("should return an OnboardingViewController") {
            let sut = ControllerFactory() as OnboardingControllerFactory
            expect(sut.makeOnboardingViewController())
              .to(beAnInstanceOf(OnboardingViewController.self))
          }
        }
      }
      
      // MARK: - Settings Flow
      
      context("as SettingsTabControllerFactory") {
        
        var sut: SettingsTabControllerFactory!
        
        beforeEach { sut = ControllerFactory() as SettingsTabControllerFactory }
        afterEach  { sut = nil }
        
        describe("makeSettingsTabNavController") {
          
          var settingsTabNC: UINavigationController!
          
          beforeEach { settingsTabNC = sut.makeSettingsTabNavController() }
          afterEach  { settingsTabNC = nil }
          
          it("should return a UINavigationController") {
            expect(sut.makeSettingsTabNavController())
              .to(beAnInstanceOf(UINavigationController.self))
          }
          
          it("should return nc with tabBarItem title set to Settings") {
            expect(settingsTabNC.tabBarItem.title)
              .to(equal("Settings"))
          }
          
          it("should return nc with tabBarItem image set to gearshape") {
            expect(settingsTabNC.tabBarItem.image)
              .to(equal(UIImage(systemName: "gearshape")))
          }
          
          it("should return nc with tabBarItem selected image set to gearshape fill") {
            expect(settingsTabNC.tabBarItem.selectedImage)
              .to(equal(UIImage(systemName: "gearshape.fill")))
          }
        }
        
        describe("makeSettingsListViewController") {
          
          context("with nil username") {
            
            it("should return a SettingsListViewController") {
              expect(sut.makeSettingsListViewController(username: nil))
                .to(beAnInstanceOf(SettingsListViewController.self))
            }
          }
          
          context("with username string") {
            
            it("should return a SettingsListViewController") {
              expect(sut.makeSettingsListViewController(username: "User"))
                .to(beAnInstanceOf(SettingsListViewController.self))
            }
          }
        }
      }
      
      // MARK: - MainTabBarFlow
      
      context("as TabBarControllerFactory") {
        
        var sut: TabBarControllerFactory!
        
        beforeEach { sut = ControllerFactory() as TabBarControllerFactory }
        afterEach  { sut = nil }
        
        describe("makeTabBarController") {
          
          context("with empty tabNavControllers") {
            
            it("should return a TabBarController") {
              expect(sut.makeTabBarController(tabNavControllers: []))
                .to(beAnInstanceOf(TabBarController.self))
            }
          }
          
          context("with multiple tabNavControllers") {
            
            it("should return a TabBarController") {
              let tabNavControllers = [UINavigationController(), UINavigationController()]
              expect(sut.makeTabBarController(tabNavControllers: tabNavControllers))
                .to(beAnInstanceOf(TabBarController.self))
            }
          }
        }
      }
    }///ControllerFactory
  }//spec
}
