// ___FILEHEADER___

import UIKit

extension UIColor {
  
  convenience init(hex: String) {
    self.init(hex: hex, alpha: 1.0)
  }
  
  convenience init(hex: String, alpha: CGFloat) {
    
    let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    guard hexString.count == 6,
          hex.range(of: #"[g-zG-Z]"#, options: .regularExpression) == nil
    else { self.init(white: 0.0, alpha: 1.0); return }
    
    let hexArray = Array(hexString)
    let redString: String = String(hexArray[0]) + String(hexArray[1])
    let greenString: String = String(hexArray[2]) + String(hexArray[3])
    let blueString: String = String(hexArray[4]) + String(hexArray[5])
    
    let red: UInt8 = UInt8(redString, radix: 16)!
    let green: UInt8 = UInt8(greenString, radix: 16)!
    let blue: UInt8 = UInt8(blueString, radix: 16)!

    self.init(red: CGFloat(red) / 255,
              green: CGFloat(green) / 255,
              blue: CGFloat(blue) / 255,
              alpha: alpha)
  }
}
