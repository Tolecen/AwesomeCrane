//
//  ACViewController.m
//  AwesomeCrane
//
//  Created by liuxiaoyu on 14-2-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ACViewController.h"
#import "ACMyScene.h"

@interface ACViewController()

@property (weak, nonatomic) IBOutlet UIButton *Gravity;
@property (weak, nonatomic) IBOutlet UIButton *frictionBtn;


@end

@implementation ACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.flag = YES;
    self.isAddFric = YES;
    
    UIButton *buttonLeft=[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonLeft setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [buttonLeft setFrame:CGRectMake(0.0f,197.5f, 94.5f/2.5f,97.5f/2.5f)];
    [buttonLeft addTarget:self action:@selector(turnLeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLeft];
    
    UIButton *buttonRight=[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonRight setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    buttonRight.transform=CGAffineTransformMakeRotation(3.1415926);
    [buttonRight setFrame:CGRectMake(self.view.frame.size.width-94.5f/2.5f,197.5f,94.5f/2.5f,97.5f/2.5f)];
    [buttonRight addTarget:self action:@selector(turnRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRight];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	SKView * skView = (SKView *)self.view;
	
	if (!skView.scene) {
		skView.showsFPS = YES;
		skView.showsNodeCount = YES;
		
		// Create and configure the scene.
		SKScene * scene = [ACMyScene sceneWithSize:skView.bounds.size];
		scene.scaleMode = SKSceneScaleModeAspectFill;
		
		// Present the scene.
		[skView presentScene:scene];
	}
}
#pragma TargetAction
- (void)turnLeftBtnClick {
    [self.scene turnLeft];
}

- (void)turnRightBtnClick {
    [self.scene turnRight];
}

- (IBAction)isGravity:(UIButton *)sender {
	if(self.flag){
        [self.Gravity setTitle:@"取消重力" forState:UIControlStateNormal];
        [self.scene setGravity:YES];
        self.flag = false;
    }
    else{
        [self.Gravity setTitle:@"添加重力" forState:UIControlStateNormal];
        [self.scene setGravity:NO];
        self.flag = true;
    }
}

- (IBAction)setFriction:(UIButton *)sender {
	if(self.isAddFric){
        [self.frictionBtn setTitle:@"还原摩擦" forState:UIControlStateNormal];
        self.scene.friction = 1.0;
        self.isAddFric = false;
    }
    else{
        [self.frictionBtn setTitle:@"加大摩擦" forState:UIControlStateNormal];
        self.scene.friction = 0.2;
        self.isAddFric = true;
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
