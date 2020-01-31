//
//  FoodTruckItem.swift
//  FoodTruck
//
//  Created by Shashi Kant on 1/29/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import UIKit

class FoodTruckItem: NSObject {
    let dayorder, dayofweekstr, starttime, endtime: String?
    let permit, location, locationdesc, optionaltext: String?
    let locationid, start24, end24, cnn: String?
    let addrDateCreate, addrDateModified, block, lot: String?
    let coldtruck, applicant, x, y: String?
    let latitude, longitude: String?
    let location2: Location2

    enum CodingKeys: String, CodingKey {
        case dayorder, dayofweekstr, starttime, endtime, permit, location, locationdesc, optionaltext, locationid, start24, end24, cnn
        case addrDateCreate = "addr_date_create"
        case addrDateModified = "addr_date_modified"
        case block, lot, coldtruck, applicant, x, y, latitude, longitude
        case location2 = "location_2"
    }

    init(dayorder: String??, dayofweekstr: String?, starttime: String?, endtime: String?, permit: String?, location: String?, locationdesc: String?, optionaltext: String?, locationid: String?, start24: String?, end24: String?, cnn: String?, addrDateCreate: String?, addrDateModified: String?, block: String?, lot: String?, coldtruck: String?, applicant: String?, x: String?, y: String?, latitude: String?, longitude: String?, location2: Location2?) {
        self.dayorder = (dayorder ?? "")
        self.dayofweekstr = dayofweekstr ?? ""
        self.starttime = starttime ?? ""
        self.endtime = endtime ?? ""
        self.permit = permit ?? ""
        self.location = location ?? ""
        self.locationdesc = locationdesc ?? ""
        self.optionaltext = optionaltext ?? ""
        self.locationid = locationid ?? ""
        self.start24 = start24 ?? ""
        self.end24 = end24 ?? ""
        self.cnn = cnn ?? ""
        self.addrDateCreate = addrDateCreate ?? ""
        self.addrDateModified = addrDateModified
        self.block = block ?? ""
        self.lot = lot ?? ""
        self.coldtruck = coldtruck ?? ""
        self.applicant = applicant ?? ""
        self.x = x ?? ""
        self.y = y ?? ""
        self.latitude = latitude ?? ""
        self.longitude = longitude ?? ""
        self.location2 = location2 ?? Location2(type: "", coordinates: [0.0])
    }
}

// MARK: - Location2
class Location2: Codable {
    let type: String?
    let coordinates: [Double]

    init(type: String?, coordinates: [Double]) {
        self.type = type
        self.coordinates = coordinates
    }
}
