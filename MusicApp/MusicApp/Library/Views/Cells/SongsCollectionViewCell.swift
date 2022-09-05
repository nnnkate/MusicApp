//
//  SongsCollectionViewCell.swift
//  MusicApp
//
//  Created by Ekaterina Nedelko on 3.09.22.
//

import UIKit

final class SongsCollectionViewCell: UICollectionViewCell {
    
    static let id = "SongsCell"
    
    // MARK: - Views
    
    private lazy var songsLayerView: UIView = {
        let songsLayerView = UIView()
        
        songsLayerView.backgroundColor = .white

        songsLayerView.layer.opacity = 0.08
        songsLayerView.layer.cornerRadius = 15.0
       
        songsLayerView.layer.masksToBounds = false
        
        return songsLayerView
    }()
    
    private lazy var songsLayerBorderView: UIView = {
        let songsLayerBorderView = UIView()
        
        songsLayerBorderView.layer.cornerRadius = 15.0
        songsLayerBorderView.layer.borderWidth = 0.2
        songsLayerBorderView.layer.borderColor = UIColor.white.cgColor

        songsLayerBorderView.layer.masksToBounds = false
        
        songsLayerBorderView.layer.backgroundColor = UIColor.customPurpleBlue.cgColor
        songsLayerBorderView.layer.opacity = 0.8
        songsLayerBorderView.layer.shadowColor = UIColor.customPurpleBlue.cgColor
        songsLayerBorderView.layer.shadowOffset = CGSize(width: 0, height: 0)
        songsLayerBorderView.layer.shadowRadius = 20.0
        songsLayerBorderView.layer.shadowOpacity = 1
        songsLayerBorderView.layer.masksToBounds = false

        return songsLayerBorderView
    }()
    
    private lazy var songsImageView: UIImageView = {
        let songsImageView = UIImageView()
        
        songsImageView.layer.cornerRadius = 15.0
        
        songsImageView.clipsToBounds = true
        songsImageView.contentMode = .scaleToFill
        
        return songsImageView
    }()
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    // MARK: - Public Methods
    
    func updateData(song: Song) {
        self.songsImageView.image = song.image
    }
    
    // MARK: - Private Methods
    
    private func configureCell() {
        addSubviews()
        configureLayout()
    }
}

// MARK: - Appearance Methods

private extension SongsCollectionViewCell {
    func addSubviews() {
        addSubview(songsLayerBorderView)
        songsLayerBorderView.addSubview(songsLayerView)
        addSubview(songsImageView)
    }
    
    func configureLayout() {
        songsLayerBorderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songsLayerBorderView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            songsLayerBorderView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            songsLayerBorderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            songsLayerBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        songsLayerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songsLayerView.centerXAnchor.constraint(equalTo: songsLayerBorderView.centerXAnchor),
            songsLayerView.centerYAnchor.constraint(equalTo: songsLayerBorderView.centerYAnchor),
            songsLayerView.topAnchor.constraint(equalTo: songsLayerBorderView.topAnchor),
            songsLayerView.leadingAnchor.constraint(equalTo: songsLayerBorderView.leadingAnchor)
        ])

        songsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songsImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            songsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            songsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            songsImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}


