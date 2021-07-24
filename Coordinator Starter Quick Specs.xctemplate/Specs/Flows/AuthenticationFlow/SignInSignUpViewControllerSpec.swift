// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class SignInSignUpViewControllerSpec: QuickSpec {
  
  override func spec() {
    
    describe("SignInSignUpViewController") {
      
      // MARK: - Set Up Test Suite
      
      var sut: SignInSignUpViewController!
        
      beforeEach {
        sut = SignInSignUpViewController()
        _ = sut.view
      }
      
      afterEach {
        sut = nil
      }
      
      // MARK: - after load, controller
      
      describe("after load, controller") {
        
        it("should set view as type SignInSignUpView") {
          expect(sut.view).to(beAnInstanceOf(SignInSignUpView.self))
        }
        
        it("should set action on vw.nameField for editingChanged") {
          expect(sut.vw.nameField.actions(forTarget: sut, forControlEvent: .editingChanged))
            .to(haveCount(1))
        }
        
        it("should set action on vw.nameField for editingDidBegin") {
          expect(sut.vw.nameField.actions(forTarget: sut, forControlEvent: .editingDidBegin))
            .to(haveCount(1))
        }
        
        it("should set action on vw.nameField for editingDidEnd") {
          expect(sut.vw.nameField.actions(forTarget: sut, forControlEvent: .editingDidEnd))
            .to(haveCount(1))
        }
        
        it("should set action on vw.continueButton for touchUpInside") {
          expect(sut.vw.continueButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
            .to(haveCount(1))
        }
        
        it("should add a gesture recognizer to the view") {
          expect(sut.view.gestureRecognizers).toNot(beEmpty())
        }
        
        it("should set cancelsTouchesInView false on gesture recognizer") {
          expect(sut.view.gestureRecognizers?.first!.cancelsTouchesInView)
            .to(beTrue())
        }
      }
      
      // MARK: - after load, view text
      
      describe("after load, view text") {
        
        it("should set continueButton text") {
          expect(sut.vw.continueButton.titleLabel?.text)
            .to(equal(AuthenticationStrings.continueButton))
        }
        
        it("should set nameField placeholder text") {
          expect(sut.vw.nameField.placeholder)
            .to(equal(AuthenticationStrings.usernamePlaceholder))
        }
        
        it("should set topLabel text") {
          expect(sut.vw.topLabel.text)
            .to(equal(AuthenticationStrings.topLabel))
        }
      }
      
      // MARK: - nameField
      
      describe("nameField") {
        
        context("when editingChanged") {
          
          it("should call onEditingChanged") {
            var calledOnEditingChanged = false
            sut.onEditingChanged = { _ in
              calledOnEditingChanged = true
            }
            
            sut.vw.nameField.sendActions(for: .editingChanged)
            
            expect(calledOnEditingChanged).to(beTrue())
          }
          
          it("should call onEditingChanged with nameField sender") {
            var onEditingChangedSenderArg: UITextField?
            sut.onEditingChanged = { sender in
              onEditingChangedSenderArg = sender
            }
            
            sut.vw.nameField.sendActions(for: .editingChanged)
            
            expect(onEditingChangedSenderArg).to(beIdenticalTo(sut.vw.nameField))
          }
        }
        
        context("when editingDidBegin") {
          
          it("should call onEditingDidBegin") {
            var calledOnEditingDidBegin = false
            sut.onEditingDidBegin = { _ in
              calledOnEditingDidBegin = true
            }
            
            sut.vw.nameField.sendActions(for: .editingDidBegin)
            
            expect(calledOnEditingDidBegin).to(beTrue())
          }
          
          it("should call onEditingDidBegin with nameField sender") {
            var onEditingDidBeginSenderArg: UITextField?
            sut.onEditingDidBegin = { sender in
              onEditingDidBeginSenderArg = sender
            }
            
            sut.vw.nameField.sendActions(for: .editingDidBegin)
            
            expect(onEditingDidBeginSenderArg).to(beIdenticalTo(sut.vw.nameField))
          }
        }
        
        context("when editingDidEnd") {
          
          it("should call onEditingDidEnd") {
            var calledOnEditingDidEnd = false
            sut.onEditingDidEnd = { _ in
              calledOnEditingDidEnd = true
            }
            
            sut.vw.nameField.sendActions(for: .editingDidEnd)
            
            expect(calledOnEditingDidEnd).to(beTrue())
          }
          
          it("should call onEditingDidEnd with nameField sender") {
            var onEditingDidEndSenderArg: UITextField?
            sut.onEditingDidEnd = { sender in
              onEditingDidEndSenderArg = sender
            }
            
            sut.vw.nameField.sendActions(for: .editingDidEnd)
            
            expect(onEditingDidEndSenderArg).to(beIdenticalTo(sut.vw.nameField))
          }
        }
      }
      
      // MARK: - continueButton
      
      describe("continueButton") {
        
        context("when tapped") {
          
          it("should call onTappedContinueButton") {
            var calledOnTappedContinueButton = false
            sut.onTappedContinueButton = {
              calledOnTappedContinueButton = true
            }
            
            sut.vw.continueButton.sendActions(for: .touchUpInside)
            
            expect(calledOnTappedContinueButton).to(beTrue())
          }
        }
      }///continueButton
    }//SignInSignUpViewController
  }///spec
}
