// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class ItemModelSpec: QuickSpec {
  
  override func spec() {
    
    describe("Item") {
      
      // MARK: - Init
      
      describe("init") {
        
        context("with title and subtitle") {
          
          it("should set title and subtitle") {
            let item = Item(title: "Mary", subtitle: "Had a little lamb")
            
            expect(item.title).to(equal("Mary"))
            expect(item.subtitle).to(equal("Had a little lamb"))
          }
        }
      }
    }
  }
}
