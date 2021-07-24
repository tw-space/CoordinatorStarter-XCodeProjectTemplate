// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class AuthenticationCoordinatorSpec: QuickSpec {
  
  override func spec() {
    
    describe("AuthenticationCoordinator start") {
      
      // MARK: - Set Up Test Suite
      
      var rootNavController: UINavigationController!
      var spyRouter: SpyRouter!
      var spyControllerFactory: SpyControllerFactory!
      var sut: AuthenticationCoordinator!
      
      beforeEach {
        rootNavController = UINavigationController(nibName: nil, bundle: nil)
        spyRouter = SpyRouter(rootNavController: rootNavController)
        spyControllerFactory = SpyControllerFactory()
        sut = AuthenticationCoordinator(router: spyRouter,
                                        controllerFactory: spyControllerFactory)
        
        sut.start()
      }
      
      afterEach {
        rootNavController = nil
        spyRouter = nil
        sut = nil
        executeRunLoop()
      }
      
      // MARK: - start()
      
      it("should call makeSignInSignUpViewController on controllerFactory") {
        expect(spyControllerFactory.callCountFor["makeSignInSignUpViewController"])
          .to(equal(1))
      }
      
      it("should call router to setRootViewController") {
        expect(spyRouter.callCountFor["setRootViewController"]).to(equal(1))
      }
      
      it("should pass router setRootViewController a SignInSignUpViewController") {
        expect(spyRouter.setRootViewControllerViewControllerArgs.first!)
          .to(beAnInstanceOf(SignInSignUpViewController.self))
      }
      
      it("should pass router setRootViewController hideTopBar true") {
        expect(spyRouter.setRootViewControllerHideTopBarArgs.first)
          .to(beTrue())
      }
      
      // MARK: - SignInSignUpViewController
      
      describe("then calls to SISUVC") {
        
        var sisuvc: SignInSignUpViewController!
        var fakeTextField: UITextField!
        
        beforeEach {
          sisuvc = (spyRouter.setRootViewControllerViewControllerArgs.first!
                      as! SignInSignUpViewController)
          fakeTextField = UITextField()
        }
        
        afterEach {
          sisuvc = nil
          fakeTextField = nil
        }
        
        it("should set SISUVC onEditingChanged") {
          expect(sisuvc.onEditingChanged).toNot(beNil())
        }
        
        it("should set SISUVC onEditingDidBegin") {
          expect(sisuvc.onEditingDidBegin).toNot(beNil())
        }
        
        it("should set SISUVC onEditingDidBegin") {
          expect(sisuvc.onEditingDidBegin).toNot(beNil())
        }
        
        it("should set SISUVC onTappedContinueButton") {
          expect(sisuvc.onTappedContinueButton).toNot(beNil())
        }
        
        // MARK: - onEditingChanged
        
        describe("then SISUVC.onEditingChanged") {
          
          it("should set usernameText to UITextField sender text") {
            fakeTextField.text = "typing"
            
            sisuvc.onEditingChanged!(fakeTextField)
            
            expect(sut.usernameText).to(equal("typing"))
          }
        }
        
        // MARK: - onEditingDidBegin
        
        describe("then SISUVC.onEditingDidBegin") {
          
          var window: UIWindow!
          
          beforeEach {
            window = UIWindow()
            window.rootViewController = rootNavController
            rootNavController.viewControllers = [sisuvc]
            fakeTextField.placeholder = "placeholder"
            sisuvc.view.addSubview(fakeTextField)
            window.makeKeyAndVisible()
          }
          
          afterEach {
            window.resignKey()
            window = nil
          }
          
          context("when sender text field is first responder") {
            
            it("should clear sender placeholder") {
              fakeTextField.becomeFirstResponder()
              executeRunLoop()
              expect(fakeTextField.isFirstResponder).to(beTrue())
              
              sisuvc.onEditingDidBegin!(fakeTextField)
              
              expect(fakeTextField.placeholder).to(equal(""))
            }
          }
          
          context("when sender text field is Not first responder") {
            
            it("should not clear sender placeholder") {
              expect(fakeTextField.isFirstResponder).to(beFalse())
              
              sisuvc.onEditingDidBegin!(fakeTextField)
              
              expect(fakeTextField.placeholder).to(equal("placeholder"))
            }
          }
          
          // MARK: - onEditingDidEnd
          
          describe("then SISUVC.onEditingDidEnd") {
            
            context("when sender text field placeholder is empty") {
              
              it("should reset placeholder to usernamePlaceholder") {
                fakeTextField.placeholder = ""
                
                sisuvc.onEditingDidEnd!(fakeTextField)
                
                expect(fakeTextField.placeholder)
                  .to(equal(AuthenticationStrings.usernamePlaceholder))
              }
            }
            
            context("when sender text field placeholder is nonempty") {
              
              it("should not change placeholder") {
                fakeTextField.placeholder = "placeholder"
                
                sisuvc.onEditingDidEnd!(fakeTextField)
                
                expect(fakeTextField.placeholder).to(equal("placeholder"))
              }
            }
          }
          
          // MARK: - onTappedContinueButton
          
          describe("then SISUVC.onTappedContinueButton") {
            
            var callCount: Int!
            var passedInText: String?
            
            beforeEach {
              callCount = 0
              sut.onCompleteAuth = { text in
                callCount += 1
                passedInText = text
              }
            }
            
            afterEach {
              callCount = nil
              passedInText = nil
            }
            
            context("with nonempty usernameText") {
              
              it("should call onCompleteAuth with usernameText") {
                sut.usernameText = "SignedInUser"
                
                sisuvc.onTappedContinueButton!()
                
                expect(callCount).to(equal(1))
                expect(passedInText).to(equal("SignedInUser"))
              }
            }
            
            context("with empty usernameText") {
              
              it("should not call onCompleteAuth") {
                sut.usernameText = ""
                
                sisuvc.onTappedContinueButton!()
                
                expect(callCount).to(equal(0))
                expect(passedInText).to(beNil())
              }
            }

          }
        }
      }
    }///AuthenticationCoordinator start
  }//spec
}
