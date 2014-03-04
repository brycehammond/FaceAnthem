// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FAPerson.h instead.

#import <CoreData/CoreData.h>


extern const struct FAPersonAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *recognitionIdentifier;
} FAPersonAttributes;

extern const struct FAPersonRelationships {
	__unsafe_unretained NSString *pictures;
} FAPersonRelationships;

extern const struct FAPersonFetchedProperties {
} FAPersonFetchedProperties;

@class FAPicture;




@interface FAPersonID : NSManagedObjectID {}
@end

@interface _FAPerson : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FAPersonID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* recognitionIdentifier;



@property int32_t recognitionIdentifierValue;
- (int32_t)recognitionIdentifierValue;
- (void)setRecognitionIdentifierValue:(int32_t)value_;

//- (BOOL)validateRecognitionIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *pictures;

- (NSMutableSet*)picturesSet;





@end

@interface _FAPerson (CoreDataGeneratedAccessors)

- (void)addPictures:(NSSet*)value_;
- (void)removePictures:(NSSet*)value_;
- (void)addPicturesObject:(FAPicture*)value_;
- (void)removePicturesObject:(FAPicture*)value_;

@end

@interface _FAPerson (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveRecognitionIdentifier;
- (void)setPrimitiveRecognitionIdentifier:(NSNumber*)value;

- (int32_t)primitiveRecognitionIdentifierValue;
- (void)setPrimitiveRecognitionIdentifierValue:(int32_t)value_;





- (NSMutableSet*)primitivePictures;
- (void)setPrimitivePictures:(NSMutableSet*)value;


@end
