//
//  MrBlack.swift
//  StarshipBattlezone
//
//  Created by Mason Black on 2015-03-14.
//  Copyright (c) 2015 Mason Black. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import Darwin


class Tester: gameSceneDelegate {
    
    
    var counter = 0 // Counts the number of times the update function has run
    
    // This is Player 1's game method
    //      This is the function that is called inside the update function in the GameScene
    //      (every instant before a frame is displayed)
    func starship1Move() {
        counter += 1   // Increment the counter.
        
        // Depending on the counter, loop through and change the speed/direction of the StarShip.
        if counter < 5 {
            Game.🚀1.setNewSpeed(x: 1, y: 1)
        }
        else if counter < 125 {
            Game.🚀1.setNewSpeed(x: 0, y: 25)
        }
        else if counter < 225 {
            Game.🚀1.setNewSpeed(x: 25, y: 0)
        }
        else if counter < 400 {
            Game.🚀1.setNewSpeed(x: 25, y: -25)
        }
        else {
            counter = 0
        }
        
        // The function that moves the StarShip and calculates where on the Scene it will be displayed.
        Game.🚀1.move()
        
        
        // -------------------The Shooting calculations are below ---------------------
        
        // This is how to shoot a missile
        Game.🚀1.shoot(xSpeed: -75.0, ySpeed: 10.0)
        
        //  Shooting Algorithm
        // Use the counter to shoot every 5th frame
        if counter % 5 == 0 {
            // Set up variables that find the other StarShip's position and speed as well as your own.
            //      These are used inside calculations.
            
            let radar = Game.🚀1.radar()
            let otherStarShipSpeed = radar.starshipSpeed
            let otherStarShipPosition = radar.starshipPosition
            //let yourStarShipSpeed = Game.🚀1.getSpeed()
            let yourStarShipPosition = Game.🚀1.getPosition()
            
            // This is an awful shooting algorithm that shoots where the other StarShip is and not where he's going to be. (Can't give too much away)
            let missileXVelocity = (otherStarShipPosition.x - yourStarShipPosition.x + otherStarShipSpeed.x*2)/2
            let missileYVelocity = (otherStarShipPosition.y - yourStarShipPosition.y + otherStarShipSpeed.y*2)/2
            
            // Using the calculations, shoot the next available missile
            Game.🚀1.shoot(xSpeed: missileXVelocity, ySpeed: missileYVelocity)
        }
        
    }
    
    
    // This is Player 2's game method
    // This is the function that is called inside the update function in the GameScene
    //      (every instant before a frame is displayed).
    func starship2Move() {
        counter += 1
        var randomHorizontalSpeed: Int = 0 // Create a random variable to set the horizontal speed of the Starship
        var randomVerticalSpeed: Int = 0 // Create a random variable to set the vertical speed of the Starship
        
        if counter < 100 {
            // Using random number to represent the horizontal speed in the first 100 frames
            randomHorizontalSpeed = Int(arc4random_uniform(UInt32(25) + 1))
            Game.🚀2.setNewSpeed(x: randomHorizontalSpeed, y: 25)
        }
        else if counter < 200 {
            Game.🚀2.setNewSpeed(x: -25, y: 25)
        }
        else if counter < 300 {
            Game.🚀2.setNewSpeed(x: -25, y: -25)
        }
        else if counter < 400 {
            Game.🚀2.setNewSpeed(x: 25, y: -25)
        }
        else {
            if counter % 6 == 0 {
                randomHorizontalSpeed = Int(arc4random_uniform(UInt32(25) + 1))
                randomVerticalSpeed = -1 * Int(arc4random_uniform(UInt32(25) + 1))
                Game.🚀2.setNewSpeed(x: randomHorizontalSpeed, y: randomVerticalSpeed)
            }
        }
        
        Game.🚀2.move()
        
        
        // -------------------The Shooting calculations are below ---------------------
        // Shoot every 5th frame
        if counter % 5 == 0 {
            let radar = Game.🚀2.radar()
            let otherStarShipPosition = radar.starshipPosition
            let yourStarShipPosition = Game.🚀2.getPosition()
            
            // This is an awful shooting algorithm that shoots where the other StarShip is and not where he's going to be. (Can't give too much away)
            Game.🚀2.shoot(xSpeed: Double(otherStarShipPosition.x - yourStarShipPosition.x) / 3 , ySpeed: Double(otherStarShipPosition.y - yourStarShipPosition.y) / 3)
            
        }
        
    }
}

