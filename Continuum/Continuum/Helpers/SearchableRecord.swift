//
//  SearchableRecord.swift
//  Continuum
//
//  Created by Apps on 8/28/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import Foundation

protocol SearchableRecord: class {
    
    func matches(searchTerm: String) -> Bool
    
}
