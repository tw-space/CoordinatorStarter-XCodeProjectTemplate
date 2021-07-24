// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class AppStateSpec: QuickSpec {
  
  override func spec() {
    
    describe("AppState") {
      
      // MARK: - Set Up Test Suite
      
      var testSuiteName: String!
      var testDefaults: UserDefaults!
      var sut: AppState!
        
      beforeEach {
        testSuiteName = "test"
        testDefaults = UserDefaults(suiteName: testSuiteName)
        testDefaults.removePersistentDomain(forName: testSuiteName)
        sut = AppState(defaults: testDefaults)
      }
      
      afterEach {
        testSuiteName = nil
        testDefaults = nil
        sut = nil
      }
      
      // MARK: - Initial Defaults
      
      describe("initial state") {
        
        it("should default isAuthenticated to false") {
          expect(sut.isAuthenticated).to(beFalse())
        }
        
        it("should default onboardingWasShown to false") {
          expect(sut.onboardingWasShown).to(beFalse())
        }
        
        it("should default username to nil") {
          expect(sut.username).to(beNil())
        }
      }
      
      // MARK: - State Variables
      
      describe("isAuthenticated") {
        
        it("should return true after setting true") {
          sut.isAuthenticated = true
          
          expect(sut.isAuthenticated).to(beTrue())
        }
        
        it("should return false after setting false") {
          sut.isAuthenticated = true
          sut.isAuthenticated = false
          
          expect(sut.isAuthenticated).to(beFalse())
        }
      }
      
      describe("onboardingWasShown") {
        
        it("should return true after setting true") {
          sut.onboardingWasShown = true
          
          expect(sut.onboardingWasShown).to(beTrue())
        }
        
        it("should return false after setting false") {
          sut.onboardingWasShown = true
          sut.onboardingWasShown = false
          
          expect(sut.onboardingWasShown).to(beFalse())
        }
      }
      
      describe("username") {
        
        it("should return string after setting string") {
          sut.username = "TestUser"
          
          expect(sut.username).to(equal("TestUser"))
        }
        
        it("should return nil after setting nil") {
          sut.username = "TestUser2"
          sut.username = nil
          
          expect(sut.username).to(beNil())
        }
      }
      
      // MARK: - Persistence
      
      context("without calling removePersistentDomain") {
        
        it("should persist state changes through reinstantiation") {
          sut.isAuthenticated = true
          sut.onboardingWasShown = true
          sut.username = "User1234"
          testDefaults = UserDefaults(suiteName: testSuiteName)
          sut = AppState(defaults: testDefaults)
          
          expect(sut.isAuthenticated).to(beTrue())
          expect(sut.onboardingWasShown).to(beTrue())
          expect(sut.username).to(equal("User1234"))
        }
      }
      
      // MARK: - reset()
      
      describe("reset") {
        
        it("should reset all state to defaults") {
          sut.isAuthenticated = true
          sut.onboardingWasShown = true
          sut.username = "User4321"
          
          sut.reset()
          
          expect(sut.isAuthenticated).to(beFalse())
          expect(sut.onboardingWasShown).to(beFalse())
          expect(sut.username).to(beNil())
        }
      }
    }
  }
}
