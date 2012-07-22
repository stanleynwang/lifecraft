//
//  LCUserView.m
//  Lifecraft
//
//  Created by Rinik Vojto on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <QuartzCore/QuartzCore.h>
#import "LCUserView.h"
#import "NSString+Utils.h"

@implementation LCUserView

@synthesize user;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSString *email = user.email;
    NSString *hash = [email MD5String];
    NSString *urlString = [[NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@", hash] lowercaseString];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"%@", url);
    

    UIImageView *image = [[UIImageView alloc] initWithFrame:self.bounds];
    [image setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
  
//    CGRect frame = image.frame;
//    frame.origin = CGPointMake(0, 0);
//    image.frame = frame;
    
    [self addSubview:image];
    
    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.contents = (__bridge id)[[UIImage imageNamed:@"Mask.png"] CGImage];
    
    // Apply the mask to your uiview layer
    image.layer.mask = maskLayer;
}

- (void)setFarAway {
}

@end
