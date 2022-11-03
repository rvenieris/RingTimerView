    //
    //  RingTimerView.swift
    //  Ring Timer
    //
    //  Created by Ricardo Venieris on 02/11/22.
    //

import Foundation
import UIKit

public class RingTimerView: UIView {
    
    public var time:TimeInterval { didSet { restartIfRunning() } }
    public var step:Double
    public var timeMultiplyer:Double
    public var onEnd:()->Void
    public var remainingTime:TimeInterval
    public var remainingPercentage:Double {1 - (remainingTime/time)}
    public var ring:RingProgressView

    private var timer:Timer? = nil
    
    public init(frame:CGRect = .zero, time: TimeInterval, step: Double = 1, timeMultiplyer: Double = 1, onEnd:@escaping ()->Void = {}) {
        self.time = time
        self.step = step
        self.timeMultiplyer = timeMultiplyer
        self.ring = RingProgressView(frame: frame)
        self.onEnd = onEnd
        self.remainingTime = time
        super.init(frame: frame)
        
        ring.text = time.formatingOn(maxValue: time, and: step)
        ring.animationDuration = step/timeMultiplyer
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        addSubview(ring)
        ring.translatesAutoresizingMaskIntoConstraints = false
        ring.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ring.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ring.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ring.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    public func start() {
        stop()
        let speed = step/timeMultiplyer
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true,
                                     block: { [self] timer in
            remainingTime = max((remainingTime - step),0)
            onStep()
            guard remainingTime > 0 else {
                stop()
                onEnd()
                return
            }
        })
    }
    
    public func stop() {
        remainingTime = time
        timer?.invalidate()
        timer = nil
        
    }
    
    public func restart() {
        stop()
        start()
    }
    
    public func restartIfRunning() {
        if let _ = timer {
            stop()
            start()
        }
    }
    
    private func onStep() {
        DispatchQueue.main.async { [self] in
            ring.setProgress(to: remainingPercentage, animated: true)
            ring.text = remainingTime.formatingOn(maxValue: time, and: step)
        }
    }
    
}


