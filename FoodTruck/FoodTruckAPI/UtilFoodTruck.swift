//
//  UtilFoodTruck.swift
//  FoodTruck
//
//  Created by Shashi Kant on 1/30/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import UIKit

class UtilFoodTruck {

   public func getTimeAsNumberOfMinutes(time: String)->Int{
          let timeParts = time.components(separatedBy: ":")
          let timeInMinutes = (Int((timeParts[0]))! * 60) + Int(timeParts[1])!
          return timeInMinutes
      }
    
}
