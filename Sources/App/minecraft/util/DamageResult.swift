//
//  DamageResult.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public enum DamageResult {
    case success(SuccessResult)
    case failure(FailureReason)
    
    public enum SuccessResult {
        case normal
        case killed
        case custom(String)
    }
    public enum FailureReason {
        case blocked
        case cancelled
        case custom(String)
    }
}
