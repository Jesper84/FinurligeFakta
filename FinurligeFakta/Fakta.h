//
//  Fakta.h
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 05/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fakta : NSObject <NSCoding>
@property (nonatomic, copy) NSString *guid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *sourceTitle;
@end
