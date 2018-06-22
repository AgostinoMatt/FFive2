//
//  GameViewController.swift
//  FFive
//
//  Created by Matt Agostino on 2018-06-06.
//  Copyright © 2018 Matt Agostino. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                view.presentScene(scene)
                view.ignoresSiblingOrder = true
                
                view.showsFPS = true
                view.showsNodeCount = true
            }
        }
    }

    @IBAction func buttonClick(_ sender: Any) {
        let fightScene = storyboard?.instantiateViewController(withIdentifier: "FightSceneViewController") as! FightSceneViewController
        
        self.navigationController?.pushViewController(fightScene, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
