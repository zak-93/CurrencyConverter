//
//  SystemOptions.swift
//  TestApp
//
//  Created by Yashin Zahar on 23.05.2023.
//

import UIKit

class SystemOptions {
    static let share = SystemOptions()
    
    /// Есть ли у телефона домашняя кнопка
    public var isHomeIndicator: Bool {
        
        if #available(iOS 13.0, *), UIApplication.shared.windows[0].safeAreaInsets.bottom > 0 {
            return true
        }
        
        return false
    }
    
    /// Высота домашнией кнопки
    public var isHomeIndicatorHeight: CGFloat {
        
        if #available(iOS 13.0, *), UIApplication.shared.windows[0].safeAreaInsets.bottom > 0 {
            return UIApplication.shared.windows[0].safeAreaInsets.bottom
        }

        return 0
    }
}
