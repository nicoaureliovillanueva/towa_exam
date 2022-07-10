//
//  HomeTest.swift
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

class HomeViewModelTest: QuickSpec {

    let scheduler = TestScheduler(initialClock: 0)
    let disposeBag = DisposeBag()
    
    override func spec() {
        describe("HomeViewModelTest") {
            testUserData()
        }
    }
    
    
    func testUserData() {
        
        context("Trigger User API request") {
            
            let apiService = APIServices()
            let viewModel = HomeViewModel(apiService: apiService)
            
            let observer = scheduler.createObserver([User?].self)
            
            viewModel.userListRelay
                .asDriver()
                .drive(observer)
                .disposed(by: disposeBag)
            
            var mockUserListModel: [User?]

            do {
                mockUserListModel = try TowaTestHelper.loadCodableFromJSON(withName: "user-list-response")
                print(mockUserListModel)
            } catch {
                print("fatal error", error)
                fatalError(error.localizedDescription)
            }
            
            it ("Should return complete data of User model") {
                XCTAssertNotNil(mockUserListModel[0]?.name)
                XCTAssertNotNil(mockUserListModel[0]?.username)
                XCTAssertNotNil(mockUserListModel[0]?.email)
                XCTAssertNotNil(mockUserListModel[0]?.phone)
                XCTAssertNotNil(mockUserListModel[0]?.website)
                XCTAssertNotNil(mockUserListModel[0]?.address)
                XCTAssertNotNil(mockUserListModel[0]?.company)
                XCTAssertEqual(mockUserListModel[0]?.id, 1)
            }
            
            context("Given that the observer is initialized") {
                
                it("User list relay should have changed 1 times") {
                    XCTAssertEqual(observer.events.count, 1)
                }
                
            }
        }
    }
            
       
}
