import Foundation

protocol MainViewInputDelegate: AnyObject {
    func getData(data: Double)
    
    func errorData(error: CurrentyError)
}
