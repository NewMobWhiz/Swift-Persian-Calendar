//
//  ViewController.swift
//  CVCalendar Demo
//


import UIKit
import Foundation

class ViewController: UIViewController, CVCalendarViewDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var daysOutSwitch: UISwitch!
    
    @IBOutlet weak var table: UITableView!
    var shouldShowDaysOut = true
    var animationFinished = true
    let months = ["Farvardin", "Ordibehesht", "Khordad", "Tir", "Mordad", "Shahrivar", "Mehr", "Aban", "Azar", "Day", "Bahman", "Esfand"]
    let weeks = [ "Shanbeh", "Yek shanbeh", "Doshanbeh", "Seshhanbeh", "Chaharshanbeh", "Panjshanbeh", "Jomeh"]
    /// put the holidays name
    let holidays = ["Noruz", "mehrgan", "Sinzdah Be Dar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = CVDate(date: NSDate()).description()
        self.shouldShowDaysOut = false
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "present-100"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("menuClicked")) as UIBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.calendarView.commitCalendarViewUpdate()
        self.menuView.commitMenuViewUpdate()
    }
    let textCellIdentifier = "TextCell"
    // MARK: - IB Actions
    func menuClicked(){
        NSLog("Nav Button Clicked!")
        self.calendarView.toggleTodayMonthView()
    }
    
    @IBAction func switchChanged(sender: UISwitch) {
        if sender.on {
            self.calendarView!.changeDaysOutShowingState(false)
            self.shouldShowDaysOut = true
        } else {
            self.calendarView!.changeDaysOutShowingState(true)
            self.shouldShowDaysOut = false
        }
    }
    
    @IBAction func todayMonthView() {
        self.calendarView.toggleTodayMonthView()
    }
    
    // MARK: Calendar View Delegate
    
    func shouldShowWeekdaysOut() -> Bool {
        return self.shouldShowDaysOut
    }
    
    func didSelectDayView(dayView: CVCalendarDayView) {
        // TODO:
        let click_month:Int = dayView.date!.month!
        let click_day:Int = dayView.date!.day!
        let click_year:Int = dayView.date!.year!
        println("click_ \(click_month)_\(click_day)_\(click_year)")
        var sectionNum: Int
        if click_month > 7 {
            sectionNum  = 31 * 6 + (click_month - 7) * 30 + click_day - 1
        }else{
            sectionNum  = (click_month - 1)  * 31 + click_day - 1
        }
        if (self.numberOfSectionsInTableView(table) > 0) {
            var top = NSIndexPath(forRow: Foundation.NSNotFound, inSection: sectionNum)
            self.table.scrollToRowAtIndexPath(top, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        }
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> UIColor {
//        if dayView.date?.day == 3 {
//            return .redColor()
//        } else if dayView.date?.day == 5 {
//            return .blackColor()
//        } else if dayView.date?.day == 2 {
//            return .blueColor()
//        }
        
        return .clearColor()
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        if dayView.date?.day == 3 || dayView.date?.day == 5 || dayView.date?.day == 2 {
            return true
        } else {
            return false
        }
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    
    func presentedDateUpdated(date: CVDate) {
        self.navigationItem.title = date.description()
    }
    
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        let calendarManager = CVCalendarManager.sharedManager
        let components = calendarManager.componentsForDate(NSDate()) // from today ///Not
        println("components?!?!?!?! = \(components)")
        components.month += offset
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.calendarView.toggleMonthViewWithDate(resultDate)
    }
    /////////////////////////////////////////////////////////////////////////
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 366
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        var row = indexPath.section
        // Put the holidays here
        switch (row) {
        case 0...3:
            cell.textLabel?.text = holidays[0]
            
        case 12:
            cell.textLabel?.text = holidays[2]
            //return sectionHeaderView
        default:
            cell.textLabel?.text = "No Event"
        }
        
        return cell
    }
    
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as CustomHeaderCell
        headerCell.backgroundColor = UIColor.cyanColor()
        
        var monthNum, dayNum : Int
        if section < 186 {
            monthNum = (section + 1) / 31 + 1
            dayNum = (section + 1) % 31
            if dayNum == 0 {
                dayNum = 31; monthNum -= 1
            }
        }else{
            monthNum = (section + 1 - 186) / 30 + 7
            dayNum = (section + 1 - 186) % 30
            if dayNum == 0 {
                dayNum = 30; monthNum -= 1
            }
        }
        let weekNum = section % 7;
        headerCell.headerLabel.text = " \(weeks[weekNum]), \(dayNum)  \(months[monthNum - 1])"
        return headerCell
    }
}