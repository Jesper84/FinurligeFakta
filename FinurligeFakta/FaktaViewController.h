//
//  FaktaViewController.h
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 04/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaktaQueryService.h"

@interface FaktaViewController : UIViewController <FaktaQueryDelegate>

@property (nonatomic, strong) IBOutlet UITextView *faktaText;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;

@end
