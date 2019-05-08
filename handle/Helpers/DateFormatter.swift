//
//  DateFormatter.swift
//  handle
//
//  Created by Alex Lundquist on 5/8/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import Foundation

extension Date {
  
  func stringWith(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
    let stringFormatter = DateFormatter()
    stringFormatter.dateStyle = dateStyle
    stringFormatter.timeStyle = timeStyle
    return stringFormatter.string(from: self)
  }
  func isThisMonth() -> Bool {
    let monthFormatter = DateFormatter()
    monthFormatter.dateFormat = "mm-dd-yyyy"
    let dateString = monthFormatter.string(from: self)
    let currentDateString = monthFormatter.string(from: Date())
    return dateString == currentDateString
  }
  func dateStamp(stampFormat: Date )->String{
    let stampFormatter = DateFormatter()
    stampFormatter.dateFormat = "MMM-dd-yyyy"
    let eventdate = stampFormatter.string(from: stampFormat)
    return eventdate
  }
}
