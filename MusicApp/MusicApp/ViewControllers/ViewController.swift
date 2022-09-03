//
//  ViewController.swift
//  MusicApp
//
//  Created by Ekaterina Nedelko on 2.09.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var songsData: [Song]? = [Song(name: "ll"), Song(name: "iip"), Song(name: "kki")]
    
    private lazy var songsCollectionViewHeight = view.frame.height / 3
    
    private lazy var songsCollectionViewSideInset: CGFloat = view.frame.width * 0.15
    
    // MARK: - Views
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = songsCollectionViewSideInset
        
        return layout
    }()
    
    private lazy var songsCollectionView: UICollectionView = {
        let songsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        songsCollectionView.dataSource = self
        songsCollectionView.delegate = self
        
        songsCollectionView.backgroundColor = .clear
        
        songsCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                        left: songsCollectionViewSideInset,
                                                        bottom: 0,
                                                        right: songsCollectionViewSideInset)
        
        songsCollectionView.register(SongsCollectionViewCell.self, forCellWithReuseIdentifier: "SongsCell")
 
        return songsCollectionView
    }()

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        addSubviews()
        setupLayout()
    }
}

// MARK: - Appearance methods

private extension ViewController {
    func setupAppearance() {
        view.backgroundColor = .customDarkBlue
    }
    
    func addSubviews() {
        view.addSubview(songsCollectionView)
    }
    
    func setupLayout() {
        songsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            songsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 9),
            songsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            songsCollectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let songsData = songsData else { return 0 }
        
        return songsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongsCell", for: indexPath) as! SongsCollectionViewCell
        
        guard let songsData = songsData else { return cell }
        
        cell.updateData(song: songsData[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: songsCollectionViewHeight, height: songsCollectionViewHeight)
    }
}




