// ___FILEHEADER___

import UIKit

protocol AppStateProtocol {
  
  static var shared: AppStateProtocol { get }
  
  func reset()
  
  var isAuthenticated: Bool { get set }
  var onboardingWasShown: Bool { get set }
  var username: String? { get set }
}

class AppState: AppStateProtocol {
  
  private let defaults: UserDefaults!
  static var shared: AppStateProtocol = AppState(defaults: UserDefaults.standard)
  
  init(defaults: UserDefaults) {
    self.defaults = defaults
  }
  
  // MARK: - Methods
  
  public func reset() {
    defaults.dictionaryRepresentation().keys.forEach(defaults.removeObject(forKey:))
  }
  
  // MARK: - State Variables
  
  private enum Key {
    static let isAuthenticated = "isAuthenticated"
    static let onboardingWasShown = "onboardingWasShown"
    static let username = "username"
  }
  
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
