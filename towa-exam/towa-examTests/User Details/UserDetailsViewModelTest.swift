//
//  UserDetailsViewModel.swift
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
import Alamofire

@testable import towa_exam

class UserDetailsViewModelTest: QuickSpec {

    let scheduler = TestScheduler(initialClock: 0)
    let disposeBag = DisposeBag()
    
    override func spec() {
        describe("UserDetailsViewModelTest") {
            testSpecificUserDetails()
        }
    }
    
    
    func testSpecificUserDetails() {
        
        context("Trigger User to fetch user details") {
            
            let viewModel = UserDetailsViewModel()
            
            let observer = scheduler.createObserver(User?.self)
            
            viewModel.userDataRelay
                .asDriver()
                .drive(observer)
                .disposed(by: disposeBag)
            
            var mockUserListModel: User

            do {
                mockUserListModel = try TowaTestHelper.loadCodableFromJSON(withName: "user-details")
                print(mockUserListModel)
            } catch {
                print("fatal error", error)
                fatalError(error.localizedDescription)
            }
            
            it ("Should return complete data of User details") {
                XCTAssertNotNil(mockUserListModel.name)
                XCTAssertNotNil(mockUserListModel.username)
                XCTAssertNotNil(mockUserListModel.email)
                XCTAssertNotNil(mockUserListModel.phone)
                XCTAssertNotNil(mockUserListModel.website)
                XCTAssertNotNil(mockUserListModel.address)
                XCTAssertNotNil(mockUserListModel.company)
                XCTAssertEqual(mockUserListModel.id, 4)
            }
            
            context("Given that the observer is initialized") {
                
                it("User data relay should have changed 1 times") {
                    XCTAssertEqual(observer.events.count, 1)
                }
                
            }
        }
    }
            
       
}
