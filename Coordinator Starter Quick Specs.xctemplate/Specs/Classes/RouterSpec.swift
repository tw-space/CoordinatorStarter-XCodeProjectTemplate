// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

class RouterSpec: QuickSpec {
  
  override func spec() {
    
    describe("Router") {
      
      // MARK: - Set Up Test Suite
      
      var rootNavController: UINavigationController!
      var vcBlue: UIViewController!
      var vcGreen: UIViewController!
      var sut: Router!
      
      beforeEach {
        rootNavController = UINavigationController(nibName: nil, bundle: nil)
        vcBlue = UIViewController()
        vcGreen = UIViewController()
        sut = Router(rootNavController: rootNavController)
      }
      
      afterEach {
        rootNavController = nil
        vcBlue = nil
        vcGreen = nil
        sut = nil
        executeRunLoop()
      }
      
      // MARK: - Initial State
      
      describe("after init") {
        
        it("rootNavController should not be nil") {
          expect(sut.rootNavController).toNot(beNil())
        }
        
        it("completions should be empty") {
          expect(sut.completions).to(beEmpty())
        }
      }
      
      // MARK: - setRootViewController()
      
      describe("setRootViewController") {
        
        context("with dummy view controller") {
          
          beforeEach { sut.setRootViewController(vcBlue) }
          
          it("should set rootNavController's vc stack to only that vc") {
            expect(sut.rootNavController?.viewControllers).to(equal([vcBlue]))
          }
          
          it("should hide navbar in rootNavController") {
            expect(sut.rootNavController?.isNavigationBarHidden).to(beFalse())
          }
        }
        
        context("with hideTopBar set true") {
          
          it("should hide navbar in rootNavController") {
            sut.setRootViewController(vcBlue, hideTopBar: true)
            
            expect(sut.rootNavController?.isNavigationBarHidden).to(beTrue())
          }
        }
        
        context("with hideTopBar set false") {
          
          it("should show navbar in rootNavController") {
            sut.setRootViewController(vcBlue, hideTopBar: false)
            
            expect(sut.rootNavController?.isNavigationBarHidden).to(beFalse())
          }
        }
        
        context("with animated set true or false") {
          
          it("should not throw compiler errors") {
            sut.setRootViewController(vcBlue, animated: true)
            sut.setRootViewController(vcBlue, animated: false)
          }
        }
        
        context("with both hideTopBar and animated set") {
          
          it("should hide navbar in rootNavController when true") {
            sut.setRootViewController(vcBlue, hideTopBar: true, animated: true)
            
            expect(sut.rootNavController?.isNavigationBarHidden).to(beTrue())
          }
          
          it("should show navbar in rootNavController when false") {
            sut.setRootViewController(vcBlue, hideTopBar: false, animated: false)
            
            expect(sut.rootNavController?.isNavigationBarHidden).to(beFalse())
          }
        }
      }
      
      // MARK: - push()
      
      describe("push") {
        
        var vcTabBar: UITabBarController!
        
        beforeEach {
          vcTabBar = UITabBarController()
        }
        
        afterEach {
          vcTabBar = nil
        }
        
        context("without first setting root vc") {
          
          it("should set rootNavController vc stack to only that vc") {
            expect(sut.rootNavController?.viewControllers).to(beEmpty(), description: "pre")
            
            sut.push(vcBlue)
            
            expect(sut.rootNavController?.viewControllers).to(equal([vcBlue]))
          }
        }
        
        context("after setting root vc") {
          
          it("should set rootNavController vc stack to those two vcs") {
            sut.setRootViewController(vcBlue)
            expect(sut.rootNavController?.viewControllers)
              .to(equal([vcBlue]), description: "pre")
            
            sut.push(vcGreen)
            executeRunLoop()
            
            expect(sut.rootNavController?.viewControllers)
              .to(equal([vcBlue, vcGreen]))
          }
        }
        
        context("a navigation controller") {
          
          it("should throw assertion") {
            expect { sut.push(UINavigationController()) }.to(throwAssertion())
          }
        }
        
        context("with just a vc") {
          
          it("should not hide bottom bar") {
            vcTabBar.viewControllers = [rootNavController]
            sut.setRootViewController(vcBlue)
            
            sut.push(vcGreen)
            executeRunLoop()
            
            expect(vcTabBar.tabBar.isHidden).to(beFalse())
          }
          
          it("should keep completions empty") {
            sut.push(vcGreen)
            executeRunLoop()
            
            expect(sut.completions).to(beEmpty())
          }
        }
        
        context("with animated set true or false") {
          
          it("should not throw compiler errors") {
            sut.push(vcBlue, animated: true)
            sut.push(vcGreen, animated: false)
          }
          
          it("should not hide bottom bar") {
            vcTabBar.viewControllers = [rootNavController]
            sut.setRootViewController(vcBlue)
            
            sut.push(vcGreen, animated: true)
            executeRunLoop()
            
            expect(vcTabBar.tabBar.isHidden).to(beFalse())
          }
          
          it("should keep completions empty") {
            sut.push(vcGreen, animated: false)
            executeRunLoop()
            
            expect(sut.completions).to(beEmpty())
          }
        }
        
        context("with hideBottomBar set true") {
          
          it("should hide bottom bar") {
            vcTabBar.viewControllers = [rootNavController]
            sut.setRootViewController(vcBlue)
            
            sut.push(vcGreen, hideBottomBar: true)
            executeRunLoop()
            
            expect(vcTabBar.tabBar.isHidden).to(beTrue())
          }
          
          it("should keep completions empty") {
            sut.push(vcGreen, hideBottomBar: true)
            executeRunLoop()
            
            expect(sut.completions).to(beEmpty())
          }
        }
        
        context("with hideBottomBar set false") {
          
          it("should keep showing bottom bar") {
            vcTabBar.viewControllers = [rootNavController]
            sut.setRootViewController(vcBlue)
            
            sut.push(vcGreen, hideBottomBar: false)
            executeRunLoop()
            
            expect(vcTabBar.tabBar.isHidden).to(beFalse())
          }
          
          it("should keep completions empty") {
            sut.push(vcGreen, hideBottomBar: false)
            executeRunLoop()
            
            expect(sut.completions).to(beEmpty())
          }
        }
        
        context("with a completion closure") {
          
          it("should add closure to completions") {
            sut.push(vcBlue, completion: { print(">> vcBlue completed!") })
            
            expect(sut.completions.count).to(equal(1))
          }
          
          it("should keep showing bottom bar") {
            vcTabBar.viewControllers = [rootNavController]
            sut.setRootViewController(vcBlue)
            
            sut.push(vcGreen, completion: { print(">> vcGreen completed!") })
            executeRunLoop()
            
            expect(vcTabBar.tabBar.isHidden).to(beFalse())
          }
        }
        
        context("with all parameters truthy") {
          
          it("should hide bottom bar and add to completions") {
            vcTabBar.viewControllers = [rootNavController]
            sut.setRootViewController(vcBlue)
            
            sut.push(vcGreen,
                     animated: true,
                     hideBottomBar: true,
                     completion: { print(">> vcGreen completed!") })
            executeRunLoop()
            
            expect(vcTabBar.tabBar.isHidden).to(beTrue())
            expect(sut.completions.count).to(equal(1))
          }
        }
        
        context("with animated and hideBottomBar set false and a completion") {
          
          it("should keep showing bottom bar and add to completions") {
            vcTabBar.viewControllers = [rootNavController]
            sut.setRootViewController(vcBlue)
            
            sut.push(vcGreen,
                     animated: false,
                     hideBottomBar: false,
                     completion: { print(">> vcGreen completed!") })
            executeRunLoop()
            
            expect(vcTabBar.tabBar.isHidden).to(beFalse())
            expect(sut.completions.count).to(equal(1))
          }
        }
      }
      
      // MARK: - popViewController()
      
      describe("popViewController") {
        
        context("with zero vc in nav stack") {
          
          it("should keep stack empty") {
            expect(sut.rootNavController?.viewControllers).to(beEmpty())
            
            sut.popViewController()
            executeRunLoop()
            
            expect(sut.rootNavController?.viewControllers).to(beEmpty())
          }
        }
        
        context("with one vc in nav stack") {
          
          it("should keep that vc in stack") {
            sut.setRootViewController(vcBlue)
            expect(sut.rootNavController?.viewControllers).to(equal([vcBlue]))
            
            sut.popViewController()
            executeRunLoop()
            
            expect(sut.rootNavController?.viewControllers).to(equal([vcBlue]))
          }
        }
        
        context("with two vcs in nav stack") {
          
          it("should leave only first vc in stack") {
            sut.setRootViewController(vcBlue)
            sut.push(vcGreen)
            executeRunLoop()
            expect(sut.rootNavController?.viewControllers).to(equal([vcBlue, vcGreen]))
            
            sut.popViewController()
            executeRunLoop()
            
            expect(sut.rootNavController?.viewControllers).to(equal([vcBlue]))
          }
        }
        
        context("with completions set for second and third vc") {
          
          it("should run those completions in order") {
            let vcOrange = UIViewController()
            var message: String?
            sut.setRootViewController(vcBlue)
            sut.push(vcGreen, completion: { message = "vcGreen completed!" })
            executeRunLoop()
            sut.push(vcOrange, completion: { message = "vcOrange completed!" })
            executeRunLoop()
            expect(sut.rootNavController?.viewControllers)
              .to(equal([vcBlue, vcGreen, vcOrange]))
            expect(sut.completions.count).to(equal(2))
            expect(message).to(beNil())
            
            sut.popViewController()
            executeRunLoop()
            
            expect(sut.rootNavController?.viewControllers).to(equal([vcBlue, vcGreen]))
            expect(message).to(equal("vcOrange completed!"))
            
            sut.popViewController()
            executeRunLoop()
            
            expect(sut.rootNavController?.viewControllers).to(equal([vcBlue]))
            expect(message).to(equal("vcGreen completed!"))
          }
        }
        
        context("with animated set true or false") {
          
          it("should not throw compiler errors") {
            sut.popViewController(animated: true)
            sut.popViewController(animated: false)
          }
        }
      }
      
      // MARK: - present()
      
      describe("present") {
        
        var window: UIWindow!
        
        beforeEach {
          window = UIWindow()
          window.rootViewController = rootNavController
          window.makeKeyAndVisible()
        }
        
        afterEach {
          window.resignKey()
          window = nil
        }
        
        context("with zero vcs in nav stack") {
          
          it("should keep nav stack empty") {
            sut.present(vcBlue)
            
            expect(sut.rootNavController?.viewControllers).to(beEmpty())
          }
        }
        
        context("with one vc in nav stack and animated set true") {
          
          it("should present second vc modally") {
            sut.setRootViewController(vcBlue)
            expect(vcGreen.presentingViewController).to(beNil())
            expect(vcBlue.presentedViewController).to(beNil())
            expect(rootNavController.presentedViewController).to(beNil())
            
            sut.present(vcGreen, animated: true)
            
            expect(vcGreen.presentingViewController).to(be(rootNavController))
            expect(vcBlue.presentedViewController).to(be(vcGreen))
            expect(rootNavController.presentedViewController).to(be(vcGreen))
          }
        }
        
        context("with one vc in nav stack and animated set false") {
          
          it("should present second vc modally") {
            sut.setRootViewController(vcBlue)
            expect(vcGreen.presentingViewController).to(beNil())
            expect(vcBlue.presentedViewController).to(beNil())
            expect(rootNavController.presentedViewController).to(beNil())
            
            sut.present(vcGreen, animated: false)
            
            expect(vcGreen.presentingViewController).to(be(rootNavController))
            expect(vcBlue.presentedViewController).to(be(vcGreen))
            expect(rootNavController.presentedViewController).to(be(vcGreen))
          }
        }
        
        context("with completion set") {
          
          it("should run completion eventually when presented") {
            var message: String?
            sut.setRootViewController(vcBlue)
            
            sut.present(vcGreen) { message = "vcGreen completed!" }
            vcGreen.viewDidAppear(false)
            executeRunLoop()
            
            expect(message).toEventually(equal("vcGreen completed!"))
          }
          
          context("with animated set false also") {
            
            it("should run completion eventually when presented") {
              var message: String?
              sut.setRootViewController(vcBlue)
              
              sut.present(vcGreen, animated: false) { message = "vcGreen completed!" }
              vcGreen.viewDidAppear(false)
              executeRunLoop()
              
              expect(message).toEventually(equal("vcGreen completed!"))
            }
          }
        }
      }
      
      // MARK: - dismissViewController()
      
      describe("dismissViewController") {
        
        var window: UIWindow!
        
        beforeEach {
          window = UIWindow()
          window.rootViewController = rootNavController
          window.makeKeyAndVisible()
        }
        
        afterEach {
          window.resignKey()
          window = nil
        }
        
        context("with no presented view controllers") {
          
          it("should change the nil presented view controller") {
            expect(sut.rootNavController?.presentedViewController).to(beNil())
            
            sut.dismissViewController()
            
            expect(sut.rootNavController?.presentedViewController).to(beNil())
          }
        }
        
        context("with one presented vc") {
          
          beforeEach {
            sut.setRootViewController(vcBlue)
            sut.present(vcGreen)
            expect(sut.rootNavController?.presentedViewController).to(be(vcGreen))
            expect(vcGreen.presentingViewController).to(be(rootNavController))
          }
          
          it("should make nil the presented vc") {
            sut.dismissViewController()
            executeRunLoop()
            
            expect(sut.rootNavController?.presentedViewController).toEventually(beNil())
            expect(vcGreen.presentingViewController).toEventually(beNil())
          }
          
          context("with animated set true and completion set") {
            
            it("should run completion eventually and nil presented") {
              var message: String?
              
              sut.dismissViewController(animated: true,
                                        completion: { message = "vcGreen dismissed!" })
              executeRunLoop()
              
              expect(message).toEventually(equal("vcGreen dismissed!"))
              expect(sut.rootNavController?.presentedViewController).toEventually(beNil())
              expect(vcGreen.presentingViewController).toEventually(beNil())
            }
          }
          
          context("with animated set false") {
            
            it("should make nil the presented vc") {
              sut.dismissViewController(animated: false)
              executeRunLoop()
              
              expect(sut.rootNavController?.presentedViewController).toEventually(beNil())
              expect(vcGreen.presentingViewController).toEventually(beNil())
            }
          }
        }
      }
      
      // MARK: - popToRootViewController()
      
      describe("popToRootViewController") {
        
        context("with no root view controller") {
          
          it("should keep nav stack empty") {
            expect(sut.rootNavController?.viewControllers).to(beEmpty())
            
            sut.popToRootViewController(animated: true)
            
            expect(sut.rootNavController?.viewControllers).to(beEmpty())
          }
        }
        
        context("with set root view controller only") {
          
          it("should keep only that vc in nav stack") {
            sut.setRootViewController(vcBlue)
            expect(sut.rootNavController?.viewControllers).to(equal([vcBlue]))
            
            sut.popToRootViewController(animated: false)
            
            expect(sut.rootNavController?.viewControllers).to(equal([vcBlue]))
          }
        }
        
        context("with three vcs in nav stack") {
          
          it("should leave nav stack with only first vc") {
            let vcOrange = UIViewController()
            sut.setRootViewController(vcBlue)
            sut.push(vcGreen, animated: false)
            sut.push(vcOrange, animated: false)
            executeRunLoop()
            expect(sut.rootNavController?.viewControllers)
              .to(equal([vcBlue, vcGreen, vcOrange]))
            
            sut.popToRootViewController(animated: false)
            
            expect(sut.rootNavController?.viewControllers).to(equal([vcBlue]))
          }
          
          context("with completions for the pushed two") {
            
            it("should run those completions") {
              var greenComplete = false
              var orangeComplete = false
              let vcOrange = UIViewController()
              sut.setRootViewController(vcBlue)
              sut.push(vcGreen, animated: false, completion: { greenComplete = true })
              sut.push(vcOrange, animated: false, completion: { orangeComplete = true })
              executeRunLoop()
              expect(sut.rootNavController?.viewControllers)
                .to(equal([vcBlue, vcGreen, vcOrange]))
              expect(sut.completions.count).to(equal(2))
              
              sut.popToRootViewController(animated: false)
              executeRunLoop()
              
              expect(greenComplete).toEventually(beTrue())
              expect(orangeComplete).toEventually(beTrue())
              expect(sut.completions).toEventually(beEmpty())
            }
          }
        }
      }
    }///Router
  }//spec
}
