//
//  DriverTableViewController.swift
//  myUberApp
//
//  Created by students on 2022/5/13.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import CoreLocation

class DriverTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    let reference = Database.database().reference()
    var passRequests : [DataSnapshot] = []
    let locationManager = CLLocationManager()
    var driverLocation = CLLocationCoordinate2D()
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

        retrieveData()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        Timer.scheduledTimer(withTimeInterval: 1,repeats: true) { (timer) in
            self.tableView.reloadData()
        }
    }
    func retrieveData() {
        reference.child("passRequest").observe(DataEventType.childAdded){ (dataSnapShot) in
            self.passRequests.append(dataSnapShot)
            dataSnapShot.ref.removeAllObservers()
            
        }

    // MARK: - Table view data source
    
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        driverLocation = (manager.location?.coordinate)!
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return passRequests.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapShot = passRequests[indexPath.row]
        performSegue(withIdentifier: "pickUpSegue", sender: snapShot)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickUpSegue" {
            let destVC = segue.destination as! PickUpViewController
                    
            if let snapShot = sender as? DataSnapshot {

                if let passRequestDic = snapShot.value as? [String : Any] {
                    if let email = passRequestDic["email"] as? String {
                        if let latitude = passRequestDic["latitude"] as? Double {
                            if let longitude = passRequestDic["longitude"] as? Double {
                                        
                                destVC.passEmail = email
                                        
                                let passLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                destVC.passLocation = passLocation
                                destVC.driverLocation = driverLocation
                            }
                        }
                    }
                }

            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! PassTableViewCell
        let snapShot = passRequests[indexPath.row]
        if let passRequestDic = snapShot.value as? [String : Any]{
            if let email = passRequestDic["email"] as? String {
                if let latitude = passRequestDic["latitude"] as? Double{
                    if let longitude = passRequestDic["longitude"] as? Double {
                        let passLocation = CLLocation(latitude: latitude, longitude: longitude)
                        let driverCLLocation = CLLocation(latitude: driverLocation.latitude, longitude: driverLocation.longitude)
                        let distance = passLocation.distance(from: driverCLLocation) / 1000
                        
                        if let image = UIImage(named: "defaultProfileImage"){
                            let passDescription = "\(distance) KM away."
                            cell.configureCell(profileImage: image, email: email, detail: passDescription)
                        }
                    }
                }
            }
        }
        
        return cell
        
    }
    

    

}
