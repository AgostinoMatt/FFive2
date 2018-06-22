//
//  Character.swift
//  FFive
//
//  Created by Jeff Gauvin on 2018-06-22.
//  Copyright © 2018 Matt Agostino. All rights reserved.
//

import SpriteKit

protocol Character {
    var attack: Int { get set }
    var health: Int { get set }
    var magic: Int { get set }
    var exp: Int { get set }
    func runAnimation()
}

class Warrior : SKSpriteNode, Character {
    var attack: Int = 10
    var health: Int = 100
    var magic: Int = 0
    var exp: Int = 0
    
    func runAnimation() {
        let moveLeft = SKAction.moveBy(x: -30, y: 0, duration: 0.25)
        let moveRight = moveLeft.reversed()
        let rotate = SKAction.rotate(byAngle: 2*π, duration: 0.25)
        let wait = SKAction.wait(forDuration: 0.25)
        let done = SKAction.run() {
            self.removeAllActions()
        }
        run(SKAction.sequence([moveLeft, wait, moveRight, done]))
        if let item = childNode(withName: "item") as? SKSpriteNode {
            item.run(SKAction.sequence([wait, rotate]))
        }
        isPaused = false
    }
}

class Mage : SKSpriteNode, Character {
    var attack: Int = 0
    var health: Int = 100
    var magic: Int = 10
    var exp: Int = 0
    
    func runAnimation() {
        let moveUp = SKAction.moveBy(x: 50, y: 40, duration: 0.5)
        let moveDown = moveUp.reversed()
        let rotateUp = SKAction.rotate(toAngle: CGFloat(145).degreesToRadians(), duration: 0.5)
        let rotateDown = SKAction.rotate(byAngle: CGFloat(-90).degreesToRadians(), duration: 0.5)
        let wait = SKAction.wait(forDuration: 0.5)
        let done = SKAction.run() {
            self.removeAllActions()
        }
        
        if let item = childNode(withName: "item") as? SKSpriteNode {
            item.run(
                SKAction.sequence(
                    [SKAction.group([moveUp, rotateUp]),
                     wait,
                     SKAction.group([moveDown, rotateDown]),
                     done]
                )
            )
        }
        isPaused = false
    }
}

class Heavy: SKSpriteNode, Character {
    var attack: Int = 15
    var health: Int = 110
    var magic: Int = 0
    var exp: Int = 0
    
    func runAnimation() {
        let moveLeft = SKAction.moveBy(x: -40, y: 0, duration: 0.4)
        let moveRight = SKAction.moveBy(x: 40, y: 0, duration: 0.6)
        let rotate = SKAction.rotate(byAngle: 720, duration: 1)
        let wait = SKAction.wait(forDuration: 0.2)
        let done = SKAction.run() {
            self.removeAllActions()
        }
        run(SKAction.sequence([moveLeft, wait, moveRight, done]))
        if let item = childNode(withName: "item") as? SKSpriteNode {
            item.run(SKAction.sequence([rotate]))
        }
        isPaused = false
    }
    
}

class Zombie: SKSpriteNode, Character {
    var attack: Int = 5
    var health: Int = 30
    var magic: Int = 0
    var exp: Int = 30
    
    func runAnimation() {
        let moveRight = SKAction.moveBy(x: 30, y: 20, duration: 0.5)
        let moveLeft = moveRight.reversed()
        let spin = SKAction.rotate(byAngle: 720, duration: 1)
        let done = SKAction.run() {
            self.removeAllActions()
        }
        run(SKAction.sequence(
            [SKAction.group([moveRight, spin]),
             SKAction.group([moveLeft, spin]),
             done]))
        
    }
}








