# RingTimerView

### A Simple CountDown Timer in a Ring.


## Available properties for RingTimerView
    #### When added to a view, set contraints to the superview. Iternal elements will follow.

    ##### time:TimeInterval
    CountDown total time
    
    ##### step:Double
    A step value to the timer
     ```swift     
    timer.step = 1.0 => Timer will run in of second
    timer.step = 0.1 => Timer will run in a tenth of second
    ```

    ##### timeMultiplyer:Double
    Speeds up the timer in timeMultiplyer factor
     ```swift     
    timer.timeMultiplyer = 1.0 => Runs regulary
    timer.timeMultiplyer = 2.0 => Runs twices faster
    ```
    
    ##### onEnd:()->Void
    Closure thar runs at timer end
    
    ##### remainingTime:TimeInterval
    Time left to end
    
    ##### remainingPercentage:Double
    Time left to end percentage [0,1]
    
    ##### ring:RingProgressView
    The RingProgressView, customizable as below

    ### The constructor
        init( frame:CGRect = .zero, 
            time: TimeInterval, 
            step: Double = 1, 
            timeMultiplyer: Double = 1, 
            onEnd:@escaping ()->Void = {} )

  ### Available functions
  self explanatory
     ```swift
    public func start()
    public func stop()
    public func restart()
    public func restartIfRunning()
    
     ```

    

### Available properties for RingTimerView.ring -> RingProgressView

 ##### lineWidth:CGfloat
 Size of the bar (stroke width)
 ```swift
 ring.lineWidth = 20
 ```
 
 ##### text:String?
 Text to be displayed in the middle
 ```swift
 ring.text = "Time spent"
 ```
 
 ##### attributedText:NSAttributedString?
 Attributed text to be displayed in the middle
 ```swift
  ring.attributedText = "Time spent"
 ```
 
 ##### textColor:UIColor 
 Color for text inside progress bar when no `attributedText` is used
 ```swift
 ring.textColor = .darkGray
 ```
 
 ##### textSize:CGFloat
 Font size for text inside progress bar
 ```swift
 ring.textSize = 20
 ```
 
 ##### backgroundBarColor:UIColor
 Color for background (base) track
 ```swift
 ring.backgroundBarColor = .systemGray
 ```
 
 ##### foregroundBarColor:UIColor
 Color for foreground (main) track
 ```swift
 ring.foregroundBarColor = .systemGreen
 ```
 
 ##### maximumBarColor:UIColor
 Color for the foreground (main) track when it reaches the maximum value (full circle)
 ```swift
 ring.maximumBarColor = .systemRed
 ```
 
 ##### animationDuration:TimeInterval
 Filling animation duration
 ```swift
 ring.animationDuration:TimeInterval = 1
 ```
 
 ### Available functions
 
 ##### setProgress(to:animated:)
 Set the visual impression of progress on this UIView
 ```swift
 /// - Parameters:
 ///   - progress: normalized value from range [0,1] outbounded values will be clamped
 ///   - animated: animates to new value if true
 public func setProgress(to progress: Double, animated: Bool)
 ```
