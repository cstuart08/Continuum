//
//  DateHelper.swift
//  Continuum
//
//  Created by Apps on 8/27/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import Foundation

class DateHelper {
    
    static let sharedDateHelper = DateHelper()
    
    let dateFormatter = DateFormatter()
    
    func mediumDate(timestamp: Date) -> String {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        let dateString = dateFormatter.string(from: timestamp)
        return dateString
    }
}
