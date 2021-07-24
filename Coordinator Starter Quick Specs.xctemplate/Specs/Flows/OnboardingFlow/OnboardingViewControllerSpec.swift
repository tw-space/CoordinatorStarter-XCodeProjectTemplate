// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class OnboardingViewControllerSpec: QuickSpec {
  
  override func spec() {
    
    describe("OnboardingViewController") {
      
      // MARK: - Set Up Test Suite
      
      var sut: OnboardingViewController!
        
      beforeEach {
        sut = OnboardingViewController()
        _ = sut.view
      }
      
      afterEach {
        sut = nil
      }
      
      // MARK: - after load
      
      describe("after load") {
        
        it("should have a view of type OnboardingView") {
          expect(sut.view).to(beAnInstanceOf(OnboardingView.self))
        }
        
        it("should have a Continue button not nil") {
          expect(sut.vw.continueButton).toNot(beNil())
        }
        
        it("should have a target set on Continue button") {
          expect(sut.vw.continueButton.allTargets).toNot(beEmpty())
        }
      }
      
      // MARK: - tapping Continue button
      
      describe("tapping Continue button") {
        
        it("should call onCompleteOnboarding") {
          var tappedOnCompleteOnboarding = false
          sut.onCompleteOnboarding = {
            tappedOnCompleteOnboarding = true
          }
          
          tap(sut.vw.continueButton)
          
          expect(tappedOnCompleteOnboarding).to(beTrue())
        }
      }
    }
  }
}
