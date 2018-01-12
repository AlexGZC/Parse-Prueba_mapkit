//
//  MapViewController.swift
//  La constancia App
//
//  Created by elaniin on 1/9/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyBeaver
import SwiftyJSON
import NVActivityIndicatorView
import Kingfisher


class MapViewController: UIViewController,NVActivityIndicatorViewable, MKMapViewDelegate{

    @IBOutlet weak var mapkit: MKMapView!
    var myArray = [Int]()
    var array = [Places]()
    var a = [1,2,3]

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        GetAPIManager.Get("http://demo8323091.mockable.io/", success: { (response) in
            self.startAnimating()
           
                if let resData = response.arrayObject as? [[String: Any]] {

                self.array     = resData.map(Places.init)




                }
            
                if self.array.count > 0{
                    self.stopAnimating()
                }
            
            
                self.getAnnotations(array: self.array)

           
            
            
        }) { (error) in
            
        }
   
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getAnnotations(array:[Places]){
        for i in array{
            SwiftyBeaver.debug(i.name)
            let location = StarbucksAnnotation(coordinate: CLLocationCoordinate2D(latitude: i.lat, longitude: i.long))
            
            let span              = MKCoordinateSpanMake(10.0, 10.0)
            let region            = MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: i.lat, longitude: i.long), span)
            
            let url = NSURL(string: i.img)
            DispatchQueue.global().async {
                self.startAnimating()
                let data = try? Data(contentsOf: url! as URL) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.stopAnimating()
                    location.image = UIImage(data: data!)
                    
                }
            }
            
           // location.image =
            location.name = i.name
            location.id = i.id
            self.mapkit.setRegion(region, animated: true)
            self.mapkit.addAnnotation(location)
        }
    }
    

    @objc func connected(_ sender:AnyObject){
        
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let passSecondController = storyboard.instantiateViewController(withIdentifier: "animeDetails") as! ViewController
        SwiftyBeaver.debug(self.myArray.count.description)
        passSecondController.s = self.array[self.myArray.count].name
        present(passSecondController, animated: true , completion: nil)
        
    }

    func insertElementAtIndex(element: Int, index: Int) {
        
        
        
        myArray.insert(element, at: index)
    }

}
typealias MapViewDelegate = MapViewController
extension MapViewDelegate
{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapkit.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "ic_place")
        
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom calloutz
            return
        }
        
        
       
        
        // 2
        let placeAnnotation = view.annotation as! StarbucksAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.placeName.text = placeAnnotation.name
        calloutView.placeAddress.text = placeAnnotation.address
        calloutView.placePhone.text = placeAnnotation.phone
        calloutView.placeImage.image = placeAnnotation.image
        
        if self.mapkit.selectedAnnotations.count > 0 {
            
            if let ann = self.mapkit.selectedAnnotations[0] as? MKAnnotation {
                
                SwiftyBeaver.verbose("selected annotation: \(placeAnnotation.id)")
                calloutView.placeName.tag = placeAnnotation.id
                insertElementAtIndex(element: placeAnnotation.id, index: placeAnnotation.id)
                
                
                //do something else with ann...
            }
        }
        
        
        let button = UIButton(frame: calloutView.placeImage.frame)
        
        button.addTarget(self, action: #selector(MapViewController.connected(_:)), for: .touchUpInside)
        calloutView.addSubview(button)
        // 3
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
}



