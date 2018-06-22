//
//  GameScene.swift
//  FFive
//
//  Created by Matt Agostino on 2018-06-06.
//  Copyright © 2018 Matt Agostino. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    var characterOfMain: SKSpriteNode!
    let characterOfMainMovePointsPerSec: CGFloat = 480.0
    let characterOfMainRotateRadiansPerSec: CGFloat = 4.0 * π // alt-p makes π
    var characterOfMainAnimation: SKAction!
    var velocity = CGPoint.zero
    var lastUpdateTime: TimeInterval = 0
    var deltaTime: TimeInterval = 0
    var lastTouchLocation: CGPoint?
    var background: SKTileMapNode!
    var texturesUp: [SKTexture] = []
    var texturesRight: [SKTexture] = []
    var texturesDown: [SKTexture] = []
    var textureLeft: [SKTexture] = []
    
    var playableRect: CGRect!
    
    let cameraNode = SKCameraNode()
    let cameraMovePointPerSec: CGFloat = 200.0
    var cameraRect: CGRect {
        let x = cameraNode.position.x - size.width / 2 + (size.width - playableRect.width) / 2
        let y = cameraNode.position.y - size.height / 2 + (size.height - playableRect.height) / 2
        
        return CGRect(x: x, y: y, width: playableRect.width, height:
            playableRect.height)
    }
    
    required init?(coder aDecoder: NSCoder){
        
        
        super.init(coder: aDecoder)
        
        background = childNode(withName: "background") as? SKTileMapNode
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height - playableHeight) / 2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        
        for i in 1...3 {
            texturesUp.append(SKTexture(imageNamed: "hero\(i)"))
        }
        texturesUp.append(texturesUp[1])
        
        for i in 4...6{
            texturesRight.append(SKTexture(imageNamed: "hero\(i)"))
        }
        texturesRight.append(texturesRight[1])
        for i in 7...9{
            texturesDown.append(SKTexture(imageNamed: "hero\(i)"))
        }
        texturesDown.append(texturesDown[1])
        characterOfMainAnimation = 	SKAction.animate(with: texturesDown, timePerFrame: 0.1)
        
        for i in 10...12{
            textureLeft.append(SKTexture(imageNamed: "hero\(i)"))
        }
        textureLeft.append(textureLeft[1])
        
        characterOfMain = SKSpriteNode(imageNamed: "hero8")
        
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        
        characterOfMain.position = CGPoint(x: 400, y: 400)
        addChild(characterOfMain)
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width / 1.5, y: size.height / 1.5)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            deltaTime = currentTime - lastUpdateTime
        }
        else {
            deltaTime = 0
        }
        lastUpdateTime = currentTime
        
        if let lastTouchLocation = lastTouchLocation {
            let diff = lastTouchLocation - characterOfMain.position
            if diff.length() < characterOfMainMovePointsPerSec * CGFloat(deltaTime) {
                characterOfMain.position = lastTouchLocation
                velocity = CGPoint.zero
                stopCharacterOfMainAnimation()
            }
            else {
                move(sprite: characterOfMain, velocity: velocity)
            }
        }
        
        cameraNode.position = characterOfMain.position
    }
    
    func moveCharacterOfMainToward(location: CGPoint) {
        let direction = CGPoint(x: location.x - characterOfMain.position.x, y: location.y - characterOfMain.position.y).normalized()
        
        velocity = CGPoint(x: direction.x * characterOfMainMovePointsPerSec, y: direction.y * characterOfMainMovePointsPerSec)
        if lastTouchLocation != nil {
            if lastTouchLocation!.x > cameraRect.width * 0.6   {
                characterOfMainAnimation = SKAction.animate(with: texturesRight, timePerFrame: 0.1)
            }
            else if lastTouchLocation!.x < cameraRect.width * 0.3 {
                characterOfMainAnimation = SKAction.animate(with: textureLeft, timePerFrame: 0.1)
            }
            else if lastTouchLocation!.x > cameraRect.width * 0.3 && lastTouchLocation!.x < cameraRect.width * 0.6 {
                if lastTouchLocation!.y > cameraRect.height * 0.5 {
                    characterOfMainAnimation = SKAction.animate(with: texturesUp, timePerFrame: 0.1)
                }
                else {
                    characterOfMainAnimation = SKAction.animate(with: texturesDown, timePerFrame: 0.1)
                }
            }
        }
        startCharacterOfMainAnimation()
    }
    
    func move(sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = velocity * CGFloat(deltaTime)
        sprite.position += amountToMove
    }
    
    func sceneTouched(touchLocation: CGPoint) {
        lastTouchLocation = touchLocation
        moveCharacterOfMainToward(location: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    func startCharacterOfMainAnimation() {
        if characterOfMain.action(forKey: "animation") == nil {
            characterOfMain.run(SKAction.repeatForever(characterOfMainAnimation), withKey: "animation")
        }
    }
    
    func stopCharacterOfMainAnimation() {
        characterOfMain.removeAction(forKey: "animation")
    }
    
}
