// ___FILEHEADER___

@testable import ___PROJECTNAME:identifier___

import UIKit

class MockAppState: AppStateProtocol {
  
  static var shared: AppStateProtocol = MockAppState()
  private var defaults: UserDefaults!
  
  private init() {
    defaults = UserDefaults(suiteName: "MockAppState")
    
    defaults.set(false, forKey: Key.isAuthenticated)
    defaults.set(false, forKey: Key.onboardingWasShown)
    defaults.set("MockUser", forKey: Key.username)
  }
  
  public func reset() {
    defaults.removePersistentDomain(forName: "MockAppState")
  }

  private enum Key {
    static let isAuthenticated = "isAuthenticated"
    static let onboardingWasShown = "onboardingWasShown"
    static let username = "username"
  }
  
  // MARK: -
  
  var isAuthenticated: Bool {
    get { return defaults.bool(forKey: Key.isAuthenticated) }
    set { defaults.set(newValue, forKey: Key.isAuthenticated) }
  }
  
  var onboardingWasShown: Bool {
    get { return defaults.bool(forKey: Key.onboardingWasShown) }
    set { defaults.set(newValue, forKey: Key.onboardingWasShown) }
  }
  
  var username: String? {
    get { return defaults.string(forKey: Key.username) ?? nil }
    set { defaults.set(newValue, forKey: Key.username) }
  }
}
