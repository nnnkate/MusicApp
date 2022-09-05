//
//  Int+Extensions.swift
//  MusicApp
//
//  Created by Ekaterina Nedelko on 5.09.22.
//

import Foundation

// MARK: - TimerComponents

typealias TimerComponents = (Int, Int, Int, Int)

extension Int {
    func getTimerComponents() -> TimerComponents {
        var timerCounter = self
        let days = timerCounter / (24 * 60 * 60)
        timerCounter -= (days * (24 * 60 * 60))
        let hours = timerCounter / (60 * 60)
        timerCounter -= (hours * (60 * 60))
        let minutes = timerCounter / 60
        timerCounter -= minutes * 60
        
        return (days, hours, minutes, timerCounter)
    }
    
    func getTimerComponentsString() -> String {
        let timerComponents = self.getTimerComponents()
        let days = timerComponents.0 != 0 ? "\(timerComponents.0):" : ""
        let hours = timerComponents.1 != 0 ? "\(timerComponents.1):" : ""
        let minutes = timerComponents.2 != 0 ? "\(timerComponents.2):" : "00:"
        let seconds = timerComponents.3 < 10 ? "0\(timerComponents.3)" : "\(timerComponents.3)"
        
        return days + hours + minutes + seconds
    }
}
