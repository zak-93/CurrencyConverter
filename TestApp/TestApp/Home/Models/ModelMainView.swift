//
//  ModelMainView.swift
//  TestApp
//
//  Created by Yashin Zahar on 23.05.2023.
//

import Foundation

struct Converter: Codable {
    let status: Int
    let message: String
    let data: [String: String]
}
