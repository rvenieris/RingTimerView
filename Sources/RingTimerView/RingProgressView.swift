//
//  RingProgressView.swift
//  Ring Timer
//
//  Created by Ricardo Venieris on 02/11/22.
//

import UIKit

public class RingProgressView: UIView, CAAnimationDelegate {

    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private let label = PercentageLabel()
    
    public var lineWidth: CGFloat = 30 {
        didSet {
            foregroundLayer.lineWidth = lineWidth
            backgroundLayer.lineWidth = lineWidth
            label.outerLineWidth = lineWidth
        }
    }
    
        /// Text to be displayed in the middle
    public var text: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
        /// Attributed text to be displayed inside of progress bar
    public var attributedText: NSAttributedString? {
        get { label.attributedText }
        set { label.attributedText = newValue }
    }
    
        /// Color for backgorund/base bar
    public var backgroundBarColor = UIColor.systemGray
    
        /// Color for foreground/main bar
    public var foregroundBarColor = UIColor.systemGreen
    
        /// Color for maximum value (100%) of the bar
    public var maximumBarColor = UIColor.systemRed
    
        /// Duration of the "filling" animation
    public var animationDuration:TimeInterval = 1
    
        /// Color for text inside progress bar
    public var textColor = UIColor.darkGray
    
        /// Font size for text inside progress bar
    public var textSize:CGFloat = 20
    
        /// Animation Acceleration time function name
    public var timingFunction: CAMediaTimingFunctionName = .linear
    
    private var progressValue:Double = 0
    
    private let animation = CABasicAnimation(keyPath: "strokeEnd")
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        setColor(by: progressValue)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .redraw
        
        addSubview(label)
        label.setupConstraints()

    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor = .clear
        setupBars()
    }
    
        /// Set the visual impression of progress on this UIView
        ///
        /// - Parameters:
        ///   - progress: normalized value from range [0,1] however upper bound will be clamped
        ///   - animated: Switch animations on/off
    public func setProgress(to progress: Double, animated: Bool) {
        foregroundLayer.strokeEnd = CGFloat(progress.clamped(to: 0...1))
        
        if animated {
            progressAnimation(progress)
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            foregroundLayer.strokeEnd = CGFloat(progress.clamped(to: 0...1))
            CATransaction.commit()
            setColor(by: progress)
        }
    }
}

    // MARK: - Animation
private extension RingProgressView {
    func progressAnimation(_ progress: Double) {
        
        animation.fromValue = progressValue
        animation.toValue = progress
        animation.duration = animationDuration
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: timingFunction)
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        progressValue = progress
        foregroundLayer.add(animation, forKey: "foregroundAnimation")
    }
    
}

    // MARK: - Setup bars
private extension RingProgressView {
    func setupBars(){
        guard frame.minSize > 0 else {return}
        setupBackgroundLayer()
        setupForegroundLayer()
    }
    
    func setupBackgroundLayer() {
        backgroundLayer.removeFromSuperlayer()
        let path = CGMutablePath()
        path.addPath(circularPath.cgPath)
        
        backgroundLayer.path = path
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.strokeColor = backgroundBarColor.cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.position = pathCenter
        backgroundLayer.transform = CATransform3DMakeRotation(rotationAngle, 0, 0, 1)
        
        layer.addSublayer(backgroundLayer)
    }
    
    func setupForegroundLayer() {
        foregroundLayer.removeFromSuperlayer()
        let path = CGMutablePath()
        path.addPath(circularPath.cgPath)
        
        foregroundLayer.path = path
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.position = pathCenter
        foregroundLayer.transform = CATransform3DMakeRotation(rotationAngle, 0, 0, 1)
        foregroundLayer.strokeEnd = 0
        
        layer.addSublayer(foregroundLayer)
    }
    
    func setColor(by progress: Double) {
        foregroundLayer.strokeColor = (progress >= 1.0) ? maximumBarColor.cgColor : foregroundBarColor.cgColor
    }
}

    // MARK: - Calculations & helpers
private extension RingProgressView {
    var circularPath: UIBezierPath {
        return UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
    }
    
    var radius: CGFloat {
        let availableSpace = min(frame.width, frame.height)
        return (availableSpace - lineWidth).half
    }
    
    var pathCenter: CGPoint {
        CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    var rotationAngle: CGFloat {
        -CGFloat.pi.half
    }
}
