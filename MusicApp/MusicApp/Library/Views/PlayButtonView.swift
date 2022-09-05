//
//  PlayButtonView.swift
//  MusicApp
//
//  Created by Ekaterina Nedelko on 4.09.22.
//

import Foundation
import UIKit

final class PlayButtonView: UIView {
    
    // MARK: - Views
    
    private lazy var circleImageView: UIImageView = {
        let circleImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
        
        circleImageView.tintColor = .darkGray
        circleImageView.layer.opacity = 0.3
        
        circleImageView.layer.shadowColor = UIColor.black.cgColor
        circleImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        circleImageView.layer.shadowRadius = 18.0
        circleImageView.layer.shadowOpacity = 0.9

        return circleImageView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Appearance Methods

private extension PlayButtonView {
    func addSubviews() {
        addSubview(circleImageView)
    }
    
    func configureLayout() {
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circleImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            circleImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            circleImageView.heightAnchor.constraint(equalTo: self.widthAnchor),
            circleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
}
