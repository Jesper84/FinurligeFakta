//
//  FavoriteActivity.m
//  Oelspil
//
//  Created by Jesper Nielsen on 28/08/12.
//
//

#import "FavoriteActivity.h"
#import "Fakta.h"
@implementation FavoriteActivity

- (id)initWithViewController:(FaktaViewController *)controller{
    self.controller = controller;
    return self;
}

- (NSString *)activityTitle{
    return @"Tilføj favorit";
}

- (NSString *)activityType{
    return @"favorit";
}

- (UIImage *)activityImage{
    return [UIImage imageNamed:@"star-white"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems{
    BOOL canPerform = NO;
    for (id object in activityItems) {
        if ([object isKindOfClass:[Fakta class]]) {
            canPerform = YES;
        }
    }
    return canPerform;
}

- (void)performActivity{
    [self.controller addCurrentFactAsFavorite];
    [self activityDidFinish:YES];
}

- (void)prepareWithActivityItems:(NSArray *)activityItems{
    for (id object in activityItems) {
        if ([object isKindOfClass:[Fakta class]]) {
            self.fakta = (Fakta *)object;
        }
    }
}

- (UIViewController *)activityViewController{
    return nil;
}

- (void)activityDidFinish:(BOOL)completed{
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

@end
