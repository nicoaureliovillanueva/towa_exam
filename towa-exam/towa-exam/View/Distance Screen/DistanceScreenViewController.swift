//
//  DistanceScreenViewController.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/8/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import RxSwift


class DistanceScreenViewController: BaseViewController {
    
    // MARK: Variable Declaration
    
    let clManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    var destinationCoordinate: CLLocationCoordinate2D?
    
    let viewModel = DistanceViewModel()
    
    let disposeBag = DisposeBag()
    
    // MARK: UI Declaration
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        return map
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.main_background()
        view.layer.cornerRadius = 30
        return view
        
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.userlist_placeholder()
        return imageView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.xxLargeTitle
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.distance_title()
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.regular
        return label
    }()
    
    private lazy var computedDistance: UILabel = {
        let label = UILabel()
        label.textColor = R.color.accent_light_color()
        label.font = FontManager.xxxLargeTitle
        return label
    }()
    
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.close_icon(), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        return manager
    }()
    
    // MARK: Private fuction for UI Configuration and Bindings
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureBindings()
        
        configureLocationService()
        
    }
    
    
    private func configureUI() {
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            
        }
        
        self.view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.top.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            
        }
        
        self.view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.centerX.equalToSuperview()
            
        }
        
        containerView.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).inset(20)
            make.width.equalTo(userImageView.snp.height)
            make.left.equalTo(containerView.snp.left).inset(20)
            make.bottom.equalTo(containerView.snp.bottom).inset(20)
            
        }
        
        containerView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).inset(10)
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.right.equalTo(containerView.snp.right).offset(10)
            
        }
        
        containerView.addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.left.equalTo(userImageView.snp.right).offset(10)
            
        }
        
        containerView.addSubview(computedDistance)
        computedDistance.snp.makeConstraints { make in
            make.top.equalTo(distanceLabel.snp.bottom).offset(8)
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.bottom.equalTo(containerView.snp.bottom).inset(10)
            
        }
        
    }
    
    private func configureBindings() {
        viewModel.userDataLocationRelay
            .asDriver()
            .drive(onNext: { userData in
                if let data = userData {
                    self.configureDistance(user: data)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.mapAnnotationRelay
            .asDriver()
            .drive(onNext: { annots in
                self.configureAnnotation(coordinates: annots)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.calculatedDistance
            .asDriver()
            .drive(onNext: { distance in
                self.computedDistance.text = distance
            })
            .disposed(by: disposeBag)
        
        
        dismissButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureLocationService() {
        locationManager.delegate = self
        mapView.delegate = self
        
        if #available(iOS 14.0, *) {
            switch clManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
                break
            case .authorizedAlways, .authorizedWhenInUse:
                mapView.showsUserLocation = false
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                beginLocationUpdate(location: locationManager)
                break
                
            case .restricted:
                
                break
            case .denied:
                
                
                break
            @unknown default:
                print("Unknown Authorization Error")
            }
        } else {
            // Fallback on earlier versions
            
            if CLLocationManager.locationServicesEnabled() {
               switch CLLocationManager.authorizationStatus() {
               case .notDetermined:
                   locationManager.requestAlwaysAuthorization()
                   break
               case .authorizedAlways, .authorizedWhenInUse:
                   mapView.showsUserLocation = false
                   locationManager.desiredAccuracy = kCLLocationAccuracyBest
                   beginLocationUpdate(location: locationManager)
                   
                   break
               case .restricted:
                   break
               case .denied:
                   break
               @unknown default:
                   print("Unknown Authorization Error")
                 }
           }
            
            
        }
        
        
        if #available(iOS 14.0, *) {
            if clManager.authorizationStatus == .notDetermined {
                locationManager.requestAlwaysAuthorization()
            }
        } else {
            // Fallback on earlier versions
            if CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestAlwaysAuthorization()
            }
        }
        
    }
    
    private func zoomToLocation(with coordinate: CLLocationCoordinate2D) {
        viewModel.userCurrentLocation = coordinate
        viewModel.monitorPlots()
    }
    
    private func beginLocationUpdate(location: CLLocationManager) {
        locationManager.startUpdatingLocation()
    }
    
    private func configureAnnotation(coordinates: [MKAnnotation?]) {
        for coordinate in coordinates {
            if let location = coordinate {
                mapView.addAnnotation(location)
            }
        }
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        
    }
    
    private func configureDistance(user: User) {
        let desti = CLLocationCoordinate2D(latitude: Double(user.address.geo.lat) ?? 0.0,
                                                   longitude: Double(user.address.geo.lng) ?? 0.0)
        viewModel.userClientLocation = desti
        viewModel.userCity = user.address.city
        self.usernameLabel.text = user.name
        
    }
}

extension DistanceScreenViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let latestLocation = locations.first else { return }
        
        if currentCoordinate == nil {
            zoomToLocation(with: latestLocation.coordinate)
        }
        
        currentCoordinate = latestLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdate(location: manager)
        }
        
    }
}


// MARK: MKMapView Delegate

extension DistanceScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        }else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = annotation.title == R.string.localizable.current_location_title() ? R.image.client_pin() : R.image.user_pin()
        
        return annotationView
    }
}
