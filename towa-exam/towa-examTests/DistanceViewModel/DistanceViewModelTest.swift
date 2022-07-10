//
//  DistanceViewModelTest.swift
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
import CoreLocation

class DistanceViewModelTest: QuickSpec {

    let scheduler = TestScheduler(initialClock: 0)
    let disposeBag = DisposeBag()

    override func spec() {
        describe("DistanceViewModelTest") {
            testPlotCurrentLocationAnnotaion()
            testUserDistance()
        }
    }
    
    func testPlotCurrentLocationAnnotaion() {
        context("When user check distance") {
            let viewModel = DistanceViewModel()
            
            let currentLocation = CLLocationCoordinate2D(latitude: 14.0000000,
                                                 longitude: 14.002200)

            viewModel.addAnnotation(location: currentLocation)
            
            it("Should added annotation for currentLocation") {
                expect(viewModel.userAnnotationRelay.value.count).to(beGreaterThan(0))
            }
        }
    }
    
    
    func testPlotUserLocationAnnotaion() {
        context("When user check distance") {
            let viewModel = DistanceViewModel()
            
            let currentLocation = CLLocationCoordinate2D(latitude: 14.0000000,
                                                 longitude: 14.102200)

            viewModel.addAnnotation(location: currentLocation)
            
            it("Should added annotation for currentLocation") {
                expect(viewModel.userAnnotationRelay.value.count).to(beGreaterThan(0))
            }
        }
    }
    
    
    func testUserDistance() {
        context("When user check distance") {
            let viewModel = DistanceViewModel()
            
            let currLoc = CLLocationCoordinate2D(latitude: 14.0000000,
                                                 longitude: 14.002200)

            let clientLoc = CLLocationCoordinate2D(latitude: 14.0000000,
                                                 longitude: 14.102200)

            viewModel.calculateDistance(currentLocation: currLoc, clientLocation: clientLoc)
            
            it("Should not be empty or nil distance calculated") {
                expect(viewModel.calculatedDistance.value).toNot(beEmpty())
            }
        }
    }
    
}
