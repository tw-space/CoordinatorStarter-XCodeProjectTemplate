// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

// MARK: - CoordinatorFactory Spec

final class CoordinatorFactorySpec: QuickSpec {
  
  override func spec() {
    
    describe("CoordinatorFactory") {
      
      // MARK: - Set Up Test Suite
      
      var rootNavController: UINavigationController!
      var spyRouter: SpyRouter!
      var sut: CoordinatorFactory!
        
      beforeEach {
        rootNavController = UINavigationController(nibName: nil, bundle: nil)
        spyRouter = SpyRouter(rootNavController: rootNavController)
        sut = CoordinatorFactory()
      }
      
      afterEach {
        rootNavController = nil
        spyRouter = nil
        sut = nil
      }
      
      // MARK: - Authentication
      
      describe("makeAuthenticationCoordinator") {
        
        it("should return an AuthenticationCoordinatorProtocol") {
          expect(sut.makeAuthenticationCoordinator(router: spyRouter))
            .to(beAKindOf(AuthenticationCoordinatorProtocol.self))
        }
      }
      
      // MARK: - Item Create
      
      describe("makeItemCreateCoordinator") {
        
        it("should return an ItemCreateCoordinatorProtocol") {
          expect(sut.makeItemCreateCoordinator(router: spyRouter))
            .to(beAKindOf(ItemCreateCoordinatorProtocol.self))
        }
      }
      
      // MARK: - Items Tab
      
      describe("makeItemsTabCoordinator") {
        
        it("should return an ItemsTabCoordinatorProtocol") {
          expect(sut.makeItemsTabCoordinator(router: spyRouter))
            .to(beAKindOf(ItemsTabCoordinatorProtocol.self))
        }
      }
      
      // MARK: - Onboarding
      
      describe("makeOnboardingCoordinator") {
        
        it("should return an OnboardingCoordinatorProtocol") {
          expect(sut.makeOnboardingCoordinator(router: spyRouter))
          .to(beAKindOf(OnboardingCoordinatorProtocol.self))
        }
      }
      
      // MARK: - Settings Tab
      
      describe("makeSettingsTabCoordinator") {
        
        it("should return a SettingsTabCoordinatorProtocol") {
          expect(sut.makeSettingsTabCoordinator(router: spyRouter))
            .to(beAKindOf(SettingsTabCoordinatorProtocol.self))
        }
      }
      
      // MARK: - TabBar
      
      describe("makeTabBarCoordinator") {
        
        it("should return a TabBarCoordinatorProtocol") {
          expect(sut.makeTabBarCoordinator(router: spyRouter))
            .to(beAKindOf(TabBarCoordinatorProtocol.self))
        }
      }
    }
  }
}
