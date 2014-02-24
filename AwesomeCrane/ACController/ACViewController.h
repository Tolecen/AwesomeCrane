//
//  ACViewController.h
//  AwesomeCrane
//

//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class ACMyScene;
@interface ACViewController : UIViewController


@property(strong, nonatomic) ACMyScene *scene;
@property BOOL flag;
@property BOOL isAddFric;

@end
