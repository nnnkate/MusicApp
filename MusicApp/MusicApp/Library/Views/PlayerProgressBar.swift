//
//  PlayerProgressBar.swift
//  MusicApp
//
//  Created by Ekaterina Nedelko on 3.09.22.
//

import Foundation
import UIKit

final class PlayerProgressBar: UIView {
    
    private lazy var timeStackView: UIStackView = {
        let timeStackView = UIStackView()
        
        timeStackView.axis = .horizontal
        timeStackView.distribution = .equalSpacing
        
        return timeStackView
    }()
    
    private lazy var elapsedTimeLabel: UILabel = {
        let elapsedTimeLabel = UILabel()
        
        elapsedTimeLabel.numberOfLines = 1
        elapsedTimeLabel.minimumScaleFactor = 0.5
        elapsedTimeLabel.adjustsFontSizeToFitWidth = true
        elapsedTimeLabel.font = .systemFont(ofSize: 15, weight: .regular)
        elapsedTimeLabel.textColor = .white
        elapsedTimeLabel.text = "00:00"
        
        return elapsedTimeLabel
    }()
    
    private lazy var remainingTimeLabel: UILabel = {
        let remainingTimeLabel = UILabel()
        
        remainingTimeLabel.numberOfLines = 1
        remainingTimeLabel.minimumScaleFactor = 0.5
        remainingTimeLabel.adjustsFontSizeToFitWidth = true
        remainingTimeLabel.font = .systemFont(ofSize: 15, weight: .regular)
        remainingTimeLabel.textColor = .white
        remainingTimeLabel.text = "00:00"
        
        return remainingTimeLabel
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        
        slider.thumbTintColor = .customPurple
        slider.tintColor = .customPurple
        
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
        
        addSubview(timeStackView)
        timeStackView.addArrangedSubview(elapsedTimeLabel)
        timeStackView.addArrangedSubview(remainingTimeLabel)
    }
    
    func configureLayout() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            slider.topAnchor.constraint(equalTo: self.topAnchor),
            slider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            slider.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeStackView.topAnchor.constraint(equalTo: self.centerYAnchor),
            timeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timeStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


