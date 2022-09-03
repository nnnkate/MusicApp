//
//  PlayerProgressBar.swift
//  MusicApp
//
//  Created by Ekaterina Nedelko on 3.09.22.
//

import Foundation
import UIKit

final class PlayerProgressBar: UIView {
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = .customPurpleColor
        slider.tintColor = .customPurpleColor
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureProgressBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureProgressBar()
    }
    
    private func configureProgressBar() {
        setupAppearance()
        addSubviews()
        configureLayout()
    }
}

// MARK: - Appearance Methods

private extension PlayerProgressBar {
    func setupAppearance() {
        //view.backgroundColor = .black
    }
    
    func addSubviews() {
        addSubview(slider)
    }
    
    func configureLayout() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            slider.topAnchor.constraint(equalTo: self.topAnchor),
            slider.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
}


