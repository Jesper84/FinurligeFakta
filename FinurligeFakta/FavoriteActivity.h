//
//  FavoriteActivity.h
//  Oelspil
//
//  Created by Jesper Nielsen on 28/08/12.
//
//

#import <UIKit/UIKit.h>
#import "FaktaViewController.h"
#import "Fakta.h"
@interface FavoriteActivity : UIActivity
@property (nonatomic, strong) FaktaViewController *controller;
@property (nonatomic, strong) Fakta *fakta;

- (NSString *)activityType;
- (NSString *)activityTitle;
- (UIImage *)activityImage;
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems;
- (void)prepareWithActivityItems:(NSArray *)activityItems;
- (UIViewController *)activityViewController;
- (void)performActivity;
- (void)activityDidFinish:(BOOL)completed;
- (id)initWithViewController:(FaktaViewController *)controller;
@end
