//
//  ListViewInputDelegate.swift
//  TestApp
//
//  Created by Yashin Zahar on 23.05.2023.
//

import Foundation


protocol ListViewInputDelegate: AnyObject {
    
    func getCurrencys(data: [String])
        
    func errorData(error: CurrentyError) 
}
