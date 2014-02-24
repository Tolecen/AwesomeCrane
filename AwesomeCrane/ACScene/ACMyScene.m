//
//  ACMyScene.m
//  AwesomeCrane
//
//  Created by liuxiaoyu on 14-2-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ACMyScene.h"

@interface ACMyScene()<SKPhysicsContactDelegate>{
    CGVector vectorForce;
    CGPoint pointForce;
}

@end

@implementation ACMyScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        
        vectorForce=CGVectorMake(5.0f, -10.0f);
        pointForce=CGPointMake(0.0f, 0.0f);
        SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"back5.png"];
        background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
		//        background.physicsBody.area
        background.size=CGSizeMake(400.0f,320.0f);
        [self addChild:background];
        self.isGravity=YES;
		
        
        NSLog(@"self.frame.width=%f,self.frame.height=%f",self.frame.size.width,self.frame.size.height);
        SKPhysicsBody *body = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(40.0f,80.0f, 400.0f,260.0f)];
        self.scene.name = @"boundary";
        self.physicsBody = body;
        self.physicsBody.categoryBitMask = 0x00000001;
        self.physicsBody.collisionBitMask = 0x00000001;
        self.physicsBody.contactTestBitMask = 0x00000001;
		
        
        self.friction = 0.1;//默认的摩擦力的值
        self.physicsWorld.contactDelegate = self;
        
        
        [self creatXianHeWith:CGPointMake(100.0f,230.0f) withName:@"yanweixia"];
        [self creatXianHeWith:CGPointMake(100.0f, 130.0f) withName:@"yanweixia"];
        [self creatXianHeWith:CGPointMake(200.0f, 130.0f) withName:@"yanweixia"];
		
    }
    return self;
    
}

- (void)creatXianHeWith:(CGPoint)startPoint withName:(NSString *)nameString {
    
    CGPoint location = startPoint;
    //
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"walkR01"];
    sprite.name = nameString;
    sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    sprite.physicsBody.affectedByGravity=YES;
    sprite.physicsBody.density=1.0f;
    sprite.physicsBody.affectedByGravity = self.isGravity;
    sprite.physicsBody.friction = self.friction;
    sprite.physicsBody.categoryBitMask = 0x00000001;
    sprite.physicsBody.collisionBitMask = 0x00000001;
    sprite.physicsBody.contactTestBitMask = 0x00000001;
    
    
    sprite.position = location;
    
    
    SKTexture *w01 = [SKTexture textureWithImageNamed:@"walkR01"];
    SKTexture *w02 = [SKTexture textureWithImageNamed:@"walkR02"];
    SKTexture *w03 = [SKTexture textureWithImageNamed:@"walkR03"];
    SKTexture *w04 = [SKTexture textureWithImageNamed:@"walkR04"];
    SKTexture *w05 = [SKTexture textureWithImageNamed:@"walkR05"];
    
    
    SKAction *animation = [SKAction animateWithTextures:@[w01, w02, w03, w04, w05] timePerFrame:0.1];
    //SKAction *walk = [SKAction moveByX:200 y:0 duration:1];
    SKAction *action = [SKAction repeatActionForever:animation];
    //[sprite runAction:[SKAction group:@[action, walk]]];
    [sprite runAction:action];
    //
    
    [self addChild:sprite];
    
}

- (void)turnLeft {
    
	NSLog(@"left");
    vectorForce=CGVectorMake(-10, -10);
    pointForce=CGPointMake(30, 100);
    
    [self enumerateChildNodesWithName:@"yanweixia" usingBlock:^(SKNode *node, BOOL *stop) {
		
		[node.physicsBody applyImpulse:vectorForce atPoint:pointForce];
        
    }];
}

- (void)turnRight {
    
    NSLog(@"right");
    vectorForce=CGVectorMake(10, 10);
    pointForce=CGPointMake(30, 100);
    
    
    [self enumerateChildNodesWithName:@"yanweixia" usingBlock:^(SKNode *node, BOOL *stop) {
        
		[node.physicsBody applyImpulse:vectorForce atPoint:pointForce];
        
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"left");
	//    UITouch touch=[[touches anyObject] objectsAtIndexes:0];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"22222");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"33333");
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    //force是个持续的力，所以必须在每一帧都对物体施加
    [self enumerateChildNodesWithName:@"yanweixia" usingBlock:^(SKNode *node, BOOL *stop) {
        
		//        int randomValue=arc4random()%10;
		//        if (randomValue%2==0) {
		//            randomValue=-randomValue;
		//        }
		//        [node.physicsBody applyImpulse:CGVectorMake(randomValue,0) atPoint:CGPointMake(arc4random()%3, arc4random()%3)];
		
		
    }];
}

- (void)setGravity:(BOOL)flag{
    
    self.isGravity = flag;
    
}

//碰撞处理函数
- (void)didBeginContact:(SKPhysicsContact *)contact{
    NSLog(@"%@, %@", contact.bodyA.node.name, contact.bodyB.node.name);
    if ([contact.bodyA.node.name  isEqual: @"boundary"]) {
        
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.fontSize = 24;
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        label.text = @"小雨是sb";
        [self addChild:label];
        SKAction *wait = [SKAction waitForDuration:2];
        SKAction *clear = [SKAction removeFromParent];
        [label runAction:[SKAction sequence:@[wait, clear]]];
        
        
        SKSpriteNode *sprit=(SKSpriteNode *)[self childNodeWithName:@"yanweixia"];
		//        NSLog(@"sprit.rotation",sprit.physicsBody);
		//        [sprit removeFromParent];
		//
		//        [self creatXianHeWith:CGPointMake(100.0f, 210.0f)];
        
    }
}

@end
