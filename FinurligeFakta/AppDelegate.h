//
//  AppDelegate.h
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 04/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fakta.h"
#define kFavoriteList @"favorites.plist"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *favoriteList;
- (void)addFactToFavorites:(Fakta *)fact;
- (void)loadFavoriteList;
- (void)saveFavoriteList;
- (void)removeFactFromFavoriteList:(Fakta *)fact;

@end
