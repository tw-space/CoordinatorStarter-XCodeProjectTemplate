// ___FILEHEADER___

import UIKit

func executeRunLoop() {
  RunLoop.current.run(until: Date())
}

func tap(_ barButton: UIBarButtonItem) {
  _ = barButton.target?.perform(barButton.action, with: nil)
}

func tap(_ button: UIButton) {
  button.sendActions(for: .touchUpInside)
}
