//
//  MusicPlayerViewModel.swift
//  MusicApp
//
//  Created by Ekaterina Nedelko on 3.09.22.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

protocol MusicPlayerViewModelProtocol {
    var audioPlayer: AVAudioPlayer? { get }
    var currentAudioPath: URL? { get }
    
    func prepareAudio(index: Int)
    func playAudio()
    func continuePlayback(_ play: Bool)
}

protocol MusicPlayerViewModelDelegate: AnyObject {
    func updatePlayerProgressBar()
}

final class MusicPlayerViewModel: NSObject {
    
    weak var delegate: MusicPlayerViewModelDelegate?
    
    private(set) var audioPlayer: AVAudioPlayer?
    private(set) var currentAudioPath: URL?
    
    let songsData: [Song]? = [Song(name: "Cut The Line",
                                   fileName: "Papa_Roach_-_Cut_The_Line_",
                                   imageName: "album_papa_roach",
                                   artist: [Artist(name: "Papa Roach")]),
                              Song(name: "Shining Of Your Soul",
                                   fileName: "Scorpions_-_Shining_Of_Your_Soul_",
                                   imageName: "album_scorpions",
                                   artist: [Artist(name: "Scorpions")]),
                              Song(name: "Kickstart My Heart",
                                   fileName: "Motley_Crue_-_Kickstart_My_Heart_",
                                   imageName: "album_motley_crue",
                                   artist: [Artist(name: "Mötley Crüe")])]
    
    private(set)var timer: Timer?
}

extension MusicPlayerViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("The song ended")
    }
}

extension MusicPlayerViewModel: MusicPlayerViewModelProtocol {
    private func setCurrentAudioPath(index: Int) {
        currentAudioPath = URL(fileURLWithPath: Bundle.main.path(forResource: songsData?[index].fileName, ofType: "mp3") ?? "")
    }
    
    func prepareAudio(index: Int) {
        setCurrentAudioPath(index: index)
        
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)))
        
        try? AVAudioSession.sharedInstance().setActive(true)
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        guard let currentAudioPath = currentAudioPath else { return }
        audioPlayer = try? AVAudioPlayer(contentsOf: currentAudioPath)
        audioPlayer?.delegate = self

        audioPlayer?.prepareToPlay()
    }
    
    func playAudio() {
        guard let audioIsPlaying = audioPlayer?.isPlaying else { return }
        
        if audioIsPlaying {
            stopPlayingAudio()
            return
        }
        
        startPlayingAudio()
    }
    
    func continuePlayback(_ play: Bool) {
        if play {
            startPlayingAudio()
            return
        }
        
        stopPlayingAudio()
    }
    
    private func startPlayingAudio() {
        audioPlayer?.play()
        createTimer()
    }
    
    private func stopPlayingAudio() {
        audioPlayer?.stop()
        cancelTimer()
    }
}

// MARK: - Timer

extension MusicPlayerViewModel {
    func createTimer() {
        if timer == nil {
            let timer = Timer(timeInterval: 1.0,
                              target: self,
                              selector: #selector(updateTimer),
                              userInfo: nil,
                              repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
          
            self.timer = timer
       }
    }
    
    @objc func updateTimer() {
        delegate?.updatePlayerProgressBar()
    }
    
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Helpers

fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
    return input.rawValue
}
