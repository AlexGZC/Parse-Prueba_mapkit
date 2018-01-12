//
//  GeneralAttributes.swift
//  AppCelulas
//
//  Created by elaniin on 11/6/17.
//  Copyright © 2017 elaniin. All rights reserved.
//

import Foundation
import UIKit

class GeneralAttributes{
    
    
    
    
    //Fill with a custom Message Alert
    static func showAlertMessage(titleStr:String, messageStr:String,fromController controller: UIViewController) -> Void {
        let alertController = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        //...
        controller.present(alertController, animated: true, completion: nil)
    }
    
    //Color
    static func itembarbackground(controller: UIViewController){
   
        controller.navigationController?.navigationBar.barStyle = UIBarStyle.blackOpaque
        controller.navigationController?.navigationBar.isTranslucent = false
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()
        controller.navigationController?.navigationBar.barTintColor  = UIColor.white
        let titleDict: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.black]
        controller.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedStringKey : Any]
      
    }
    
    //Color
    static func itembarbackground2(controller: UIViewController, color: UIColor){
        
        controller.navigationController?.navigationBar.barStyle = UIBarStyle.blackOpaque
        controller.navigationController?.navigationBar.isTranslucent = true
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationController?.view.backgroundColor = color
        controller.navigationController?.navigationBar.shadowImage = UIImage()
        controller.navigationController?.navigationBar.barTintColor  = UIColor.white
        let titleDict: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.black]
        controller.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedStringKey : Any]
        
    }
    
    
    //Color
    static func circlebutton(imageview: UIImageView){
        imageview.layoutIfNeeded()
        imageview.layer.cornerRadius = imageview.frame.size.width / 2
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = imageview.frame.size.width / 2;
        imageview.clipsToBounds = true;
        
    }
    
    static func circlebutton2(imageview: UIButton){
        imageview.layoutIfNeeded()
        imageview.layer.cornerRadius = imageview.frame.size.width / 2
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = imageview.frame.size.width / 2;
        imageview.clipsToBounds = true;
        
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
    
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func buttonimagecolor(image: UIImage,color: UIColor, button: UIButton){
        button.setImage(image, for: .normal)
        button.tintColor = color
        button.contentMode = .scaleAspectFit
    }
    
    static func loadImageFromUrl(url: String, view: UIImageView){
        
        
        // Create Url from string
        let url = NSURL(string: url)!
        
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        let task = URLSession.shared.dataTask(with: url as URL) { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
            if let data = responseData{
                
                // execute in UI thread
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data)
                    
                    view.image = image
                    
                    
                })
            }
        }
        
        // Run task
        task.resume()
    }
    
 
    
}
