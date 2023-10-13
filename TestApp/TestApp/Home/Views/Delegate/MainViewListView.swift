import Foundation

extension MainViewController: ListViewControllerDelegate {
    func leftCurrency(name: String) {
        leftCurrencyView.setData(name)
    }
    
    func rightCurrency(name: String) {
        rightCurrencyView.setData(name)
    }
}
