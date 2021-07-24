// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class SettingsListViewControllerSpec: QuickSpec {
  
  override func spec() {
    
    describe("SettingsListViewController") {
      
      // MARK: - Set Up Test Suite
      
      var sut: SettingsListViewController!
      
      afterEach { sut = nil}
      
      // MARK: - Init
      
      describe("init") {
        
        context("with nil username") {
          
          beforeEach {
            sut = SettingsListViewController(username: nil)
            _ = sut.view
          }
          
          it("should set view as SettingsListView") {
            expect(sut.view).to(beAnInstanceOf(SettingsListView.self))
          }
          
          it("should set view label text to Settings") {
            expect(sut.vw.mainLabel.text).to(equal("Settings"))
          }
        }
        
        context("with string username") {
          
          beforeEach {
            sut = SettingsListViewController(username: "TestUser")
            _ = sut.view
          }
          
          it("should set view label text to Welcome TestUser") {
            expect(sut.vw.mainLabel.text).to(equal("Welcome, TestUser"))
          }
        }
      }
    }
  }
}
