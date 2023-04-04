//
//  String + Extensions.swift
//  EsayAI
//
//  Created by Emirhan Saygiver on 4.04.2023.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
