//
//  CalendarParentViewController.swift
//  handle
//
//  Created by Alex Lundquist on 5/8/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarParentViewController: UIViewController {

  @IBOutlet weak var dateLabel: UILabel!
  
  var eventDate: String = ""
  let eventStatic = [
    "10-May-2019": ["11:23":"This is something that is due"],
    "18-May-2019": ["05:35":"Posting to FaceBook", "08:45":"Posting To Twitter", "14:15":"Afternoon Facebook Post"],
    "22-May-2019": ["12:00":"The Nooner Post"],
    "31-May-2019": ["10:00":"Graduation Post YEHAW", "17:30":"Going Home Post"],
    "03-Jun-2019": ["09:00":"Fist Day on the Job Post", "13:00":"Twitter: What they fed us for lunch", "18:15":"Instagram: Pics from the Bar"],
    "04-Jun-2019": ["10:35":"FaceBook: Overcoming hangovers at work", "14:45":"Twitter: Bottles of Ibuprofen can't cure this headache"]]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  var eventDetails: [String:String] = [:]
  struct Events {
    var times: String
    var someText: String
  }
  var eventArray = [Events]()
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "calendarSegue" {
      let calendar = segue.destination as? CalendarViewController
      calendar?.eventDelegate = self
    }
  }
}//end of class

extension CalendarParentViewController: UITableViewDelegate, UITableViewDataSource, ScheduleDelegate{
  
  func scheduledEvents(_ eventDay: Date){
    let eventDate = eventDay.dateStamp(stampFormat: eventDay)
    print("\(eventDay)")
//    dateLabel.text = eventDate
    eventStatic[eventDate]?.forEach({ do { eventArray.append(Events(times: $0, someText: $1)) } })
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return eventDetails.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "scheduledCell", for: indexPath) as! EventTableViewCell
    return cell
  }
  
  
}
