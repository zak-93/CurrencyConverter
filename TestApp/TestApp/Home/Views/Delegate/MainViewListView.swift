//
//  MainViewListView.swift
//  TestApp
//
//  Created by Yashin Zahar on 23.05.2023.
//

import Foundation

extension MainViewController: ListViewControllerDelegate {
    func leftCurrency(name: String) {
        leftCurrencyView.setData(name)
    }
    
    func rightCurrency(name: String) {
        rightCurrencyView.setData(name)
    }
}
