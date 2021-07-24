// ___FILEHEADER___

import UIKit

extension UITextField {
  
  func setSidePadding(_ amount: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0,
                                           width: amount,
                                           height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
    self.rightView = paddingView
    self.rightViewMode = .always
  }
}
