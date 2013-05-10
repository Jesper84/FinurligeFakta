//
//  AppDelegate.h
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 04/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kFavoriteList @"favorite.plist"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSArray *favoriteList;

- (void)saveFavoriteList:(NSArray *)favorites;

- (NSArray *)loadFavoriteList;

@end
