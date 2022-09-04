//
//  ViewController.swift
//  MusicApp
//
//  Created by Ekaterina Nedelko on 2.09.22.
//

import UIKit

class MusicPlayerViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let viewModel: MusicPlayerViewModel = MusicPlayerViewModel()
    
    private lazy var songsCollectionViewHeight = view.frame.height / 3
    
    private lazy var songsCollectionViewSideInset: CGFloat = view.frame.width * 0.1
    
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
    
    private lazy var songNameLabel: UILabel = {
        let songsNameLabel = UILabel()
        
        songsNameLabel.numberOfLines = 0
        songsNameLabel.minimumScaleFactor = 0.5
        songsNameLabel.adjustsFontSizeToFitWidth = true
        songsNameLabel.textAlignment = .left
        songsNameLabel.textColor = .white
        songsNameLabel.font = .systemFont(ofSize: 25, weight: .bold)
        
        return songsNameLabel
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let artistNameLabel = UILabel()
        
        artistNameLabel.numberOfLines = 0
        artistNameLabel.minimumScaleFactor = 0.5
        artistNameLabel.adjustsFontSizeToFitWidth = true
        artistNameLabel.textAlignment = .left
        artistNameLabel.textColor = .white
        artistNameLabel.font = .systemFont(ofSize: 18, weight: .regular)
        
        return artistNameLabel
    }()
    
    private lazy var playerProgressBar: PlayerProgressBar = {
        let playerProgressBar = PlayerProgressBar()
        
        return playerProgressBar
    }()
    
    private lazy var playerButtonsStack: UIStackView = {
        let playerButtonsStack = UIStackView()
        playerButtonsStack.axis = .horizontal
        playerButtonsStack.distribution = .equalCentering
        
        return playerButtonsStack
    }()
    
    private lazy var previousButton: UIButton = {
        let previousButton = UIButton()
        previousButton.setImage(UIImage(systemName: "backward.end"), for: .normal)
        previousButton.tintColor = .white
        
        return previousButton
    }()
    
    private lazy var playButton: UIButton = {
        let playButton = UIButton()
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.tintColor = .white
        
        let action = UIAction { [weak self] _ in self?.handlePlayButton() }
        playButton.addAction(action, for: .touchUpInside)
        
        return playButton
    }()
    
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.setImage(UIImage(systemName: "forward.end"), for: .normal)
        nextButton.tintColor = .white
        
        return nextButton
    }()

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        addSubviews()
        setupLayout()
    }
    
    //
    
    private func updateCurrentSongData(indexPath: IndexPath?) {
        guard let index = indexPath?.last, let songData = viewModel.songsData?[index] else {
            // stop music!
            songNameLabel.text = ""
            artistNameLabel.text = ""
            return
        }
        
        viewModel.prepareAudio(index: index)
        songNameLabel.text = songData.name
        artistNameLabel.text = songData.artist?.reduce(into:"") { result, artist in
            result += artist.name }
    }
}

// MARK: - Appearance methods

private extension MusicPlayerViewController {
    func setupAppearance() {
        view.backgroundColor = .customDarkBlue
    }
    
    func addSubviews() {
        view.addSubview(songsCollectionView)
        
        view.addSubview(songNameLabel)
        view.addSubview(artistNameLabel)
        
        view.addSubview(playerProgressBar)
        
        view.addSubview(playerButtonsStack)
        playerButtonsStack.addArrangedSubview(previousButton)
        playerButtonsStack.addArrangedSubview(playButton)
        playerButtonsStack.addArrangedSubview(nextButton)
    }
    
    func setupLayout() {
        songsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            songsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 9),
            songsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            songsCollectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            songNameLabel.topAnchor.constraint(equalTo: songsCollectionView.bottomAnchor, constant: view.frame.height * 0.005),
            songNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width / 25),
            songNameLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: view.frame.height * 0.005),
            artistNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width / 25),
            artistNameLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03)
        ])
        
        playerProgressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerProgressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerProgressBar.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: view.frame.height * 0.02),
            playerProgressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width / 25),
            playerProgressBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03)
        ])
        
        playerButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerButtonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerButtonsStack.topAnchor.constraint(equalTo: playerProgressBar.bottomAnchor, constant: view.frame.height * 0.02),
            playerButtonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width / 4),
            playerButtonsStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension MusicPlayerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let songsData = viewModel.songsData else { return 0 }
        
        return songsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongsCell", for: indexPath) as! SongsCollectionViewCell
        
        guard let songsData = viewModel.songsData else { return cell }
        
        cell.updateData(song: songsData[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MusicPlayerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: songsCollectionViewHeight, height: songsCollectionViewHeight)
    }
}

// MARK: - UICollectionViewDelegate

extension MusicPlayerViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in songsCollectionView.visibleCells {
            let indexPath = songsCollectionView.indexPath(for: cell)
            updateCurrentSongData(indexPath: indexPath)
        }
    }
}

// MARK: - Actions

private extension MusicPlayerViewController {
    func handlePlayButton() {
        viewModel.playAudio()
    }
}




