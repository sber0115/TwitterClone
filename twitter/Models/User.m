//
//  User.m
//  twitter
//
//  Created by sbernal0115 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "User.h"
#import "UIImageView+AFNetworking.h"

@implementation User


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        // Initialize any other properties
        self.profileImageURL = dictionary[@"profile_image_url_https"];

    }
    
    
    
    
    return self;
}


@end
