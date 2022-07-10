//
//  DistanceViewModel.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/8/22.
//

import Foundation
import RxRelay
import CoreLocation
import MapKit


class DistanceViewModel {
    
    var annotations: [CLLocationCoordinate2D]
    var userCurrentLocation: CLLocationCoordinate2D?
    var userClientLocation: CLLocationCoordinate2D?
    var mapAnnotation: [MKAnnotation]
    var userCity: String?
    
    
    var userDataLocationRelay: BehaviorRelay<User?>
    var userAnnotationRelay: BehaviorRelay<[CLLocationCoordinate2D?]>
    
    var mapAnnotationRelay: BehaviorRelay<[MKAnnotation?]>
    var calculatedDistance: BehaviorRelay<String?>
    
    
    init() {
        
        self.annotations = []
        self.mapAnnotation = []
        self.userCity = ""
        
        self.userDataLocationRelay = .init(value: nil)
        self.userAnnotationRelay = .init(value: [])
        self.mapAnnotationRelay = .init(value: [])
        self.calculatedDistance = .init(value: "")
        
    }
    
    func addAnnotation(location: CLLocationCoordinate2D) {
        self.annotations.append(location)
        self.userAnnotationRelay.accept(self.annotations)
    }
    
    func monitorPlots() {
        let annots = [userCurrentLocation, userClientLocation]
        for (index, annot) in annots.enumerated() {
            let annotation = MKPointAnnotation()
            annotation.title = index == 0 ? R.string.localizable.current_location_title() : self.userCity
            annotation.coordinate = CLLocationCoordinate2D(latitude: annot?.latitude ?? 0.0,
                                                           longitude: annot?.longitude ?? 0.0)
            
            mapAnnotation.append(annotation)
            
        }
        
        self.mapAnnotationRelay.accept(mapAnnotation)
        self.calculateDistance(currentLocation: userCurrentLocation, clientLocation: userClientLocation)
    }
    
    
    func calculateDistance(currentLocation:CLLocationCoordinate2D?, clientLocation:  CLLocationCoordinate2D?) {
        
        guard let currentLoc = currentLocation else { return }

        guard let clientLoc = clientLocation else { return }
        
        self.calculatedDistance.accept(String(format: "📍 %.01f km", clientLoc.distance(to: currentLoc).inKilometers()))
    }
    
}
