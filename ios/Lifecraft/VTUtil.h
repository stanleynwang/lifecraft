//
//  RNUtil.h
//  Viatag
//
//  Created by Rinik Vojto on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>

#define RNPostNotification(name) [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:name object:nil]]
#define RNObserveNotification(notifName,sel) [[NSNotificationCenter defaultCenter] addObserver:self selector:sel name:notifName object:nil]
