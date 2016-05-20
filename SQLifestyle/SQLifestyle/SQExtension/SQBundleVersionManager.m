//
//  SQBundleVersionManager.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQBundleVersionManager.h"
#import "SQTabBarController.h"
#import "SQNewFeatureViewController.h"
#import "SQViewController.h"
#import "UIImage+SQExtension.h"

@implementation SQBundleVersionManager

+ (instancetype)manager {
    return [[self alloc]init];
}

- (void)setWindow:(UIWindow *)window {
    _window = window; [self prepareForBundleVersionKey];
}

- (void)prepareForBundleVersionKey {
    
    NSString * key = @"CFBundleVersion";
    NSUserDefaults * userDefaults   = [NSUserDefaults standardUserDefaults];
    NSString       * lastVersion    = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    NSString       * currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        self.window.rootViewController = [self getTabbarController];
    } else {
        self.window.rootViewController = [self getNewFeatureController];
        [userDefaults setObject:currentVersion forKey:key];
        [userDefaults synchronize];
    }
}

- (SQNewFeatureViewController *)getNewFeatureController {
    
    __weak typeof(self) _self = self;
    SQNewFeatureViewController * newfeature = [SQNewFeatureViewController new];
    newfeature.newfeatureImages = @[@"NewFeature.jpg",@"NewFeature.jpg"];
    newfeature.enterButtonImage = [UIImage imageWithColor:[UIColor whiteColor]];
    newfeature.block = ^{
        _self.window.rootViewController = [self getTabbarController];
    };
    return newfeature;
}

- (SQTabBarController *)getTabbarController {
    
    return [SQTabBarController tabbarWithViewControllers:@[[SQViewController new]]
                                                  titles:@[@"LifeStyle"]
                                              imageNames:@[@""]
                                      selectedImageNames:@[@""]];
    
}

@end
