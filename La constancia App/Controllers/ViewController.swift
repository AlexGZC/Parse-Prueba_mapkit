//
//  ViewController.swift
//  La constancia App
//
//  Created by elaniin on 1/11/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import SwiftyBeaver

class ViewController: UIViewController {

    var array = [Places]()
    var s = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftyBeaver.debug(s)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func CERRAR(_ sender: Any) {
        DispatchQueue.main.async(execute: {
            self.dismiss(animated: true) {
                
            }})
    }
    

}
