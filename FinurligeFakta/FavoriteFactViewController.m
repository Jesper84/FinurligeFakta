//
//  FavoriteFactViewController.m
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 11/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import "FavoriteFactViewController.h"
#import "WebViewController.h"
@interface FavoriteFactViewController ()

@end

@implementation FavoriteFactViewController
@synthesize selectedFact, factText, factTitle, shareButton, seeMoreButton;
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
    
    self.factTitle.text = self.selectedFact.title;
    self.factText.text = self.selectedFact.content;
    self.sentByLabel.text = self.selectedFact.author;
    self.navigationItem.title = self.selectedFact.title;
    
    self.factText.hidden = NO;
    self.factTitle.hidden = NO;
    self.sentByLabel.hidden = NO;
}

- (IBAction)showShareMenu:(id)sender{
    NSString *shareInfo = [NSString stringWithFormat:@"Finurlig Fakta: \n%@", factText.text];
    
    
    __block UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[shareInfo] applicationActivities:nil];
    activityView.excludedActivityTypes = @[UIActivityTypePostToTwitter];
    [self presentViewController:activityView animated:YES completion:^{
        activityView.excludedActivityTypes = nil;
        activityView = nil;
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showWebViewFavorite"]) {
        WebViewController *webviewController = segue.destinationViewController;
        webviewController.url = self.selectedFact.url;
        webviewController.webViewTitle = self.selectedFact.sourceTitle;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
