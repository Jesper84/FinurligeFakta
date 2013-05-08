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

@interface FaktaViewController ()

@end

@implementation FaktaViewController
@synthesize faktaText, titleLabel, shareButton, queryService;
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
    faktaText.text = [factData valueForKey:@"content"];
    titleLabel.text = [factData valueForKey:@"title"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
