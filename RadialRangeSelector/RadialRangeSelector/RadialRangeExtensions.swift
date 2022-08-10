//
//  RadialRangeExtensions.swift
//  RadialRangeSelector
//
//  Created by danylo.net on 8/9/22.
//
import SwiftUI

extension RadialRangeSelector {
    func changeMin(location: CGPoint) {
        let vector = CGVector(dx: location.x, dy: location.y)
        let angle = atan2(vector.dy - (knobRadius + 13.0), vector.dx - (knobRadius + 13.0)) + .pi/2.0
        let calcAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        
        let currentAngle = calcAngle * 180 / .pi
        let whichStep = Int(currentAngle / angleLength)
        let tempValue = whichStep * increment + minVal
        
        if currentAngle < maxAngleValue - angleLength/2 {
            if tempValue > minVal {
                minAngleValue = (CGFloat(whichStep) * angleLength) + angleLength/2
                minUser = tempValue
            } else if minVal >= tempValue {
                minAngleValue = angleLength/4
                minUser = minVal
            }
        } else if currentAngle > 335 {
            minAngleValue = angleLength/4
            minUser = minVal
        }
    }
    
    
    func changeMax(location: CGPoint) {
        let vector = CGVector(dx: location.x, dy: location.y)
        let angle = atan2(vector.dy - (knobRadius + 13.0), vector.dx - (knobRadius + 13.0)) + .pi/2.0
        let calcAngle = angle < 0.0 ? angle + 2.0 * .pi : angle

        let currentAngle = calcAngle * 180 / .pi
        let whichStep = Int(currentAngle / angleLength)
        let tempValue = whichStep * increment + minVal
        
        if tempValue > minUser {
            if tempValue < maxVal  {
                maxAngleValue = (CGFloat(whichStep) * angleLength) + angleLength/2
                maxUser = tempValue
            } else {
                maxUser = maxVal
                maxAngleValue = 270 - angleLength/4
            }
        }
    }
    
    
    func setup() {
        let newMinValue = (minUser - minVal) / increment
        let newMaxValue = (maxUser - minVal) / increment
        minAngleValue = (CGFloat(newMinValue) * angleLength) + angleLength/2
        maxAngleValue = (CGFloat(newMaxValue) * angleLength) + angleLength/2
    }
}



