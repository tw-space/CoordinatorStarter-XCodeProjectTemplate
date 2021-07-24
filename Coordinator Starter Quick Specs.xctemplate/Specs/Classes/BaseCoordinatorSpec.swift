// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class BaseCoordinatorSpec: QuickSpec {
  
  override func spec() {
    
    describe("BaseCoordinator") {
      
      // MARK: - Set Up Test Suite
      
      var sut: BaseCoordinator!
        
      beforeEach {
        sut = BaseCoordinator()
      }
      
      afterEach {
        sut = nil
      }
      
      // MARK: - Initial State
      
      describe("after init") {
        
        it("should have empty childCoordinators") {
          expect(sut.childCoordinators).to(beEmpty())
        }
        
        it("should not have directly settable childCoordinators") {
          // let blueCoordinator = BaseCoordinator()
          // sut.childCoordinators.append(blueCoordinator)  // expected: does not compile
        }
      }
      
      // MARK: - start()
      
      describe("start") {
        
        it("should do nothing") {
          sut.start()
          
          expect(sut.childCoordinators).to(beEmpty())
        }
      }
      
      // MARK: - addChildCoordinator()
      
      describe("addChildCoordinator") {
        
        var blueCoordinator: BaseCoordinator!
        
        beforeEach {
          blueCoordinator = BaseCoordinator()
          
          sut.addChildCoordinator(blueCoordinator)
        }
        
        context("with new BaseCoordinator when childs is empty") {
          
          it("should add it to childCoordinators") {
            expect(sut.childCoordinators)
              .to(containElementSatisfying({ $0 === blueCoordinator}))
            expect(sut.childCoordinators).to(haveCount(1))
          }
        }
        
        context("with a coordinator that is already a child") {
          
          it("should not add it again") {
            sut.addChildCoordinator(blueCoordinator)
            
            expect(sut.childCoordinators)
              .to(containElementSatisfying({ $0 === blueCoordinator}))
            expect(sut.childCoordinators).to(haveCount(1))
          }
        }
        
        context("with self as argument") {
          
          it("should not add self as child") {
            sut.addChildCoordinator(sut)
            
            expect(sut.childCoordinators).to(haveCount(1))
            expect(sut.childCoordinators)
              .toNot(containElementSatisfying({ $0 === sut }))
          }
        }
        
        context("with a second unique coordinator") {
          
          it("should add it as a second child") {
            let greenCoordinator = BaseCoordinator()
            
            sut.addChildCoordinator(greenCoordinator)
            
            expect(sut.childCoordinators)
              .to(containElementSatisfying({ $0 === blueCoordinator}))
            expect(sut.childCoordinators)
              .to(containElementSatisfying({ $0 === greenCoordinator}))
            expect(sut.childCoordinators).to(haveCount(2))
          }
        }
        
        context("with a coordinator that itself has two children") {
          
          it("should only add the parent coordinator as a direct child") {
            let greenCoordinator = BaseCoordinator()
            let purpleCoordinator = BaseCoordinator()
            let orangeCoordinator = BaseCoordinator()
            greenCoordinator.addChildCoordinator(purpleCoordinator)
            greenCoordinator.addChildCoordinator(orangeCoordinator)
            
            sut.addChildCoordinator(greenCoordinator)
            
            expect(sut.childCoordinators).to(haveCount(2))
            expect(sut.childCoordinators)
              .to(containElementSatisfying({ $0 === greenCoordinator }))
            expect(sut.childCoordinators)
              .toNot(containElementSatisfying({ $0 === purpleCoordinator }))
            expect(sut.childCoordinators)
              .toNot(containElementSatisfying({ $0 === orangeCoordinator }))
            expect(greenCoordinator.childCoordinators)
              .to(containElementSatisfying({ $0 === purpleCoordinator }))
            expect(greenCoordinator.childCoordinators)
              .to(containElementSatisfying({ $0 === orangeCoordinator }))
          }
        }
      }
      
      // MARK: - removeChildCoordinator()
      
      describe("removeChildCoordinator") {
        
        context("with empty childs and nil argument") {
          
          it("should do nothing and throw no errors") {
            expect(sut.childCoordinators).to(beEmpty())
            
            expect { sut.removeChildCoordinator(nil) }.toNot(throwError())
            expect { sut.removeChildCoordinator(nil) }.toNot(throwAssertion())
            expect(sut.childCoordinators).to(beEmpty())
          }
        }
        
        context("with empty childs and new coordinator argument") {
          
          it("should do nothing and throw no errors") {
            let blueCoordinator = BaseCoordinator()
            expect(sut.childCoordinators).to(beEmpty())
            
            expect { sut.removeChildCoordinator(blueCoordinator) }.toNot(throwError())
            expect { sut.removeChildCoordinator(blueCoordinator) }.toNot(throwAssertion())
            
            expect(sut.childCoordinators).to(beEmpty())
          }
        }
        
        context("with one child and different coordinator argument") {
          
          it("should do nothing and throw no errors") {
            let blueCoordinator = BaseCoordinator()
            let greenCoordinator = BaseCoordinator()
            sut.addChildCoordinator(blueCoordinator)
            expect(sut.childCoordinators).to(haveCount(1))
            
            expect { sut.removeChildCoordinator(greenCoordinator) }.toNot(throwError())
            expect { sut.removeChildCoordinator(greenCoordinator) }.toNot(throwAssertion())
            
            expect(sut.childCoordinators).to(haveCount(1))
          }
        }
        
        context("with one child and that coordinator as argument") {
          
          it("should remove that child") {
            let blueCoordinator = BaseCoordinator()
            sut.addChildCoordinator(blueCoordinator)
            expect(sut.childCoordinators).to(haveCount(1))
            expect(sut.childCoordinators)
              .to(containElementSatisfying({ $0 === blueCoordinator }))
            
            sut.removeChildCoordinator(blueCoordinator)
            
            expect(sut.childCoordinators).to(haveCount(0))
            expect(sut.childCoordinators)
              .toNot(containElementSatisfying({ $0 === blueCoordinator }))
          }
        }
        
        context("with two childs and first coordinator as argument") {
          
          it("should remove the first child") {
            let blueCoordinator = BaseCoordinator()
            let greenCoordinator = BaseCoordinator()
            sut.addChildCoordinator(blueCoordinator)
            sut.addChildCoordinator(greenCoordinator)
            expect(sut.childCoordinators).to(haveCount(2))
            expect(sut.childCoordinators)
              .to(containElementSatisfying({ $0 === blueCoordinator }))
            expect(sut.childCoordinators)
              .to(containElementSatisfying({ $0 === greenCoordinator }))
            
            sut.removeChildCoordinator(blueCoordinator)
            
            expect(sut.childCoordinators).to(haveCount(1))
            expect(sut.childCoordinators)
              .toNot(containElementSatisfying({ $0 === blueCoordinator }))
            expect(sut.childCoordinators)
              .to(containElementSatisfying({ $0 === greenCoordinator }))
          }
        }
        
        context("with child that has child (grandchild) that also has child (great-grandchild)") {
          
          it("should remove great-grandchild from grandchild, grandchild from child, and child from top") {
            let topCoordinator = BaseCoordinator()
            let childCoordinator = BaseCoordinator()
            let grandChildCoordinator = BaseCoordinator()
            let greatGrandChildCoordinator = BaseCoordinator()
            grandChildCoordinator.addChildCoordinator(greatGrandChildCoordinator)
            childCoordinator.addChildCoordinator(grandChildCoordinator)
            topCoordinator.addChildCoordinator(childCoordinator)
            sut.addChildCoordinator(topCoordinator)
            
            sut.removeChildCoordinator(topCoordinator)
            
            expect(sut.childCoordinators).to(beEmpty())
            expect(topCoordinator.childCoordinators).to(beEmpty())
            expect(childCoordinator.childCoordinators).to(beEmpty())
            expect(grandChildCoordinator.childCoordinators).to(beEmpty())
          }
        }
      }
    }///BaseCoordinator
  }//spec
}
