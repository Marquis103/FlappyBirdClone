//
//  GameScene.swift
//  FlappyBirdClone
//
//  Created by Marquis Dennis on 12/17/15.
//  Copyright (c) 2015 Marquis Dennis. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var bird = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        //everything that appears on the screen is a node
        //assign flappy1 to sprite node
        //image used to display a sprite is a texture
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        //create animation between our textures
        let animation = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.2)
        
        //create an animation that repeats this action forever
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture)
        
        //need a location for the bird
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        //add animation to bird sprite
        bird.runAction(makeBirdFlap)
        
        //add node to the screen
        self.addChild(bird)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
