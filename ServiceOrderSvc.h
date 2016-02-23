//
//  ServiceOrderSvc.h
//  Roofster
//
//  Created by Travis  on 1/31/16.
//  Copyright © 2016 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceOrder.h"

@protocol ServiceOrderSvc <NSObject>

- (ServiceOrder *) createServiceOrder: (ServiceOrder *) serviceOrder;
- (NSArray *) retrieveAllServiceOrders;
- (ServiceOrder *) updateServiceOrder: (ServiceOrder *) serviceOrder;
- (ServiceOrder *) deleteServiceOrder: (ServiceOrder *) serviceOrder;

@end
