//
//  WebViewController.h
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 09/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *webViewTitle;

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

@property (nonatomic) BOOL webViewLoading;
@end
