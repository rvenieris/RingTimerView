//
//  RingProgressView.PercentageLabel.swift
//  Ring Timer
//
//  Created by Ricardo Venieris on 02/11/22.
//

import UIKit


extension RingProgressView {
    class PercentageLabel:UILabel {
        
        var outerLineWidth:CGFloat {
            didSet { updateSizeConstraints() }
        }
        
        private var margin:CGFloat {-outerLineWidth*3}
        
        init(outerLineWidth:CGFloat = 12.0) {
            self.outerLineWidth = outerLineWidth
            super.init(frame: .zero)
            
            
            let fontSize = UIScreen.main.bounds.minSize
            
            textAlignment = .center
            textColor = textColor
            font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: .medium)
            adjustsFontSizeToFitWidth = true
        
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private var labelSizeConstraints:[NSLayoutConstraint] { [
        ] }
        
        
        var sizeConstraints:[NSLayoutConstraint] = []
        func setupConstraints() {
            guard let sv = superview else { return }
            
            [centerXAnchor.constraint(equalTo: sv.centerXAnchor),
             centerYAnchor.constraint(equalTo: sv.centerYAnchor)].forEach { $0.isActive = true }
            
            sizeConstraints = [
             widthAnchor.constraint(equalTo: sv.widthAnchor, constant: margin),
             heightAnchor.constraint(equalTo: sv.heightAnchor, constant: margin)
            ]
            sizeConstraints.forEach { $0.isActive = true }
        }
        
        private func updateSizeConstraints() {
            sizeConstraints.forEach{$0.constant = margin}
        }
    }
}
