//
//  PickUpViewController.swift
//  myUberApp
//
//  Created by students on 2022/5/27.
//

import UIKit
import MapKit
import FirebaseDatabase

class PickUpViewController: UIViewController, MKMapViewDelegate {
    
    var passEmail = ""
    var passLocation = CLLocationCoordinate2D()
    var driverLocation = CLLocationCoordinate2D()
    let reference = Database.database().reference()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func pickUpBtn(_ sender: UIButton) {
        
        reference.child("passRequest").queryOrdered(byChild: "email").queryEqual(toValue: passEmail).observeSingleEvent(of: DataEventType.childAdded) { (dataSnapShot) in
            dataSnapShot.ref.updateChildValues(["driverLat" : self.driverLocation.latitude, "driverLon" : self.driverLocation.longitude])

            let passCLLocation = CLLocation(latitude: self.passLocation.latitude, longitude: self.passLocation.longitude)
                        
            CLGeocoder().reverseGeocodeLocation(passCLLocation, completionHandler: { (clPlacemarks, error) in
                if error != nil {
                    
                    print(error)
                    
                } else {
                    if let placeMarks = clPlacemarks {
                        
                        if placeMarks.count > 0{
                            let placeMark = MKPlacemark(placemark: placeMarks[0])
                            let mapItem = MKMapItem(placemark: placeMark)
                            mapItem.name = self.passEmail
                                        
                            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
                        }
                        
                    }
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        let spanMap = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        
        let regionMap = MKCoordinateRegion(center: passLocation, span: spanMap)

        mapView.setRegion(regionMap, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = passLocation
        annotation.title = passEmail

        mapView.addAnnotation(annotation)
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
