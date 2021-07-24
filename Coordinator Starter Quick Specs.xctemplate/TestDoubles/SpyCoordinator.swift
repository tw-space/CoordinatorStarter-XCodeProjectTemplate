// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import UIKit

class SpyCoordinator: BaseCoordinator,
                      AuthenticationCoordinatorProtocol,
                      ItemCreateCoordinatorProtocol,
                      ItemsTabCoordinatorProtocol,
                      OnboardingCoordinatorProtocol,
                      SettingsTabCoordinatorProtocol,
                      TabBarCoordinatorProtocol
{
  // MARK: - Spy Properties
  
  var callCountFor: [String: Int] = [
    "start": 0,
  ]
  var type: String
  
  // MARK: - Initializer
  
  init(type: String) {
    self.type = type
  }
  
  // MARK: - Conformance
  
  var flowDidComplete: ((Item?) -> Void)?  // ItemCreateCoordinatorProtocol
  var onCompleteAuth: ((String) -> Void)?  // AuthenticationCoordinatorProtocol
  var onCompleteOnboarding: (() -> Void)?  // OnboardingCoordinatorProtocol
  var username: String?                    // SettingsTabCoordinatorProtocol
  
  override func start() {
    callCountFor["start"]! += 1
  }
}
