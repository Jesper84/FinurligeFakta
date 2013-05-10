//
//  FaktaViewController.m
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 04/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import "FaktaViewController.h"
#import "FaktaQueryService.h"
#import "MBProgressHUD.h"
#import "WebViewController.h"
#import "FavoriteActivity.h"
#import "NSString+HTML.h"
#import "AppDelegate.h"

@interface FaktaViewController ()

@end

@implementation FaktaViewController
@synthesize faktaText, titleLabel, shareButton, queryService,
sentByLabel, seeMoreButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighligt = [[UIImage imageNamed:@"orangeButtonHighlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [shareButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [shareButton setBackgroundImage:buttonImageHighligt forState:UIControlStateHighlighted];
    [seeMoreButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [seeMoreButton setBackgroundImage:buttonImageHighligt forState:UIControlStateHighlighted];
    
    [self updateFavoriteBadge];
    
    queryService = [[FaktaQueryService alloc] init];
    [queryService setDelegate:self];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [queryService queryGuid];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (IBAction)showShareMenu:(id)sender{
    NSString *shareInfo = [NSString stringWithFormat:@"Finurlig Fakta: \n%@", faktaText.text];
    
    FavoriteActivity *customActivity = [[FavoriteActivity alloc] initWithViewController:self];
    
    __block UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[shareInfo, self.currentFakta] applicationActivities:@[customActivity]];
    activityView.excludedActivityTypes = @[UIActivityTypePostToTwitter];
    [self presentViewController:activityView animated:YES completion:^{
        activityView.excludedActivityTypes = nil;
        activityView = nil;
    }];
}

- (void)addCurrentFactAsFavorite{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate addFactToFavorites:self.currentFakta];
    [self updateFavoriteBadge];
}

- (void)updateFavoriteBadge{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    int number = [delegate.favoriteList count];
    UIViewController *controller = [self.tabBarController.viewControllers objectAtIndex:1];
    
    if (number == 0) {
        controller.tabBarItem.badgeValue = nil;
    } else {
        controller.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", number];
    }
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showWebview"]) {
        WebViewController *webviewController = segue.destinationViewController;
        webviewController.url = self.currentFakta.url;
        webviewController.webViewTitle = self.currentFakta.sourceTitle;
    }
}

- (IBAction)fetchNewFact:(id)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [queryService queryGuid];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (void) createNewFact:(NSDictionary *)factData{
    Fakta *fakta = [[Fakta alloc] init];
    fakta.content = [[factData valueForKey:@"content"] stringByConvertingHTMLToPlainText];
    fakta.title = [factData valueForKey:@"title"];
    NSString *author = [factData valueForKey:@"author"];
    if ([author rangeOfString:@","].location == NSNotFound) {
        fakta.author = author;
    } else {
        NSArray *authorSplit = [[factData valueForKey:@"author"] componentsSeparatedByString:@","];
        fakta.author = [NSString stringWithFormat:@"%@ %@", [authorSplit objectAtIndex:1], [authorSplit objectAtIndex:0]];
    }
    NSArray *sourcesArray = [factData valueForKey:@"sources"];
    NSDictionary *sourcesDict = [sourcesArray objectAtIndex:0];
    fakta.url = [sourcesDict valueForKey:@"url"];
    fakta.sourceTitle = [sourcesDict valueForKey:@"title"];
    
    self.currentFakta = fakta;

}

- (void)factRequestComplete:(NSDictionary *)factData{
    
    [self createNewFact:factData];
    
    faktaText.text = self.currentFakta.content;
    titleLabel.text = self.currentFakta.title;
    sentByLabel.text = self.currentFakta.author;
    
    [faktaText setContentOffset:CGPointMake(0, 0) animated:NO];
    [faktaText flashScrollIndicators];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
