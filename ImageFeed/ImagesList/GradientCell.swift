//
//  GradientCell.swift
//  ImageFeed
//
//  Created by User on 22.02.2023.
//

import UIKit

class GradientCell: UIView {
    
    @IBInspectable private var starColor: UIColor?
    
    @IBInspectable private var endColor: UIColor?
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        setupGredientColors()
    }
    
    private func setupGredientColors() {
        if let starColor = starColor, let endColor = endColor {
            gradientLayer.colors = [starColor.cgColor, endColor.cgColor]
        }
    }
} 
