//
//  Helpers.swift
//  InstagramUITests
//
//  Created by Gopinadh Cherupally on 2/27/20.
//  Copyright © 2020 Robert Percival. All rights reserved.
//

import Foundation

//XCUIApplication+TapCoordinate.swift
import XCTest



extension XCUIApplication {



   /**

    *  This function will tap at the given co-ordinate

    *

    *  - Parameter xCoordinate: x-cordinate value

    *  - Parameter yCoordinate: y-cordinate value

    */

   func tapCoordinate(at xCoordinate: Double, and yCoordinate: Double) {

       let normalized = XCUIApplication().coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))

       let coordinate = normalized.withOffset(CGVector(dx: xCoordinate, dy: yCoordinate))

       coordinate.tap()

   }

}

//2) XCUIElement+GentleSwipe.swift
 import Foundation

import XCTest



extension XCUIElement

{

   enum direction : Int {

       case up, down, left, right

   }

   

   func gentleSwipe(_ direction : direction) {

       let half : CGFloat = 0.5

       let adjustment : CGFloat = 0.25

       let pressDuration : TimeInterval = 0.05

       

       let lessThanHalf = half - adjustment

       let moreThanHalf = half + adjustment

       

       let centre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: half))

       let aboveCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: lessThanHalf))

       let belowCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: moreThanHalf))

       let leftOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: lessThanHalf, dy: half))

       let rightOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: moreThanHalf, dy: half))

       

       switch direction {

       case .up:

           centre.press(forDuration: pressDuration, thenDragTo: aboveCentre)

           break

       case .down:

           centre.press(forDuration: pressDuration, thenDragTo: belowCentre)

           break

       case .left:

           centre.press(forDuration: pressDuration, thenDragTo: leftOfCentre)

           break

       case .right:

           centre.press(forDuration: pressDuration, thenDragTo: rightOfCentre)

           break

       }

   }

}

//3) XCUIElement+Waiters.swift
import XCTest
 

 
extension XCUIElement {
 

 
   /**
 
    *  Asserts that the element can eventually be tapped within the given `timeout`
 
    */
 
   func assertEventuallyHittable(within timeout: TimeInterval) {
 
       self.assertPredicate(format: "isHittable == true", timeout: timeout)
 
   }
 

 
   /**
 
    *  Asserts that the element is eventually dismissed before the given `timeout`
 
    */
 
   func assertEventuallyDismissed(timeout: TimeInterval) {
 
       self.assertPredicate(format: "exists == false", timeout: timeout)
 
   }
 

 
   /**
 
    *  Asserts that the element eventually exists before the given `timeout`
 
    */
 
   func assertEventuallyExists(timeout: TimeInterval) {
 
       self.assertPredicate(format: "exists == true", timeout: timeout)
 
   }
 

 
   /**
 
    *  Asserts that the predicate is eventually true before `timeout`
 
    */
 
   private func assertPredicate(format: String, timeout: TimeInterval) {
 
       let waiter = XCTWaiter()
 
       let predicate = NSPredicate(format: format)
 
       let expectation = XCTNSPredicateExpectation(predicate: predicate,
 
                                                   object: self)
 

 
       waiter.wait(for: [expectation], timeout: timeout)
 
   }
 
}
 
// 4)XCUIElement+isOnOff.swift
import XCTest
 
 
 
extension XCUIElement {
 
   
 
   public func assertIsOn() {
 
       guard let value = self.value as? String else{
 
           XCTFail("Expected type String. Got \(type(of: self.value))")
 
           return
 
       }
 
       
 
       XCTAssertEqual(value, "1", "Expected the switch to be in the on position")
 
   }
 
   
 
   public func assertIsOff() {
 
       guard let value = self.value as? String else{
 
           XCTFail("Expected type String. Got \(type(of: self.value))")
 
           return
 
       }
 
       
 
       XCTAssertEqual(value, "0", "Expected the switch to be in the off position")
 
   }
 
}
 
 
 
 //   5) XCUIElementQuery+ContainingLabel.swift
 import XCTest
 
 
 
extension XCUIElementQuery {
 
 
 
   /**
 
    *  Returns the decendent element with a containing label
 
    */
 
   public func findElement(containingLabel label: String) -> XCUIElement {
 
       let predicate = NSPredicate(format: "label contains[c] %@", "\(label)")
 
       let element = self.element(matching: predicate)
 
 
 
       return element
 
   }
 
}
 
// 6) XCUIElementQuery+IdentifierPrefix.swift
 
import XCTest
extension XCUIElementQuery {
 
 
 
   /**
 
    *  Returns the decendant element with a matching identifier prefix
 
    */
 
   public func element(matchingIdentifierWithPrefix prefix: String) -> XCUIElement {
 
       let predicate = NSPredicate(format: "identifier BEGINSWITH \"\(prefix)\"")
 
       let element = self.element(matching: predicate)
 
 
 
       return element
 
   }
 
 
 
   /**
 
    *  Returns the decendant element with a matching label prefix
 
    */
 
   public func element(matchingLabelWithPrefix prefix: String) -> XCUIElement {
 
       let predicate = NSPredicate(format: "label BEGINSWITH \"\(prefix)\"")
 
       let element = self.element(matching: predicate)
 
 
 
       return element
 
   }
 
   
 
   /**
 
    *  Returns the decendant element with a matching value prefix
 
    */
 
   public func element(matchingValueWithPrefix prefix: String) -> XCUIElement {
 
       let predicate = NSPredicate(format: "value BEGINSWITH \"\(prefix)\"")
 
       let element = self.element(matching: predicate)
 
       
 
       return element
 
   }
 
}
 
//Helper
   /**
 
    *  Adds a custom interruption handler for accepting system alerts potentially caused by some `actions`
 
    */
 
   public func acceptingSystemPermissions(actions: () -> Void) {
 
       let handler = { (alert: XCUIElement) -> Bool in
 
           if alert.buttons["Always Allow"].exists {
 
               alert.buttons["Always Allow"].tap()
 
           }
 
           else if alert.buttons["Allow"].exists {
 
               alert.buttons["Allow"].tap()
 
           }
 
           else {
 
               return false
 
           }
 
 
 
           return true
 
       }
 
 
 
 //      let monitor = self.addUIInterruptionMonitor(withDescription: "Accepting alerts",
 
                                                   //handler: handler)
 
       
 
       defer {
 
 //          self.removeUIInterruptionMonitor(monitor)
 
       }
 
       
 
       actions()
 
   }
 
 
 
 
//Simulating locations :
//https://willowtreeapps.com/ideas/simulating-location-in-ios
                                                                                                  
 
 
                                                                                                  
 
                                                                                              
 
                                                                                                 
 


