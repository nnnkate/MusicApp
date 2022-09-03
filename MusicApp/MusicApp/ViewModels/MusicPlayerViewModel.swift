//
//  MusicPlayerViewModel.swift
//  MusicApp
//
//  Created by Ekaterina Nedelko on 3.09.22.
//

import Foundation
import UIKit

final class MusicPlayerViewModel {
    let songsData: [Song]? = [Song(name: "Cut The Line",
                                   imageName: "album_papa_roach",
                                   artist: [Artist(name: "Papa Roach")]),
                              Song(name: "Shining Of Your Soul",
                                   imageName: "album_scorpions",
                                   artist: [Artist(name: "Scorpions")]),
                              Song(name: "Kickstart My Heart",
                                   imageName: "album_motley_crue",
                                   artist: [Artist(name: "Mötley Crüe")])]
}
