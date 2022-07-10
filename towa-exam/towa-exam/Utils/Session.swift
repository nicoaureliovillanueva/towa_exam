//
//  Session.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/7/22.
//

import Foundation
import CoreLocation

open class Session: LocalStorage {
    /* Tick */
    
    public static let shareSession = Session()
    
    /* Username */
    open var username: String {
        get {
            let userName = string(forKey: "userName") ?? ""
            return userName
        }
        set {
            setObject(newValue as AnyObject?, forKey: "userName")
        }
    }
    
    /* App State Type */
    open var appState: Bool {
        get {
            let appTS = bool(forKey: "appState")
            return appTS
        }
        set {
            setObject(newValue as AnyObject?, forKey: "appState")
        }
    
    }
}
