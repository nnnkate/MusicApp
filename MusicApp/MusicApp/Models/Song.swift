//
//  Song.swift
//  MusicApp
//
//  Created by Ekaterina Nedelko on 3.09.22.
//

import Foundation
import UIKit

struct Song {
    let name: String
    let image: UIImage? = UIImage(named: "album_papa_roach") // UIImage(named: "album_motley_crue")
    let artist: [Artist]? = [Artist]()
}
