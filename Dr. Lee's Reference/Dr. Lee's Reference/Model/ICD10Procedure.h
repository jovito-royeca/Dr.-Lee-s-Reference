//
//  ICD10Procedure.h
//  Dr. Lee's Reference
//
//  Created by Jovito Royeca on 4/22/14.
//  Copyright (c) 2014 Jovito Royeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ICD10Procedure;

@interface ICD10Procedure : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * version;
@property (nonatomic, retain) ICD10Procedure *section;
@property (nonatomic, retain) ICD10Procedure *bodySystem;
@property (nonatomic, retain) ICD10Procedure *operation;
@property (nonatomic, retain) ICD10Procedure *bodyPart;
@property (nonatomic, retain) ICD10Procedure *approach;
@property (nonatomic, retain) ICD10Procedure *device;
@property (nonatomic, retain) ICD10Procedure *qualifier;
@property (nonatomic, retain) NSSet *children;
@property (nonatomic, retain) ICD10Procedure *parent;
@end

@interface ICD10Procedure (CoreDataGeneratedAccessors)

- (void)insertObject:(ICD10Procedure *)value inChildrenAtIndex:(NSUInteger)idx;
- (void)removeObjectFromChildrenAtIndex:(NSUInteger)idx;
- (void)insertChildren:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeChildrenAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInChildrenAtIndex:(NSUInteger)idx withObject:(ICD10Procedure *)value;
- (void)replaceChildrenAtIndexes:(NSIndexSet *)indexes withChildren:(NSArray *)values;
- (void)addChildrenObject:(ICD10Procedure *)value;
- (void)removeChildrenObject:(ICD10Procedure *)value;
- (void)addChildren:(NSSet *)values;
- (void)removeChildren:(NSSet *)values;
@end