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

final class MusicPlayerViewModel: NSObject {
    var audioPlayer: AVAudioPlayer?
    var currentAudioPath: URL?
    
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
    
   
}

extension MusicPlayerViewModel: AVAudioPlayerDelegate {
    func setCurrentAudioPath(index: Int) {
        currentAudioPath = URL(fileURLWithPath: Bundle.main.path(forResource: songsData?[index].fileName, ofType: "mp3") ?? "")
        print("\(String(describing: currentAudioPath))")
    }
    
    func prepareAudio(index: Int) {
        setCurrentAudioPath(index: index)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)))
        } catch {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
        }
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        guard let currentAudioPath = currentAudioPath else { return }
        audioPlayer = try? AVAudioPlayer(contentsOf: currentAudioPath)
        audioPlayer?.delegate = self

        audioPlayer?.prepareToPlay()
        
        playAudio()
    }
    
    func playAudio() {
        audioPlayer?.play()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
              print("The song ended")
        }
}

fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
    return input.rawValue
}
