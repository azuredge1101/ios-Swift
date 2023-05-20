//
//  RiderViewController.swift
//  myUberApp
//
//  Created by students on 2022/5/13.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth
import FirebaseDatabase

class RiderViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var uberIsCalled = false
    var userLocation = CLLocationCoordinate2D()
    let reference : DatabaseReference = Database.database().reference()
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBAction func callUber(_ sender: UIButton) {
        
        if let email = Auth.auth().currentUser?.email {
                
        
            if uberIsCalled {
                reference.child("passRequest").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(DataEventType.childAdded){ (dataSnapShot) in
                    
                    dataSnapShot.ref.removeValue()
                    
                    self.reference.child("passRequest").removeAllObservers()
                }
                cancelUberMode()
            } else {
                let passRequestDic : [String : Any] = ["email" : email, "latitude" : userLocation.latitude, "longitude" : userLocation.longitude]
                reference.child("passRequest").childByAutoId().setValue(passRequestDic)
                
                callUberMode()
            }
        }
    }
    func callUberMode() {
        buttonOutlet.setTitle("Cancel Uber", for: UIControl.State.normal)
        buttonOutlet.backgroundColor = #colorLiteral(red: 1, green: 0.6359215379, blue: 0.7648346424, alpha: 1)
        buttonOutlet.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: UIControl.State.normal)
        
        uberIsCalled = true
    }
    func cancelUberMode() {
        buttonOutlet.setTitle("Call An Uber", for: UIControl.State.normal)
        buttonOutlet.backgroundColor = #colorLiteral(red: 0.5858410001, green: 0.806393683, blue: 1, alpha: 1)
        buttonOutlet.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControl.State.normal)
        
        uberIsCalled = false
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            print("Sign Out Fail!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let corrdinate : CLLocationCoordinate2D = manager.location?.coordinate {
            userLocation = corrdinate
            let region = MKCoordinateRegion(center: corrdinate, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
            
            mapView.setRegion(region, animated: true)
            mapView.removeAnnotations(mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = corrdinate
            annotation.title = "My Location"
            
            mapView.addAnnotation(annotation)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
