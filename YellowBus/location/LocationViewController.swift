//
//  LocationViewController.swift
//  YellowBus
//
//  Created by mac on 04/08/2021.
//

import UIKit
import MapKit
import GoogleMaps
import Alamofire

import CoreLocation
import Firebase




class LocationViewController: UIViewController , MKMapViewDelegate {
    
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
 //   var mylatitude : Double?
   // var mylongitude : Double?
    var currentLoc: CLLocation!
    var bus = "device1"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestWhenInUseAuthorization()
          
           locationManager.startUpdatingLocation()
           locationManager.delegate = self
       
        
      

        // Do any additional setup after loading the view.
        
        //mOrigin = new LatLng(5.557246813101563, -0.2077639590833517);
       
        // Create a GMSCameraPosition that tells the map to display the
                // coordinate -33.86,151.20 at zoom level 6.
               
        

                // Creates a marker in the center of the map.
             /*   let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: 5.557246813101563, longitude: -0.2077639590833517)
                marker.title = "Bus is Here"
                marker.snippet = "Accra"
                marker.map = mapView*/
        
        
        
        //set delegate for mapview
         //       self.mapView.delegate = self
   

    }
    
    func setUpMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D){
        
        let camera = GMSCameraPosition.camera(withLatitude: 5.557246813101563, longitude: -0.2077639590833517, zoom: 15.0)

         mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        
      
        
        //set markers on the two locations
        let m1 = GMSMarker.init(position: pickupCoordinate)
        m1.title = "Bus is Here"
        m1.icon = GMSMarker.markerImage(with: UIColor.green)
              
    //    let userData = m1.userData as? [String:String]
   //     print("marker.userData.name": \(userData["name"])
        
        m1.map = mapView
        let m2 = GMSMarker.init(position: destinationCoordinate)
        m2.map = mapView
        
        mapView.selectedMarker=m1

        //find route
        showRouteOnMap(pickupCoordinate: pickupCoordinate, destinationCoordinate: destinationCoordinate)
    }
    
    
    func getBusLoc(){
        let busLocation = Database.database().reference().child("location")
         
        busLocation.child(bus).observeSingleEvent(of: .value, with: { [self] ( snapshot) in
         if(snapshot.exists()){
            if let dict = snapshot.value as? [String: Any]{
                
               // let latitude  = dict["latitude"] as? String
               // let longitude  = dict["longitude"] as? String
             
                currentLoc = locationManager.location
                
                let mylatitude = currentLoc.coordinate.latitude
                let mylongitude = currentLoc.coordinate.longitude
                
               
                

                
                let busLatitude = 5.557246813101563
                let busLongitude = -0.2077639590833517
                
                
             
                let loc1 = CLLocationCoordinate2D.init(latitude: busLatitude, longitude: busLongitude)
                let loc2 = CLLocationCoordinate2D.init(latitude: mylatitude, longitude: mylongitude)
                
               
                setUpMap(pickupCoordinate:loc1,destinationCoordinate:loc2)
                
                
            }


             
             
             
         }else{
           
             return
         }
     })
    }
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {

        let origin = "\(pickupCoordinate.latitude),\(pickupCoordinate.longitude)"
        let destination = "\(destinationCoordinate.latitude),\(destinationCoordinate.longitude)"

        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyC8mQYYnhQ81nGab4WHQmYrVsteY996Ylc"

    /*    AF.request(url).responseSwiftyJSON { response in

            if let json = response.result.value {
                if let routes = json["routes"].array {
                    if let route = routes.first {

                        let routeOverviewPolyline = route["overview_polyline"].dictionary
                        let points = routeOverviewPolyline?["points"]?.string
                        if let path = GMSPath.init(fromEncodedPath: points!) {
                            self.setPath(path: path)
                        }
                    }
                }
            }
        }*/
        
        /*   "routes" : [
            "overview_polyline" : {
                       "points" : "wi|`@pqg@@kBGGo@AkBEBpCDzC~GcAAVEdACnAFdCCjEGtD?j@p@IlCe@V@H@LHRr@`@rAzAdDJb@Jz@?v@ATSzAY~A{@nCKd@G|@KlBEh@c@zBa@hBUrAaAjFi@~AgHfNeKfS{C|F?HEJ_A`BuBfEwA`D_D`GGDMRs@xAcA~BkBfDyCzF}@dBkChF}HlO
            }
            
            }
            ]


*/
        
        struct Route :Codable
        {
            var routes: [Polyline]
            
        }
        
        struct Polyline :Codable
        {
            var overview_polyline: Points
            
        }
        
        struct Points :Codable
        {
            var points: String
            
        }
        
        AF.request(url).responseJSON { response in
            
            guard let data = response.data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                    let line = try decoder.decode(Route.self, from: data)
                
                if let route = line.routes.first{
                    
                    let routeOverviewPolyline = route.overview_polyline
                    let points = routeOverviewPolyline.points
                    
                    if let path = GMSPath.init(fromEncodedPath: points) {
                        self.setPath(path: path)
                    }
                    
                }
              
            } catch {
                
                
            }
            
     

              
            }
        
        
    }
    
    func setPath(path: GMSPath) {

        var polyline = GMSPolyline.init(path: path)
        polyline.strokeColor = UIColor.red
        polyline.strokeWidth = 5
        polyline.map = self.mapView

        var bounds = GMSCoordinateBounds()

        for index in 1...path.count() {
            bounds = bounds.includingCoordinate(path.coordinate(at: index))
        }

        self.mapView.moveCamera(GMSCameraUpdate.fit(bounds))

        //optional - get distance of the route in kms!
        let mtrs = GMSGeometryLength(path)
      //  dist = mtrs/1000.0
       // print("The distance of the route is \(dist) km")
        
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
extension LocationViewController: CLLocationManagerDelegate {
    // Handle authorization for the location manager.
      func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Check accuracy authorization
       
        

        // Handle authorization status
        switch status {
        case .restricted:
          print("Location access was restricted.")
        case .denied:
          print("User denied access to location.")
          // Display the map using the default location.
          mapView.isHidden = false
        case .notDetermined:
          print("Location status not determined.")
        case .authorizedAlways:
           // fallthrough
            getBusLoc()
            
        case .authorizedWhenInUse:
          print("Location status is OK.")
            getBusLoc()
            
            
        @unknown default:
          fatalError()
        }
      }

      // Handle location manager errors.
      func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
      }
    
}

