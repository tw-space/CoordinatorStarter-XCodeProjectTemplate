// ___FILEHEADER___

import Foundation

extension Helper {
  
  static func getDocumentDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }
}
