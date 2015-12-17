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
    var bg = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        //background texture
        let bgTexture = SKTexture(imageNamed: "bg.png")
        
        //adding background texture to node
        bg = SKSpriteNode(texture: bgTexture)
        
        //set bg position
        bg.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
        
        bg.size.height = frame.height
        
        //move background to the left so bird appears to be moving right
        let movebg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        //move background from the extreme left to the extreme right
        let replacebg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        
        //want this to happen when background has moved all the way to the left
        let movebgForever = SKAction.repeatActionForever(SKAction.sequence([movebg, replacebg]))
        
        //create new bg node to add to the scene
        for var i:CGFloat=0; i < 3; i++ {
            //adding background texture to node
            bg = SKSpriteNode(texture: bgTexture)
            
            //x is the center of the background image
            
            bg.position = CGPoint(x: bgTexture.size().width / 2 + bgTexture.size().width * i, y: CGRectGetMidY(frame))
            
            bg.size.height = frame.height
            
            bg.runAction(movebgForever)
            
            self.addChild(bg)
        }
        
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
        
        //controlling sprites
        //apply gravity and detect collision with other objects
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height/2)
        bird.physicsBody!.dynamic = true
        
        //need a location for the bird
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        //add animation to bird sprite
        bird.runAction(makeBirdFlap)
        
        //add node to the screen
        self.addChild(bird)
        
        //create another physics body which is the ground
        //not a sprite because it doesn't have an image
        var ground = SKNode()
        ground.position = CGPointMake(0,0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(frame.size.width, 1))
        ground.physicsBody!.dynamic = false
        self.addChild(ground)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        //add impulses to objects
        //define speed/velocity of bird
        bird.physicsBody!.velocity = CGVectorMake(0, 0)
        bird.physicsBody!.applyImpulse(CGVectorMake(0, 50))

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
