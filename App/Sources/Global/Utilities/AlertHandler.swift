//Copyright © 2020 Tractive. All rights reserved.

import UIKit

final class AlertHandler {
    private var presentingViewCtrl: UIViewController
    
    init(presentingViewCtrl: UIViewController) {
        self.presentingViewCtrl = presentingViewCtrl
    }
    
    func showInformation(title: String, message: String) {
        let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.Global.Actions.ok, style: .default)
        alertCtrl.addAction(okAction)
        presentAlert(alertCtrl)
    }
    
    private func presentAlert(_ alertCtrl: UIAlertController) {
        DispatchQueue.main.async {
            self.presentingViewCtrl.present(alertCtrl, animated: true)
        }
    }
}
