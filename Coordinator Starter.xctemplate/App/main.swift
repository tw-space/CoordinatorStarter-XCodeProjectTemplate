// ___FILEHEADER___

import UIKit

private let delegateClassName = NSStringFromClass(
  NSClassFromString("TestAppDelegate") ?? AppDelegate.self
)

UIApplicationMain(CommandLine.argc,
                  CommandLine.unsafeArgv,
                  nil,
                  delegateClassName)
