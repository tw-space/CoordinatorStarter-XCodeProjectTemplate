// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import SnapshotTesting
import UIKit
import XCTest

final class ItemDetailViewSnapshots: XCTestCase {
  
  // MARK: - Properties
  
  private var rootNavController: UINavigationController!
  private var item: Item!
  private var sut: ItemDetailViewController!
  private var waitSeconds: TimeInterval!
  
  // MARK: - Set Up & Tear Down
  
  override func setUpWithError() throws {
    rootNavController = UINavigationController(nibName: nil, bundle: nil)
    rootNavController.isNavigationBarHidden = false
    item = Item(title: "Snapshot", subtitle: "Description")
    sut = ItemDetailViewController(for: item)
    rootNavController.viewControllers = [sut]
    sut.view.setNeedsDisplay()
    executeRunLoop()
    waitSeconds = 0
    isRecording = false
  }
  
  override func tearDownWithError() throws {
    rootNavController = nil
    sut = nil
    waitSeconds = nil
    executeRunLoop()
  }
  
  // MARK: - Snapshot Tests
  
  func test_ItemDetailView_afterLoad_looksRightOniPhoneSeGen1() {
    assertSnapshot(matching: rootNavController, as: .wait(for: waitSeconds, on: .image(on: .iPhoneSeGen1)))
  }
  
  func test_ItemDetailView_afterLoad_looksRightOniPhone8() {
    assertSnapshot(matching: rootNavController, as: .wait(for: waitSeconds, on: .image(on: .iPhone8)))
  }
  
  func test_ItemDetailView_afterLoad_looksRightOniPhone8Plus() {
    assertSnapshot(matching: rootNavController, as: .wait(for: waitSeconds, on: .image(on: .iPhone8Plus)))
  }
  
  func test_ItemDetailView_afterLoad_looksRightOniPhoneX() {
    assertSnapshot(matching: rootNavController, as: .wait(for: waitSeconds, on: .image(on: .iPhoneX)))
  }
  
  func test_ItemDetailView_afterLoad_looksRightOniPhoneXsMax() {
    assertSnapshot(matching: rootNavController, as: .wait(for: waitSeconds, on: .image(on: .iPhoneXsMax)))
  }
  
  func test_ItemDetailView_afterLoad_looksRightOniPhone12() {
    assertSnapshot(matching: rootNavController, as: .wait(for: waitSeconds, on: .image(on: .iPhone12)))
  }
  
  func test_ItemDetailView_afterLoad_looksRightOniPhone12ProMax() {
    assertSnapshot(matching: rootNavController, as: .wait(for: waitSeconds, on: .image(on: .iPhone12ProMax)))
  }
  
  func test_ItemDetailView_afterLoad_looksRightOniPadMini() {
    assertSnapshot(matching: rootNavController, as: .wait(for: waitSeconds, on: .image(on: .iPadMini)))
  }
  
  func test_ItemDetailView_afterLoad_looksRightOniPadPro10_5() {
    assertSnapshot(matching: rootNavController, as: .wait(for: waitSeconds, on: .image(on: .iPadPro10_5)))
  }
  
  func test_ItemDetailView_afterLoad_looksRightOniPadPro11() {
    assertSnapshot(matching: rootNavController, as: .wait(for: waitSeconds, on: .image(on: .iPadPro11)))
  }
  
  func test_ItemDetailView_afterLoad_looksRightOniPadPro12_9() {
    assertSnapshot(matching: rootNavController, as: .wait(for: waitSeconds, on: .image(on: .iPadPro12_9)))
  }
}

