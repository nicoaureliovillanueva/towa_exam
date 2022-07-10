//
//  LoginTest.swift
//  towa-examTests
//
//  Created by Nico Aurelio Villanueva on 7/10/22.
//

import Foundation
import Quick
import Nimble
import RxRelay
import RxSwift
import RxTest
import XCTest

@testable import towa_exam

class LoginViewModelTest: QuickSpec {

    let scheduler = TestScheduler(initialClock: 0)
    let disposeBag = DisposeBag()

    override func spec() {
        describe("LoginViewModelTest") {
            validateCompleteUserInputCredentail()
        }
    }
    
    func validateCompleteUserInputCredentail() {
        
        context("Trigger when user input credential") {
            
            let testVM = LoginViewModel()
           
            it("Should return FALSE since the user input complete credential") {
                expect(testVM.validateCompletedField(username: "Test", password: "TestPass123")).to(equal(true))
            }
            
            it("Should return FALSE since the user did not input password") {
                expect(testVM.validateCompletedField(username: "Test", password: "")).to(equal(false))
            }
            
            it("Should return FALSE since the user did not input username") {
                expect(testVM.validateCompletedField(username: "", password: "TestPass123")).to(equal(false))
            }
            
            it("Should return FALSE since the user did not input credential") {
                expect(testVM.validateCompletedField(username: "", password: "")).to(equal(false))
            }
            
        }
        
    }

}
