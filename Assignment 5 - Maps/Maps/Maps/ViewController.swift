//
//  ViewController.swift
//  Maps
//
//  Created by Clay McLeod on 3/24/15.
//  Copyright (c) 2015 Clay McLeod. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altLabel: UILabel!
    
    var locationManager : CLLocationManager?
    var currentLocation : CLLocation?
    
    var isFirstCameraSet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (nil == locationManager) {
            locationManager = CLLocationManager();
        }
        
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization();
        locationManager?.startUpdatingLocation();
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager?.distanceFilter = 15;
        
        myMapView.delegate = self;
        myMapView.camera.altitude = 500;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setCameraView(latitude : CLLocationDegrees, longitude: CLLocationDegrees) {
        let ground = CLLocationCoordinate2DMake(latitude, longitude);
        let eye = CLLocationCoordinate2DMake(latitude+0.0001, longitude-0.0001);
        let myCamera = MKMapCamera(lookingAtCenterCoordinate: ground, fromEyeCoordinate: eye, eyeAltitude: myMapView.camera.altitude);
        myMapView.camera = myCamera;
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        currentLocation = locations.last as? CLLocation;
        let eventDate = currentLocation?.timestamp;
        
        if(!isFirstCameraSet) {
            setCameraView(currentLocation!.coordinate.latitude, longitude: currentLocation!.coordinate.longitude);
            isFirstCameraSet = true
        }
        
        let myPoint = MKPointAnnotation();
        myPoint.coordinate = currentLocation!.coordinate;
        var locationInMap = false;
        
        myMapView.annotations
        for annotation in myMapView.annotations {
            let pointAnnotation = annotation as! MKPointAnnotation
            
            if (pointAnnotation.coordinate.latitude == myPoint.coordinate.latitude
                && pointAnnotation.coordinate.longitude == myPoint.coordinate.longitude) {
                    
                locationInMap = true;
                break;
            }
        }
        
        if (!locationInMap) {
            self.myMapView.addAnnotation(myPoint);
            setCameraView(myPoint.coordinate.latitude, longitude: myPoint.coordinate.longitude)
        }
        
        if (abs(eventDate!.timeIntervalSinceNow) < 15.0) {
            NSLog("Updated location: Lat %+.3f, Lon %+.3f\n", currentLocation!.coordinate.latitude,
                currentLocation!.coordinate.longitude);
            speedLabel.text = NSString(format: "Speed: %.1f MPH", currentLocation!.speed * 2.2369) as String;
            altLabel.text = NSString(format: "Altitude: %.1f Feet", currentLocation!.altitude * 3.28084) as String;
            courseLabel.text = NSString(format: "Course: %.1f Degress", currentLocation!.course) as String;
            
            speedLabel.sizeToFit()
            altLabel.sizeToFit()
            courseLabel.sizeToFit()
        }
    }
    
    //    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) {
    //
    //        let route = MKPolyline();
    //        let routeRenderer = MKPolylineRenderer(polyline: route);
    //        routeRenderer.strokeColor = self.view.tintColor;
    //        return routeRenderer as! MKOverlayRenderer;
    //
    //    }
    
    //
    //- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    //                MKPlacemark *mkDest = [[MKPlacemark alloc]
    //                                       initWithCoordinate:view.annotation.coordinate
    //                                       addressDictionary:nil];
    //
    //                MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    //                [request setSource:[MKMapItem mapItemForCurrentLocation]];
    //                [request setDestination:[[MKMapItem alloc] initWithPlacemark:mkDest]];
    //                [request setTransportType:MKDirectionsTransportTypeAutomobile];
    //                [request setRequestsAlternateRoutes:NO];
    //                MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    //
    //
    //                [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
    //                    if (!error) {
    //                        for (MKRoute *route in [response routes]) {
    //                            [self.mapView addOverlay:[route polyline] level:MKOverlayLevelAboveRoads];
    //                        }
    //                    }
    //                }];
    //    } else {
    //                self.annotationView = view;
    //                [self.mapView deselectAnnotation:view.annotation animated:YES];
    //                [self performSegueWithIdentifier:@"PopoverPresentation" sender:nil];
    //            }
    //}
}

