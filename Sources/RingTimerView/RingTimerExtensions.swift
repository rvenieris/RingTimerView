//
//  RingTimerExtensions.swift
//  Ring Timer
//
//  Created by Ricardo Venieris on 02/11/22.
//

import Foundation

extension Double {
    func formatingOn(maxValue:Double, and precision: Double) -> String {
        let d = "\(maxValue.exponent)".count
        let n = "\(precision)".split(separator: ".").last ?? ""
        let f = n == "0" ? 0 : n.count
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = d
        formatter.minimumFractionDigits = f
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: self)) ?? "- -"
    }
}

extension CGFloat {
    var half: CGFloat { self / 2 }
}

extension CGRect {
    var minSize:CGFloat {
        min(self.width, self.height)
    }
    var maxSize:CGFloat {
        max(self.width, self.height)
    }
}

extension FloatingPoint {
    func clamped(to range: ClosedRange<Self>) -> Self {
        max(min(self, range.upperBound), range.lowerBound)
    }
}
