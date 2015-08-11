//
//  CVDate.swift
//  CVCalendar
//

import UIKit

class CVDate: NSObject {
    private let date: NSDate?
    let year: Int?
    let month: Int?
    let week: Int?
    let day: Int?
    let months = ["Farvardin", "Ordibehesht", "Khordad", "Tir", "Mordad", "Shahrivar", "Mehr", "Aban", "Azar", "Day", "Bahman", "Esfand"]
    init(date: NSDate) {
        super.init()
        
        let calendarManager = CVCalendarManager.sharedManager
        
        self.date = date
        
        self.year = calendarManager.dateRange(date).year
        self.month = calendarManager.dateRange(date).month
        self.day = calendarManager.dateRange(date).day
    }
    
    init(day: Int, month: Int, week: Int, year: Int) {
        super.init()
        
        self.year = year
        self.month = month
        self.week = week
        self.day = day
    }
    
    func description() -> String {

        let myMonth:Int = self.month!
        let monthStr = self.months[myMonth - 1]
        
        return "\(monthStr), \(self.year!)"
    }
    func convertToPersian() ->NSDate{
        let calendar = NSCalendar(identifier: NSCalendarIdentifierPersian)!///
        let components = calendar.components(NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit, fromDate: date!)
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let myMonth:Int = components.month
        let myYear:Int = components.year
        let myDay:Int = components.day
        let str = dateFormater.dateFromString("\(myYear)-\(myMonth)-\(myDay)")!
        
        return str
    }
}
