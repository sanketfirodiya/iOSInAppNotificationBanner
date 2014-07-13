//
//  ViewController.m
//  InAppNotificationBanner
//
//  Created by Firodiya, Sanket on 7/12/14.
//  Copyright (c) 2014 com.webawesome. All rights reserved.
//

#import "ViewController.h"
#import "GlobalConstants.h"

#define BUTTON_WIDTH 220.0
#define BUTTON_HEIGHT 40.0

@interface ViewController ()

@end

@implementation ViewController {
    BOOL showingNotification;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - BUTTON_WIDTH)/2, (self.view.frame.size.height - BUTTON_HEIGHT)/2, BUTTON_WIDTH, BUTTON_HEIGHT)];
    
    button.backgroundColor = [UIColor colorWithRed:0.000 green:0.678 blue:0.804 alpha:1.000];
    [button setTitle:@"Show notification banner" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showInAppPushBanner:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showInAppPushBanner:) name:NEW_PUSH_NOTIFICATION object:nil];
}

#define BANNER_HEIGHT 66.0

- (void)showInAppPushBanner:(NSNotification *)notification {
    
    if (!showingNotification) {
        showingNotification = YES;
        
        // retrieve message from your actual notification here
        NSString *message = @"Showing message from notification";
        
        UIToolbar *newmessageBannerView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, -BANNER_HEIGHT, self.view.frame.size.width, BANNER_HEIGHT)];
        newmessageBannerView.translucent = YES;
        newmessageBannerView.barTintColor = [UIColor colorWithWhite:0.074 alpha:0.550];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 33.0, 16.0, 16.0)];
        imageView.image = [UIImage imageNamed:@"AppIcon_24"];
        [newmessageBannerView addSubview:imageView];
        [self.view addSubview:newmessageBannerView];
        
        UILabel *bannerLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 30.0, 320.0, 22.0)];
        bannerLabel.textAlignment =  NSTextAlignmentLeft;
        bannerLabel.textColor = [UIColor whiteColor];
        bannerLabel.font = [UIFont systemFontOfSize:17.0];
        bannerLabel.text = message;
        [newmessageBannerView addSubview:bannerLabel];
        
        [UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             newmessageBannerView.frame = CGRectMake(0, 0, self.view.frame.size.width, BANNER_HEIGHT);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.25 delay:2.0 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  newmessageBannerView.frame = CGRectMake(0, -BANNER_HEIGHT, self.view.frame.size.width, BANNER_HEIGHT);
                                              }completion:^(BOOL finished) {
                                                  [newmessageBannerView removeFromSuperview];
                                                  showingNotification = NO;
                                              }];
                         }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
