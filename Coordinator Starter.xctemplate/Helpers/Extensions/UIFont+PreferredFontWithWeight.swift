// ___FILEHEADER___

import UIKit

extension UIFont {
  
  static func preferredFont(for textStyle: TextStyle) -> UIFont {
    return self.preferredFont(forTextStyle: textStyle)
  }

  static func preferredFont(for textStyle: TextStyle, weight: Weight)
    -> UIFont
  {
    let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
    let font = UIFont.systemFont(ofSize: descriptor.pointSize, weight: weight)
    let metrics = UIFontMetrics(forTextStyle: textStyle)
    return metrics.scaledFont(for: font)
  }
}
