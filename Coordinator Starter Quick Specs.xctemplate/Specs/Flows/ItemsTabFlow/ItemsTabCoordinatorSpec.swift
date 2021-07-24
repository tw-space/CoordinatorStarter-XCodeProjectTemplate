// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import Nimble
import Quick
import UIKit

final class ItemsTabCoordinatorSpec: QuickSpec {
  
  override func spec() {
    
    describe("ItemsTabCoordinator") {
      
      // MARK: - Set Up Test Suite
      
      var rootNavController: UINavigationController!
      var spyRouter: SpyRouter!
      var spyControllerFactory: SpyControllerFactory!
      var mockCoordinatorFactory: MockCoordinatorFactory!
      var mockItemsStore: MockItemsStore!
      var sut: ItemsTabCoordinator!
      
      beforeEach {
        rootNavController = UINavigationController(nibName: nil, bundle: nil)
        spyRouter = SpyRouter(rootNavController: rootNavController)
        spyControllerFactory = SpyControllerFactory()
        mockCoordinatorFactory = MockCoordinatorFactory()
        mockItemsStore = MockItemsStore()
        sut = ItemsTabCoordinator(
          router: spyRouter,
          controllerFactory: spyControllerFactory,
          coordinatorFactory: mockCoordinatorFactory,
          itemsStore: mockItemsStore
        )
        
        sut.start()
      }
      
      afterEach {
        rootNavController = nil
        spyRouter = nil
        spyControllerFactory = nil
        mockCoordinatorFactory = nil
        mockItemsStore = nil
        sut = nil
      }
      
      // MARK: - start
      
      describe("start") {
        
        describe("should showItemsList, which") {
          
          it("should call setRootViewController on router") {
            expect(spyRouter.callCountFor["setRootViewController"]).to(equal(1))
          }
          
          it("should call setRootViewController with an ItemsListViewController") {
            expect(spyRouter.setRootViewControllerViewControllerArgs).to(haveCount(1))
            expect(spyRouter.setRootViewControllerViewControllerArgs.first!)
              .to(beAnInstanceOf(ItemsListViewController.self))
          }
          
          describe("initializes an ItemListViewController, which") {
            
            var itemsListVC: ItemsListViewController!
            
            beforeEach {
              itemsListVC =
                (spyRouter.setRootViewControllerViewControllerArgs.first!
                  as! ItemsListViewController)
            }
            
            afterEach {
              itemsListVC = nil
            }
            
            it("should set items to load ItemsStore when nonempty") {
              let mockItems = mockItemsStore.getAll()
              expect(mockItems).to(beAKindOf([Item].self))
              expect(mockItems).toNot(beEmpty())
              
              expect(itemsListVC.items).to(equal(mockItems))
            }
            
            it("should set onItemSelect to not nil") {
              expect(itemsListVC.onItemSelect).toNot(beNil())
            }
            
            it("should set onCreateItem to not nil") {
              expect(itemsListVC.onCreateItem).toNot(beNil())
            }
            
            it("should set onTapReset to not nil") {
              expect(itemsListVC.onTapReset).toNot(beNil())
            }
          }
        }
      }
      
      // MARK: - ItemsListViewController
      
      describe("itemsListViewController") {
        
        var itemsListVC: ItemsListViewController!
        var item: Item!
        
        beforeEach {
          itemsListVC =
            (spyRouter.setRootViewControllerViewControllerArgs.first!
              as! ItemsListViewController)
          item = Item(title: "Title", subtitle: "Subtitle")
        }
        
        afterEach {
          itemsListVC = nil
          item = nil
        }
        
        // MARK: - onItemSelect
        
        describe("onItemSelect, which runs showItemDetail on an Item") {
          
          beforeEach { itemsListVC.onItemSelect!(item) }
          
          it("should call makeItemDetailViewController on controllerFactory") {
            expect(spyControllerFactory.callCountFor["makeItemDetailViewController"])
              .to(equal(1))
          }
          
          it("should call makeItemDetailViewController with an Item") {
            expect(spyControllerFactory.makeItemDetailViewControllerItemArgs)
              .to(haveCount(1))
            expect(spyControllerFactory.makeItemDetailViewControllerItemArgs.first!)
              .to(beAKindOf(Item.self))
          }
          
          it("should call push on router") {
            expect(spyRouter.callCountFor["push"]).to(equal(1))
          }
          
          it("should call push with an ItemDetailViewController") {
            expect(spyRouter.pushViewControllerArgs).to(haveCount(1))
            expect(spyRouter.pushViewControllerArgs.first!)
              .to(beAnInstanceOf(ItemDetailViewController.self))
          }
        }
        
        // MARK: - onCreateItem
        
        describe("onCreateItem, which runs runItemCreateFlow") {
          
          var lastChildCoordinator: CoordinatorProtocol!
          var preChildCount: Int!
          
          beforeEach {
            preChildCount = sut.childCoordinators.count
            
            itemsListVC.onCreateItem!()
            lastChildCoordinator = sut.childCoordinators.last!
          }
          
          afterEach {
            lastChildCoordinator = nil
            preChildCount = nil
          }
          
          it("should call makeItemCreateCoordinator on coordinatorFactory") {
            expect(mockCoordinatorFactory.callCountFor["makeItemCreateCoordinator"])
              .to(equal(1))
          }
          
          it("should call makeItemCreateCoordinator with a router") {
            expect(mockCoordinatorFactory.makeItemCreateCoordinatorRouterArgs.first!)
              .to(beAnInstanceOf(Router.self))
          }
          
          it("should add a child coordinator") {
            expect(sut.childCoordinators).to(haveCount(preChildCount + 1))
          }
          
          it("should add an ItemCreateCoordinatorProtocol as child") {
            expect((lastChildCoordinator as! SpyCoordinator).type)
              .to(equal("ItemCreateCoordinatorProtocol"))
          }
          
          it("should set flowDidComplete on the ItemCreateCoordinatorProtocol to something") {
            expect((lastChildCoordinator as! ItemCreateCoordinatorProtocol).flowDidComplete)
              .toNot(beNil())
          }
          
          it("should call present on router") {
            expect(spyRouter.callCountFor["present"]).to(equal(1))
          }
          
          it("should call present with a Router") {
            expect(spyRouter.presentViewControllerArgs).to(haveCount(1))
            expect(spyRouter.presentViewControllerArgs.last!)
              .to(beAnInstanceOf(Router.self))
          }
          
          it("should call start on the ItemCreateCoordinator") {
            expect((lastChildCoordinator as? SpyCoordinator)?.callCountFor["start"])
              .to(equal(1))
          }
          
          // MARK: - flowDidComplete
          
          describe("then flowDidComplete") {

            context("with an Item") {

              it("should call dismissViewController on router") {
                (lastChildCoordinator as! ItemCreateCoordinatorProtocol).flowDidComplete!(item)
                
                expect(spyRouter.callCountFor["dismissViewController"]).to(equal(1))
              }

              it("should remove child ItemCreateCoordinator") {
                expect(sut.childCoordinators).to(containElementSatisfying({
                  ($0 as? SpyCoordinator)?.type == "ItemCreateCoordinatorProtocol"
                }))
                
                (lastChildCoordinator as! ItemCreateCoordinatorProtocol).flowDidComplete!(item)
                
                expect(sut.childCoordinators).to(beEmpty())
              }

              it("should add the Item to the ItemStore") {
                var mockItems = mockItemsStore.getAll()
                expect(mockItems).toNot(contain(item))
                
                (lastChildCoordinator as! ItemCreateCoordinatorProtocol).flowDidComplete!(item)
                
                mockItems = mockItemsStore.getAll()
                expect(mockItems).to(contain(item))
              }

              describe("should call refreshItemsList, which") {

                it("should update items on ItemsListViewController") {
                  (lastChildCoordinator as! ItemCreateCoordinatorProtocol).flowDidComplete!(item)
                  
                  expect(itemsListVC.items).to(contain(item))
                }
                
                xit("should call reloadData on tableView") {
                  // (P3) spy tableView reloadData would require excessive mocking
                }
              }

              describe("should call showItemDetail, which") {

                it("should call makeItemDetailViewController on controllerFactory") {
                  let preCallCount = spyControllerFactory.callCountFor["makeItemDetailViewController"]!
                  
                  (lastChildCoordinator as! ItemCreateCoordinatorProtocol).flowDidComplete!(item)
                  
                  expect(spyControllerFactory.callCountFor["makeItemDetailViewController"])
                    .to(equal(preCallCount + 1))
                }

                it("should call makeItemDetailViewController with an item") {
                  (lastChildCoordinator as! ItemCreateCoordinatorProtocol).flowDidComplete!(item)
                  
                  expect(spyControllerFactory.makeItemDetailViewControllerItemArgs.last!)
                    .to(equal(item))
                }

                it("should call push on router") {
                  let preCallCount = spyRouter.callCountFor["push"]!
                  
                  (lastChildCoordinator as! ItemCreateCoordinatorProtocol).flowDidComplete!(item)
                  
                  expect(spyRouter.callCountFor["push"]).to(equal(preCallCount + 1))
                }

                it("should call push with an ItemDetailViewController") {
                  (lastChildCoordinator as! ItemCreateCoordinatorProtocol).flowDidComplete!(item)
                  
                  expect(spyRouter.pushViewControllerArgs.last!)
                    .to(beAnInstanceOf(ItemDetailViewController.self))
                }

                it("should call push with hideBottomBar set false") {
                  (lastChildCoordinator as! ItemCreateCoordinatorProtocol).flowDidComplete!(item)
                  
                  expect(spyRouter.pushHideBottomBarArgs.last!).to(equal(false))
                }
              }///showItemDetail
            }//with Item
          }///flowDidComplete
        }//onCreateItem
      }///ItemsListViewController
    }//ItemsTabCoordinator
  }///spec
}
