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
    let image: UIImage?  
    let artist: [Artist]?
    
    init (name: String, imageName: String, artist: [Artist]?) {
        self.name = name
        self.image = UIImage(named: imageName)
        self.artist = artist
    }
}
