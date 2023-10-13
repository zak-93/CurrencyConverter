import UIKit

extension MainViewController {
    
    func natificationKeyboard() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc public func willShowKeyboard(_ notification: NSNotification) {
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardSizeEnd = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        else {return}
        
        let keyboardHeight = SystemOptions.share.isHomeIndicator ? keyboardSizeEnd.cgRectValue.size.height - SystemOptions.share.isHomeIndicatorHeight : keyboardSizeEnd.cgRectValue.size.height
                
        let curve = (info[UIResponder.keyboardAnimationCurveUserInfoKey]! as AnyObject).uint32Value
        let options = UIView.AnimationOptions(rawValue: UInt(curve!) << 16 | UIView.AnimationOptions.beginFromCurrentState.rawValue)
        let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey]! as AnyObject).doubleValue

        let heightBottom = keyboardHeight + bottomPaddingRefreshButton
        self.bottomRefreshButtonConstraint?.constant = -heightBottom
        self.leftBottomView.backgroundColor = .color3B70F9

        UIView.animate(
            withDuration: duration!,
            delay: 0,
            options: options,
            animations: {
                self.view.layoutIfNeeded()
            },
            completion: { bool in
        })
    }
    
    @objc func willHideKeyboard(_ notification: Notification) {
        guard let info = notification.userInfo as NSDictionary? else { return }
        
        let curve = (info[UIResponder.keyboardAnimationCurveUserInfoKey]! as AnyObject).uint32Value
        let options = UIView.AnimationOptions(rawValue: UInt(curve!) << 16 | UIView.AnimationOptions.beginFromCurrentState.rawValue)
        ///продолжительность анимации
        let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey]! as AnyObject).doubleValue

        self.bottomRefreshButtonConstraint?.constant = -16
        self.leftBottomView.backgroundColor = .colorDADADA
        
        UIView.animate(
            withDuration: duration!,
            delay: 0,
            options: options,
            animations: {
                self.view.layoutIfNeeded()
            },
            completion: { bool in
        })
    }
}
