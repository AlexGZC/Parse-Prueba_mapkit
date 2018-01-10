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

class MapViewController: UIViewController{

    @IBOutlet weak var mapkit: MKMapView!
    var array = [Places]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        GetAPIManager.Get("http://demo8323091.mockable.io/", success: { (response) in
            
           
            if let resData = response.arrayObject as? [[String: Any]] {
               
                self.array = resData.map(Places.init)
                //SwiftyBeaver.error("siiiiii:   "+resData.description)
                
                
            }
            
            
            for i in self.array{
                SwiftyBeaver.debug(i.info.description)
                
                let location = CLLocationCoordinate2DMake((i.lat) , (i.long))
                let span = MKCoordinateSpanMake(10.0, 10.0)
                let region = MKCoordinateRegionMake(location, span)
                self.mapkit.setRegion(region, animated: true)
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = i.name
                self.mapkit.addAnnotation(annotation)
            }

           
            
            
        }) { (error) in
            
        }
   
        
        
        /*
        Alamofire.request("http://demo8323091.mockable.io/")
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    
                    
                    SwiftyBeaver.error("error calling POST on /todos/1")
                    SwiftyBeaver.error(response.result.error!)
                    return
                }
                
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get object as JSON from API")
                    
                    SwiftyBeaver.error("didn't get object as JSON from API")
                    SwiftyBeaver.error("Error: \(String(describing: response.result.error))")
                    
                    return
                }
                // get and print the title
                guard let token2 = json["lat"] as? Double else {
                    print("Could not get todo title from JSON")
                    
                    return
                }
                
                // get and print the title
                guard let token = json["info"] as? [String: Any]  else {
                    print("Could not get todo title from JSON")
                    
                    return
                }
                
                
                
                SwiftyBeaver.info("Token: \(token2)")
                
              
                
        }
        */

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
