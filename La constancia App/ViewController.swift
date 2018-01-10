//
//  ViewController.swift
//  La constancia App
//
//  Created by elaniin on 1/9/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
protocol Barker {
    func bark()
}

class GermanShephard: Barker {
    func bark() {
        print("Bark")
    }
}

class BelgianMalinois: Barker {
    func bark() {
        print("Bark!")
    }
}


protocol Prueba {
    func yell(what:String)
}

class pru: Prueba {
    func yell(what: String) {
        
        print(what)
    }
}

class ViewController: UIViewController {
let myDog = BelgianMalinois()
    let prueba = pru()
    override func viewDidLoad() {
        super.viewDidLoad()
        myDog.bark()
        prueba.yell(what: "sss")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

