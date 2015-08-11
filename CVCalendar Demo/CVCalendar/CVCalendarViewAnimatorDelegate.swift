//
//  CVCalendarViewAnimatorDelegate.swift
//  CVCalendar
//


import UIKit

@objc
protocol CVCalendarViewAnimatorDelegate {
    func animateSelection(dayView: CVCalendarDayView, withControlCoordinator coordinator: CVCalendarDayViewControlCoordinator)
    func animateDeselection(dayView: CVCalendarDayView, withControlCoordinator coordinator: CVCalendarDayViewControlCoordinator)
}