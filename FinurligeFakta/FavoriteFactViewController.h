//
//  FavoriteFactViewController.h
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 11/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fakta.h"
@interface FavoriteFactViewController : UIViewController
@property (strong, nonatomic) Fakta *selectedFact;
@property (strong, nonatomic) IBOutlet UILabel *factTitle;
@property (strong, nonatomic) IBOutlet UITextView *factText;
@property (strong, nonatomic) IBOutlet UILabel *sentByLabel;
@end
