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
    var pipe1 = SKSpriteNode()
    var pipe2 = SKSpriteNode()
    
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
        let ground = SKNode()
        ground.position = CGPointMake(0,0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(frame.size.width, 1))
        ground.physicsBody!.dynamic = false
        self.addChild(ground)
        
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("makePipes"), userInfo: nil, repeats: true)
        
    }
    
    func makePipes() {
        let gapHeight = bird.size.height * 4
        
        //create randomness to move gapHeight
        //random number up to half the size of the user's screen
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        
        //limit move to be in between the top and bottom quarters of the screen
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        
        
        //create an animation to spawn and remove pipes from the screen
        let movePipes = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.size.width / 100))
        let removePipes = SKAction.removeFromParent()
        let moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
        
        let pipeTexture = SKTexture(imageNamed: "pipe1.png")
        let pipe1 = SKSpriteNode(texture: pipeTexture)
        pipe1.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + pipeTexture.size().height/2 + gapHeight / 2 + pipeOffset)
        pipe1.runAction(moveAndRemovePipes)
        self.addChild(pipe1)
        
        let pipe2Texture = SKTexture(imageNamed: "pipe2.png")
        let pipe2 = SKSpriteNode(texture: pipe2Texture)
        pipe2.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) - pipe2Texture.size().height/2 - gapHeight / 2 + pipeOffset)
        pipe2.runAction(moveAndRemovePipes)
        self.addChild(pipe2)
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
