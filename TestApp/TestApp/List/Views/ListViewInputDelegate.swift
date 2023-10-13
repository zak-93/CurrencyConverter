import Foundation


protocol ListViewInputDelegate: AnyObject {
    
    func getCurrencys(data: [String])
        
    func errorData(error: CurrentyError) 
}
