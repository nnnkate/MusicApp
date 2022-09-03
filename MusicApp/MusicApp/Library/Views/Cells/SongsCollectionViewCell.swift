//
//  SongsCollectionViewCell.swift
//  MusicApp
//
//  Created by Ekaterina Nedelko on 3.09.22.
//

import UIKit

final class SongsCollectionViewCell: UICollectionViewCell {
    
    static let id = "SongsCell"
    
    private lazy var songsLayerView: UIView = {
        let songsLayerView = UIView()
        
        songsLayerView.backgroundColor = .white

        songsLayerView.layer.cornerRadius = 15.0
        songsLayerView.layer.borderWidth = 0.0
        songsLayerView.layer.shadowColor = UIColor.lightGray.cgColor
        songsLayerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        songsLayerView.layer.shadowRadius = 3.0
        songsLayerView.layer.shadowOpacity = 1
        songsLayerView.layer.masksToBounds = false
        
        return songsLayerView
    }()
    
    private var songsImageView: UIImageView = {
        let songsImageView = UIImageView()
        
        songsImageView.layer.cornerRadius = 15.0
        
        songsImageView.clipsToBounds = true
        songsImageView.contentMode = .scaleToFill
        
        return songsImageView
    }()

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
    
    private func configureCell() {
        addSubviews()
        configureLayout()
    }
    
    func updateData(song: Song) {
        self.songsImageView.image = song.image
    }
}

// MARK: - Appearance Methods

private extension SongsCollectionViewCell {
    func addSubviews() {
        addSubview(songsLayerView)
        
        songsLayerView.addSubview(songsImageView)
    }
    
    func configureLayout() {
        songsLayerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songsLayerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            songsLayerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            songsLayerView.topAnchor.constraint(equalTo: self.topAnchor),
            songsLayerView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])

        songsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songsImageView.centerXAnchor.constraint(equalTo: songsLayerView.centerXAnchor),
            songsImageView.topAnchor.constraint(equalTo: songsLayerView.topAnchor),
            songsImageView.leadingAnchor.constraint(equalTo: songsLayerView.leadingAnchor),
            songsImageView.centerYAnchor.constraint(equalTo: songsLayerView.centerYAnchor)
        ])
    }
}


