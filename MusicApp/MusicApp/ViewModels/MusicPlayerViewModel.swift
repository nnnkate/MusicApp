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

final class MusicPlayerViewModel {
    
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
    
    func setCurrentAudioPath(index: Int) {
        currentAudioPath = URL(fileURLWithPath: Bundle.main.path(forResource: songsData?[index].fileName, ofType: "mp3") ?? "")
        print("\(String(describing: currentAudioPath))")
    }
}
