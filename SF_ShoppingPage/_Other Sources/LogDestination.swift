//
//  LogDestination.swift
//  SF_ShoppingPage
//
//  Created by Deyvidy Salvino on 26/06/22.
//

import Foundation

final class Logger: TextOutputStream {
    var fullLog: String
    
    init() {
        fullLog = String()
    }
    
    func write(_ string: String) {
        fullLog.append(contentsOf: "\(string)")
    }
}
