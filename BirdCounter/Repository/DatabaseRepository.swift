//
//  DatabaseRepository.swift
//  BirdCounter
//
//  Created by Zvonimir Medak on 10.04.2021..
//

import Foundation
import UIKit

enum DatabaseKeys: String {
    case number
    case lastBird
}

class DatabaseRepositoryImpl: DatabaseRepository {
     let defaults = UserDefaults.standard
    
    func birdChanged(bird: BirdType) {
        defaults.setValue(bird.rawValue, forKey: DatabaseKeys.lastBird.rawValue)
        counterChanged()
        defaults.synchronize()
    }
    
    private func counterChanged() {
        var counter = defaults.integer(forKey: DatabaseKeys.number.rawValue)
        counter += 1
        defaults.setValue(counter, forKey: DatabaseKeys.number.rawValue)
        defaults.synchronize()
    }
    
    func getCounter() -> Int {
        return defaults.integer(forKey: DatabaseKeys.number.rawValue)
    }
    
    func getLastBirdType() -> String? {
        return defaults.string(forKey: DatabaseKeys.lastBird.rawValue)
    }
    
    func reset() {
        defaults.setValue(0, forKey: DatabaseKeys.number.rawValue)
        defaults.setValue(nil, forKey: DatabaseKeys.lastBird.rawValue)
        defaults.synchronize()
    }
}

protocol DatabaseRepository {
    func birdChanged(bird: BirdType)
    func getCounter() -> Int
    func getLastBirdType() -> String?
    func reset()
}
