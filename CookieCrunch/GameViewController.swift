//
//  GameViewController.swift
//  CookieCrunch
//
//  Created by Renato Camilio on 2/20/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene: GameScene!
    var level: Level!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        level = Level(fileName: "Level_0")
        scene.level = level
        
        skView.presentScene(scene)
        
        beginGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func beginGame() {
        shuffle()
    }
    
    func shuffle() {
        let newCookies = level.shuffle()
        scene.addSpritesForCookies(newCookies)
    }

}
