//
//  CalendarViewController.swift
//  eventCal
//
//  Created by Alex Lundquist on 5/3/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import UIKit
import JTAppleCalendar

protocol ScheduleDelegate:class {
  func scheduledEvents(_ eventDay: Date)
}

class CalendarViewController: UIViewController {
  
  @IBOutlet var calendarView: JTAppleCalendarView!
  @IBOutlet weak var monthYear: UILabel!
  
  
  var calendarDataSource: [String] = []
  var sourceFormatter: DateFormatter{
    let sourceFormatter = DateFormatter()
    sourceFormatter.dateFormat = "dd-MMM-yyyy"
    return sourceFormatter
  }
  
  var calDate: Date?
  weak var eventDelegate: ScheduleDelegate?
  var calendarToParent: CalendarViewController?
  override func viewDidLoad() {
    super.viewDidLoad()
    calendarView.scrollDirection = .horizontal
    calendarView.scrollingMode = .stopAtEachCalendarFrame
    calendarView.showsHorizontalScrollIndicator = false
    showToday(animate: false)
    populateDataSource()
  }
  
  func populateDataSource(){
    calendarDataSource = [
      "10-May-2019",
      "18-May-2019",
      "22-May-2019",
      "31-May-2019",
      "03-Jun-2019",
      "04-Jun-2019"
    ]
    calendarView.reloadData()
  }
  var currentMonthlySymbol: String{
    get {
      let startDate = (calendarView.visibleDates().monthDates.first?.date)!
      let month = Calendar.current.dateComponents([.month], from: startDate).month!
      let monthString = DateFormatter().monthSymbols[month-1]
      return monthString
    }
  }
  
  func setupViewsOfCalendar(from visibleDates: DateSegmentInfo){
    guard let startDate = visibleDates.monthDates.first?.date else {return}
    let year = Calendar.current.component(.year, from: startDate)
    monthYear.text = "\(currentMonthlySymbol) \(year)"
  }
  
  func configureCell(view: JTAppleCell?, cellState: CellState) {
    guard let cell = view as? DateCell  else { return }
    cell.dateLabel.text = cellState.text
    handleCellTextColor(cell: cell, cellState: cellState)
    handleCellEvents(cell: cell, cellState: cellState)
    handleCellSelected(cell: cell, cellState: cellState)
  }
  
  func handleCellTextColor(cell: DateCell, cellState: CellState) {
    if cellState.dateBelongsTo == .thisMonth {
      cell.isHidden = false
      if cellState.day == .sunday || cellState.day == .saturday {
        cell.dateLabel.textColor = UIColor.lightGray
      }else{
        cell.dateLabel.textColor = UIColor.black
      }
      cell.layer.borderWidth = 0.5
    } else {
      cell.isHidden = true
      cell.dateLabel.textColor = UIColor.lightGray
    }
    if Calendar.current.isDateInToday(cellState.date) {
      if cellState.isSelected {
        cell.dateLabel.textColor = UIColor.white
      }else{
        cell.dateLabel.textColor = UIColor.red
      }
    }
  }
  
  func handleCellEvents(cell: DateCell, cellState: CellState) {
    let dateString = sourceFormatter.string(from: cellState.date)
    if calendarDataSource.contains(dateString){
      cell.dotView.isHidden = false
    } else {
      cell.dotView.isHidden = true
    }
  }//End of Function
  
  func handleCellSelected(cell: DateCell, cellState: CellState){
    if cellState.isSelected{
      cell.selectedView.layer.cornerRadius = 13
      cell.selectedView.isHidden = false
      cell.dateLabel.textColor = UIColor.white
      eventDelegate?.scheduledEvents(_ : cellState.date)
      
    }else{
      cell.selectedView.isHidden = true
    }
  }
}//End of Class

//MARK: -Extensions
//Helpers
extension CalendarViewController {
  func select(onVisibleDates visibleDates: DateSegmentInfo) {
    guard let firstDateInMonth = visibleDates.monthDates.first?.date else
    { return }
    if firstDateInMonth.isThisMonth() {
      calendarView.selectDates([Date()])
    } else {
      calendarView.selectDates([firstDateInMonth])
    }
  }
  
}
//ViewController
extension CalendarViewController {
  @objc func showTodayWithAnimated(){
    showToday(animate: true)
  }
  func showToday(animate: Bool) {
    calendarView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: animate, preferredScrollPosition: nil, extraAddedOffset: 0) { [unowned self] in
      //      self.getSchedule()
      self.calendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
        self.setupViewsOfCalendar(from: visibleDates)
      }
      self.calendarView.selectDates([Date()])
    }
  }
}
//Calendar DataSource
extension CalendarViewController: JTAppleCalendarViewDataSource {
  func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
    let calFormatter = DateFormatter()
    calFormatter.dateFormat = "dd MM yyyy"
    calFormatter.timeZone = Calendar.current.timeZone
    calFormatter.locale = Calendar.current.locale
    let startDate = calFormatter.date(from: "01 01 1920")!
    let endDate =  calFormatter.date(from: "31 12 2099")!
    let configParameters = ConfigurationParameters(startDate: startDate,
                                                   endDate: endDate,
                                                   calendar: Calendar.current,
                                                   generateInDates: .forAllMonths,
                                                   generateOutDates: .tillEndOfGrid,
                                                   firstDayOfWeek: .sunday,
                                                   hasStrictBoundaries: true)
    return configParameters
  }
  
}//End of Cal DataSource

//Calendar Delegate
extension CalendarViewController: JTAppleCalendarViewDelegate {
  func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
    let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
    self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
    return cell
  }
  func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
    setupViewsOfCalendar(from: visibleDates)
    if visibleDates.monthDates.first?.date == calDate {return}
    calDate = visibleDates.monthDates.first?.date
    //    getSchedule()
    select(onVisibleDates: visibleDates)
    //    select(visibleDates)
  }
  func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
    configureCell(view: cell, cellState: cellState)
  }
  func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell? , cellState: CellState){
    configureCell(view: cell, cellState: cellState)
  }
  func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState){
    configureCell(view: cell, cellState: cellState)
  }
  
}//End of Cal Delegate

