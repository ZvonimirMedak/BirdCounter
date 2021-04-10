//
//  CounterItem.swift
//  BirdCounter
//
//  Created by Zvonimir Medak on 10.04.2021..
//

import Foundation
class CounterItem {
    var counter: Int
    var birdType: BirdType?
    
    init(counter: Int, birdType: BirdType?) {
        self.counter = counter
        self.birdType = birdType
    }
}
