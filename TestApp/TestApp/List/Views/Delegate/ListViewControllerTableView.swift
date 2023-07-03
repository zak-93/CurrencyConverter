//
//  ListViewControllerTableView.swift
//  TestApp
//
//  Created by Yashin Zahar on 23.05.2023.
//

import UIKit

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as! CurrencyTableViewCell
        cell.name = self.currency
        cell.updateData(name: currencys[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nameCurrency = currencys[indexPath.row]
        sendCurrency(name: nameCurrency)
        closeModul()
    }
}
