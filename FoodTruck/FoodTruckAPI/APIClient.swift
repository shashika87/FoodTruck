//
//  APIClient.swift
//  FoodTruck
//
//  Created by Shashi Kant on 1/29/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import UIKit

class APIClient: NSObject {

    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func getHttpFoodTrucK(requestURL: String,  completion: @escaping ([FoodTruckItem])->()) -> Void{
       let url = URL(string: requestURL)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            do {
                //let str = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments)
                //print(str)
                let data  = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? Array<Dictionary<String, Any>>

                //let firstElement: Dictionary<String, Any> = data!.first!
                var  resultArray : [FoodTruckItem] = [];
                for case let result in data! {
                    let location2 : NSDictionary = result["location2"] as? NSDictionary ?? ["type":"","coordinates":[0.0]]
                    let type = location2["type"] as! String;
                    let coordinates : [Double] = location2["coordinates"] as! [Double];
                    let foodTruckItem = FoodTruckItem(dayorder: result["dayorder"] as? String, dayofweekstr: result["dayofweekstr"] as? String, starttime: result["starttime"] as? String, endtime: result["endtime"] as? String, permit: result["permit"] as? String, location: result["location"] as? String, locationdesc: result["locationdesc"] as? String, optionaltext: result["optionaltext"] as? String, locationid: result["locationid"] as? String, start24: result["start24"] as? String, end24: result["end24"] as? String, cnn: result["cnn"] as? String, addrDateCreate: result["addr_date_create"] as? String, addrDateModified: result["addr_date_modified"] as? String, block: result["block"] as? String, lot: result["lot"] as? String, coldtruck: result["coldtruck"] as? String, applicant: result["applicant"] as? String, x: result["x"] as? String, y: result["y"] as? String, latitude: result["latitude"] as? String, longitude: result["longitude"] as? String, location2: Location2(type:type , coordinates: coordinates))
                    
                        //print("json : \(foodTruckItem)")
                    resultArray.append(foodTruckItem);
                      
                   }
                
                completion(resultArray)
                

            } catch {
                print("json error: \(error)")
            }
         
        }
        task.resume()
    }
}
