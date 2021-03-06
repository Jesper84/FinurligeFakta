//
//  WebViewController.m
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 09/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import "WebViewController.h"
#import "MBProgressHUD.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize webView, url, webViewTitle, webViewLoading;
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
    self.navBar.topItem.title = webViewTitle;
    self.webView.suppressesIncrementalRendering = YES;
    self.webView.delegate = self;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];

}

- (IBAction)okPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"startload");
    if(!self.webViewLoading){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Henter side...";
        self.webViewLoading = YES;
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finishload");
    if (!self.webView.loading) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
