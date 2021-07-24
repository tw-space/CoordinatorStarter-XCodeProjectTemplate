// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class OnboardingCoordinatorSpec: QuickSpec {
  
  override func spec() {
    
    describe("OnboardingCoordinator") {
      
      // MARK: - Set Up Test Suite
      
      var spyRouter: SpyRouter!
      var spyControllerFactory: SpyControllerFactory!
      var sut: OnboardingCoordinator!
        
      beforeEach {
        let rootNavController = UINavigationController(nibName: nil, bundle: nil)
        spyControllerFactory = SpyControllerFactory()
        spyRouter = SpyRouter(rootNavController: rootNavController)
        sut = OnboardingCoordinator(router: spyRouter,
                                    controllerFactory: spyControllerFactory)
        
        sut.start()
      }
      
      afterEach {
        spyRouter = nil
        spyControllerFactory = nil
        sut = nil
      }
      
      describe("start") {
        
        // MARK: - showOnboarding
        
        describe("should showOnboarding, which") {
          
          it("should call makeOnboardingViewController on controllerFactory") {
            expect(spyControllerFactory.callCountFor["makeOnboardingViewController"])
              .to(equal(1))
          }
          
          it("should call setRootViewController on router") {
            expect(spyRouter.callCountFor["setRootViewController"]).to(equal(1))
          }
          
          it("should call setRootViewController with an OnboardingViewController") {
            expect(spyRouter.setRootViewControllerViewControllerArgs.first!)
              .to(beAnInstanceOf(OnboardingViewController.self))
          }
          
          it("should call setRootViewController with hideTopBar set true") {
            expect(spyRouter.setRootViewControllerHideTopBarArgs.first!)
              .to(beTrue())
          }
          
          it("should set onCompleteOnboarding to something in OnboardingViewController") {
            expect((spyRouter.rootNavController?.viewControllers.first!
                      as! OnboardingViewController).onCompleteOnboarding)
              .toNot(beNil())
          }
        }
        
        // MARK: - onCompleteOnboarding
        
        describe("OnboardingViewController onCompleteOnboarding") {
          
          it("should call sut onCompleteOnboarding") {
            let onboardingVC = (spyRouter.rootNavController?.viewControllers.first!
                                 as! OnboardingViewController)
            var calledSutOnCompleteOnboarding = false
            sut.onCompleteOnboarding = {
              calledSutOnCompleteOnboarding = true
            }
            
            onboardingVC.onCompleteOnboarding!()
            
            expect(calledSutOnCompleteOnboarding).to(beTrue())
          }
        }
      }///start
    }//OnboardingCoordinator
  }///spec
}
