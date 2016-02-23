//
//  ServiceOrder+CoreDataProperties.h
//  Roofster
//
//  Created by Travis  on 2/22/16.
//  Copyright © 2016 msse650. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ServiceOrder.h"

NS_ASSUME_NONNULL_BEGIN

@interface ServiceOrder (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *repairDetail;

@end

NS_ASSUME_NONNULL_END
