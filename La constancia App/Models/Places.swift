//
//  Places.swift
//  La constancia App
//
//  Created by elaniin on 1/10/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

struct Places {
    var lat = Double()
    var long = Double()
    var info = [String: Any]()
    var name = String()
    
    init(dictionary: [String:Any]) {
        self.lat = dictionary["lat"] as? Double ?? 0.11
        self.long = dictionary["lon"] as? Double ?? -0.11
        self.info = dictionary["info"] as? [String:Any] ?? ["error":"error"]
        self.name = dictionary["msg"] as? String ?? "My name"
    }
    
}
