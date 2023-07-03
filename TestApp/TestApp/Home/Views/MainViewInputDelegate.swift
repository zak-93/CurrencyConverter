//
//  MainViewInputDelegate.swift
//  TestApp
//
//  Created by Yashin Zahar on 23.05.2023.
//

import Foundation

protocol MainViewInputDelegate: AnyObject {
    func getData(data: Double)
    
    func errorData(error: CurrentyError)
}
