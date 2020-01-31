//
//  ViewController.swift
//  FoodTruck
//
//  Created by Shashi Kant on 1/28/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate  {

     var foodTrucksArray : [FoodTruckItem]!
    var selectedFoodTruck : FoodTruckItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var addressLabel: UILabel?
    @IBOutlet weak var menuLabel: UILabel?
    @IBOutlet weak var hoursLabel: UILabel?
    
    var selectedAnnotation :MKPointAnnotationCustom?
    var locationId :String!

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title="Food Trucks";
        if( foodTrucksArray.count > 0){
            for i in 0 ... foodTrucksArray.count-1 {
                let foodTruckItem : FoodTruckItem = foodTrucksArray[i];
            
                let foodTruckLocation = MKPointAnnotationCustom(locationId: foodTruckItem.locationid!)
                foodTruckLocation.title = foodTruckItem.applicant
                foodTruckLocation.coordinate = CLLocationCoordinate2D(latitude: Double(foodTruckItem.latitude!)!, longitude: Double(foodTruckItem.longitude!)!)
                if( locationId != nil && foodTruckLocation.locationId == locationId){
                    self.selectedAnnotation = foodTruckLocation
                }
                self.mapView.addAnnotation(foodTruckLocation)
        }
        
        
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        
        if locationId != nil {
            self.mapView.selectAnnotation(self.selectedAnnotation!, animated: true);
        }
        }
        navigationItem.hidesBackButton = true
        
        let listBarButton : UIBarButtonItem = UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(barButtonItemListClicked(sender:)))
        self.navigationItem.setRightBarButton(listBarButton, animated: true)

    }
    
    @objc func barButtonItemListClicked(sender: UIBarButtonItem)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
         guard annotation is MKPointAnnotation else { return nil }

         let identifier = "Annotation"
         var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

         if annotationView == nil {
             annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
             annotationView!.canShowCallout = true
         } else {
             annotationView!.annotation = annotation
         }
         return annotationView
     }
    
    

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //var locationid =  view.value(forKey: "locationId")
        let selectedAnnotation = view.annotation as! MKPointAnnotationCustom
        let locationId = selectedAnnotation.locationId!
        let foodTruckItem = (self.foodTrucksArray.first { $0.locationid == locationId})!
         self.nameLabel?.text = foodTruckItem.applicant
         self.addressLabel?.text = foodTruckItem.location
         self.addressLabel?.text = self.addressLabel?.text?.uppercased();
         self.menuLabel?.text = foodTruckItem.optionaltext
         self.hoursLabel?.text = "\(foodTruckItem.starttime!) - \(foodTruckItem.endtime!)"
         //print(foodTruckItem)
    }

}


class MKPointAnnotationCustom : MKPointAnnotation{
    var locationId : String!
    
    init(locationId: String) {
         self.locationId = locationId
    }
}
