//
//  SignUpTest.swift
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

class SignUpViewModelTest: QuickSpec {

    let scheduler = TestScheduler(initialClock: 0)
    let disposeBag = DisposeBag()
    
    override func spec() {
        describe("SignUpViewModelTest") {
            validateUserSignUpInputs()
        }
    }
    
    func validateUserSignUpInputs() {
        
        context("Trigger when user input data in sign up") {
            
            let signUpVM = SignUpViewModel()
            
            signUpVM.isUserNameInvalid
                .asDriver()
                .drive()
                .disposed(by: disposeBag)
            
            signUpVM.isPasswordInvalid
                .asDriver()
                .drive()
                .disposed(by: disposeBag)
            
            it("Should return TRUE since the user input complete data") {
                expect(signUpVM.isCanProceed(username: "Test", password: "TestPass123")).to(equal(true))
            }
            
            it("Should return FALSE since the user didnt input password") {
                expect(signUpVM.isCanProceed(username: "Test", password: "")).to(equal(false))
            }
            
            it("Should return FALSE since the user didnt input username") {
                expect(signUpVM.isCanProceed(username: "", password: "TestPass123")).to(equal(false))
            }
            
            it("Should return FALSE since the user didnt input data") {
                expect(signUpVM.isCanProceed(username: "", password: "")).to(equal(false))
            }
            
            
            it("Should return empty error message since the user username is > 3") {
                expect(signUpVM.usernameValidationMessage(characterCount: 6)).to(equal(""))
            }
            
            it("Should return error message since the user username is < 3") {
                expect(signUpVM.usernameValidationMessage(characterCount: 2)).to(equal("Username must be at least 3 characters."))
            }
            
            
            it("Should return empty error message since user password has uppercase, lowercase, number and > 8 characters") {
                expect(signUpVM.passwordValidateMessage(password: "TestPass123")).to(equal(""))
            }
            
            it("Should return error message since user password dont have uppercase") {
                expect(signUpVM.passwordValidateMessage(password: "testpass123")).to(equal("Min. 8 character, 1 uppercase & 1 lowercase."))
            }
            
            it("Should return error message since user password dont have lowercase") {
                expect(signUpVM.passwordValidateMessage(password: "TESTPASS123")).to(equal("Min. 8 character, 1 uppercase & 1 lowercase."))
            }
            
            it("Should return error message since user password dont have number") {
                expect(signUpVM.passwordValidateMessage(password: "TestPass")).to(equal("Min. 8 character, 1 uppercase & 1 lowercase."))
            }
            
            it("Should return error message since user password is < 8 characers") {
                expect(signUpVM.passwordValidateMessage(password: "Test1")).to(equal("Min. 8 character, 1 uppercase & 1 lowercase."))
            }
            
            
            it("Should have default value true to credential flagging") {
                expect(signUpVM.isUserNameInvalid.value).to(equal(true))
                expect(signUpVM.isPasswordInvalid.value).to(equal(true))
            }
            
            


        }
        
    }
    
}
