// ___FILEHEADER___

import UIKit

extension UIViewController {
  
  func tapToDismissKeyboard() {
    let tap =
      UITapGestureRecognizer(target: self,
                             action: #selector(UIViewController.endEditing))
    tap.cancelsTouchesInView = true
    view.addGestureRecognizer(tap)
  }
  
  @objc func endEditing() {
    view.endEditing(true)
  }
}
