// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class AppCoordinatorSpec: QuickSpec {
  
  override func spec() {
    
    describe("AppCoordinator start") {
      
      // MARK: - Set Up Test Suite
      
      var rootNavController: UINavigationController!
      var spyRouter: SpyRouter!
      var mockCoordinatorFactory: MockCoordinatorFactory!
      var mockAppState: MockAppState!
      var sut: AppCoordinator!
        
      beforeEach {
        rootNavController = UINavigationController()
        spyRouter = SpyRouter(rootNavController: rootNavController)
        mockCoordinatorFactory = MockCoordinatorFactory()
        mockAppState = (MockAppState.shared as! MockAppState)
        mockAppState.reset()
        sut = AppCoordinator(router: spyRouter,
                             coordinatorFactory: mockCoordinatorFactory,
                             appState: mockAppState)
      }
      
      afterEach {
        rootNavController = nil
        spyRouter = nil
        mockCoordinatorFactory = nil
        mockAppState = nil
        sut = nil
      }
      
      // MARK: - runAuthFlow
      
      context("with isAuthenticated and onboardingWasShown set false") {
        
        beforeEach {
          mockAppState.isAuthenticated = false
          mockAppState.onboardingWasShown = false
          expect(sut.childCoordinators).to(haveCount(0))
          
          sut.start()
        }
        
        it("should call coordinatorFactory to makeAuthenticationCoordinator") {
          expect(mockCoordinatorFactory.callCountFor["makeAuthenticationCoordinator"])
            .to(equal(1))
        }
        
        it("should call makeAuthenticationCoordinator with a router") {
          expect(mockCoordinatorFactory.makeAuthenticationCoordinatorRouterArgs.first)
            .to(beAKindOf(Router.self))
        }
        
        it("should add as child a kind of AuthenticationCoordinatorProtocol") {
          expect(sut.childCoordinators).to(haveCount(1))
          expect(sut.childCoordinators.first)
            .to(beAKindOf(AuthenticationCoordinatorProtocol.self))
        }
        
        it("should call start on child") {
          expect((sut.childCoordinators.first as! SpyCoordinator).callCountFor["start"])
            .to(equal(1))
        }
        
        it("should set child onCompleteAuth to something") {
          expect((sut.childCoordinators.first as! AuthenticationCoordinatorProtocol)
                  .onCompleteAuth)
            .toNot(beNil())
        }
        
        describe("then onCompleteAuth") {
          
          beforeEach {
            expect(mockAppState.username).to(beNil())
            expect(mockAppState.isAuthenticated).to(beFalse())
            expect(mockCoordinatorFactory.callCountFor["makeOnboardingCoordinator"])
              .to(equal(0))
            expect(sut.childCoordinators)
              .to(containElementSatisfying({
                ($0 as! SpyCoordinator).type == "AuthenticationCoordinatorProtocol"
              }))
            
            (sut.childCoordinators.first! as! AuthenticationCoordinatorProtocol)
              .onCompleteAuth!("SignedInUser")
          }
          
          it("should set username to callback parameter") {
            expect(mockAppState.username).to(equal("SignedInUser"))
          }
          
          it("should set appState isAuthenticated true") {
            expect(mockAppState.isAuthenticated).to(beTrue())
          }
          
          it("should run start again which means runOnboardingFlow") {
            expect(mockCoordinatorFactory.callCountFor["makeOnboardingCoordinator"])
              .to(equal(1))
          }
          
          it("should remove AuthenticationCoordinator from childs") {
            expect(sut.childCoordinators)
              .toNot(containElementSatisfying({
                ($0 as! SpyCoordinator).type == "AuthenticationCoordinatorProtocol"
              }))
          }
        }
      }
      
      context("with isAuthenticated false and onboardingWasShown true") {
        
        beforeEach {
          mockAppState.isAuthenticated = false
          mockAppState.onboardingWasShown = true
          expect(sut.childCoordinators).to(haveCount(0))
          
          sut.start()
        }
        
        it("should also runAuthFlow and call coordinatorFactory to makeAuthenticationCoordinator") {
          expect(mockCoordinatorFactory.callCountFor["makeAuthenticationCoordinator"])
            .to(equal(1))
        }
      }
      
      // MARK: - runOnboardingFlow
      
      context("with isAuthenticated true and onboardingWasShown false") {
        
        beforeEach {
          mockAppState.isAuthenticated = true
          mockAppState.onboardingWasShown = false
          expect(sut.childCoordinators).to(haveCount(0))
          
          sut.start()
        }
        
        it("should call coordinatorFactory to makeOnboardingCoordinator") {
          expect(mockCoordinatorFactory.callCountFor["makeOnboardingCoordinator"])
            .to(equal(1))
        }
        
        it("should call makeOnboardingCoordinator with router") {
          expect(mockCoordinatorFactory.makeOnboardingCoordinatorRouterArgs.first)
            .to(beAKindOf(Router.self))
        }
        
        it("should add as child a kind of OnboardingCoordinatorProtocol") {
          expect(sut.childCoordinators).to(haveCount(1))
          expect(sut.childCoordinators.first!)
            .to(beAKindOf(OnboardingCoordinatorProtocol.self))
        }
        
        it("should call start on child") {
          expect((sut.childCoordinators.first! as! SpyCoordinator).callCountFor["start"])
            .to(equal(1))
        }
        
        it("should set child onCompleteOnboarding to something") {
          expect((sut.childCoordinators.first! as! OnboardingCoordinatorProtocol)
                  .onCompleteOnboarding)
            .toNot(beNil())
        }
        
        describe("then onCompleteOnboarding") {
          
          beforeEach {
            expect(mockAppState.onboardingWasShown).to(beFalse())
            expect(mockCoordinatorFactory.callCountFor["makeTabBarCoordinator"])
              .to(equal(0))
            expect(sut.childCoordinators)
              .to(containElementSatisfying({
                ($0 as! SpyCoordinator).type == "OnboardingCoordinatorProtocol"
              }))
            
            (sut.childCoordinators.first! as! OnboardingCoordinatorProtocol)
              .onCompleteOnboarding!()
          }
          
          it("should set appState onboardingWasShown true") {
            expect(mockAppState.onboardingWasShown).to(beTrue())
          }
          
          it("should run start again which means runMainFlow") {
            expect(mockCoordinatorFactory.callCountFor["makeTabBarCoordinator"])
              .to(equal(1))
          }
          
          it("should remove OnboardingCoordinator from childs") {
            expect(sut.childCoordinators)
              .toNot(containElementSatisfying({
                ($0 as! SpyCoordinator).type == "OnboardingCoordinatorProtocol"
              }))
          }
        }
      }
      
      // MARK: - runMainFlow
      
      context("with both isAuthenticated and onboardingWasShown set true and username set") {
      
        beforeEach {
          mockAppState.isAuthenticated = true
          mockAppState.onboardingWasShown = true
          mockAppState.username = "nonempty"
          expect(sut.childCoordinators).to(haveCount(0))
          
          sut.start()
        }
        
        it("should call coordinatorFactory to makeTabBarCoordinator") {
          expect(mockCoordinatorFactory.callCountFor["makeTabBarCoordinator"])
            .to(equal(1))
        }
        
        it("should add as child a kind of TabBarCoordinatorProtocol") {
          expect(sut.childCoordinators).to(haveCount(1))
          expect(sut.childCoordinators.first!)
            .to(beAKindOf(TabBarCoordinatorProtocol.self))
        }

        it("should call start on child") {
          expect((sut.childCoordinators.first! as! SpyCoordinator).callCountFor["start"])
            .to(equal(1))
        }
      }
    }///AppCoordinator start
  }//spec
}
