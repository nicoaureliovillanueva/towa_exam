//
//  Resource.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/10/22.
//

import Foundation

public enum Resource<T>: Equatable {
  
    case none, loading, success(data: T), empty, error(message: String)
    
    public var rawValue: Int {
        switch self {
        case .none: return 0
        case .loading: return 1
        case .success: return 2
        case .empty: return 3
        case .error: return 4
        }
    }
    
    // For improvement: Check success and error values
    public static func == (lhs: Resource<T>, rhs: Resource<T>) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    
}
