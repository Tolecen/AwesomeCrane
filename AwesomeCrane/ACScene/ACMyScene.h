//
//  ACMyScene.h
//  AwesomeCrane
//

//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ACMyScene : SKScene


@property BOOL isGravity;
@property float friction;

- (void)setGravity:(BOOL)flag;
- (void)turnLeft;
- (void)turnRight;

@end
