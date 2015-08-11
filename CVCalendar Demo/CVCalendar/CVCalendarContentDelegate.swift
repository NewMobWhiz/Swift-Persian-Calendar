//
//  CVCalendarContentDelegate.swift
//  CVCalendar Demo
//


import UIKit

protocol CVCalendarContentDelegate {
    func updateFrames()
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    func scrollViewDidScroll(scrollView: UIScrollView)
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    
    func performedDayViewSelection(dayView: CVCalendarDayView)
    
    func presentNextView(dayView: CVCalendarDayView?)
    func presentPreviousView(dayView: CVCalendarDayView?)
    
    func updateDayViews(hidden: Bool)
    
    func togglePresentedDate(date: NSDate)
}