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

@interface FaktaViewController ()

@end

@implementation FaktaViewController
@synthesize faktaText, titleLabel, shareButton, queryService,
sentByLabel, seeMoreButton, currentFactURL, currentMoreTitle;
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
    __block UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[shareInfo] applicationActivities:nil];
    activityView.excludedActivityTypes = @[UIActivityTypePostToTwitter];
    [self presentViewController:activityView animated:YES completion:^{
        activityView.excludedActivityTypes = nil;
        activityView = nil;
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showWebview"]) {
        WebViewController *webviewController = segue.destinationViewController;
        webviewController.url = currentFactURL;
        webviewController.webViewTitle = currentMoreTitle;
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

- (void)factRequestComplete:(NSDictionary *)factData{
    NSLog(@"Valid: %d", [NSJSONSerialization isValidJSONObject:factData]);
    faktaText.text = [factData valueForKey:@"content"];
    titleLabel.text = [factData valueForKey:@"title"];
    sentByLabel.text = [factData valueForKey:@"author"];
    NSArray *sourcesArray = [factData valueForKey:@"sources"];
    NSDictionary *sourcesDict = [sourcesArray objectAtIndex:0];
    self.currentFactURL = [sourcesDict valueForKey:@"url"];
    self.currentMoreTitle = [sourcesDict valueForKey:@"title"];
    [faktaText flashScrollIndicators];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
