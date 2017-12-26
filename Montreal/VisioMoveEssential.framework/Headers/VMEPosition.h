/*
 * Copyright 2016, Visioglobe SAS
 * ALL RIGHTS RESERVED
 *
 *
 * LICENSE: Visioglobe grants the user ("Licensee") permission to reproduce,
 * distribute, and create derivative works from this Source Code,
 * provided that: (1) the user reproduces this entire notice within
 * both source and binary format redistributions and any accompanying
 * materials such as documentation in printed or electronic format;
 * (2) the Source Code is not to be used, or ported or modified for
 * use, except in conjunction with Visioglobe SDK; and (3) the
 * names of Visioglobe SAS may not be used in any
 * advertising or publicity relating to the Source Code without the
 * prior written permission of Visioglobe.  No further license or permission
 * may be inferred or deemed or construed to exist with regard to the
 * Source Code or the code base of which it forms a part. All rights
 * not expressly granted are reserved.
 *
 * This Source Code is provided to Licensee AS IS, without any
 * warranty of any kind, either express, implied, or statutory,
 * including, but not limited to, any warranty that the Source Code
 * will conform to specifications, any implied warranties of
 * merchantability, fitness for a particular purpose, and freedom
 * from infringement, and any warranty that the documentation will
 * conform to the program, or any warranty that the Source Code will
 * be error free.
 *
 * IN NO EVENT WILL VISIOGLOBE BE LIABLE FOR ANY DAMAGES, INCLUDING, BUT NOT
 * LIMITED TO DIRECT, INDIRECT, SPECIAL OR CONSEQUENTIAL DAMAGES,
 * ARISING OUT OF, RESULTING FROM, OR IN ANY WAY CONNECTED WITH THE
 * SOURCE CODE, WHETHER OR NOT BASED UPON WARRANTY, CONTRACT, TORT OR
 * OTHERWISE, WHETHER OR NOT INJURY WAS SUSTAINED BY PERSONS OR
 * PROPERTY OR OTHERWISE, AND WHETHER OR NOT LOSS WAS SUSTAINED FROM,
 * OR AROSE OUT OF USE OR RESULTS FROM USE OF, OR LACK OF ABILITY TO
 * USE, THE SOURCE CODE.
 *
 * Contact information:  Visioglobe SAS,
 * 55, rue Blaise Pascal
 * 38330 Monbonnot Saint Martin
 * FRANCE
 * or:  http://www.visioglobe.com
 */

#import <Foundation/Foundation.h>

/**
 * A VMEPosition object represents a position incorporating the geographical 
 * coordinates, altitude and associated building and floor.
 *
 * Typically, you can use a VMEPosition object when moving the camera, anchoring overlays to the map,
 * creating a route from a position, etc.
 *
 * @version 1.1
 */
@interface VMEPosition : NSObject <NSCopying>

/**
 * Constructor for creating a position object inside
 *
 * @param latitude The position's latitude
 * @param longitude The position's longitude
 * @param altitude The position's altitude, relative to the floor.  For example
 * if the altitude is 10m, then the position will be 10m above the floor.
 * @param buildingID The ID of the building where the position is located.  If nil,
 * then the first building found that contains the floor.
 * @param floorID The ID of the floor where the position is located.  If nil, then 
 * the default floor associated with the building will be used.
 * , then the position will be in the global layer.
 *
 * @note If both buildingID and floorID are nil, then the position is outside.
 *
 * @version 1.1
 */
-(instancetype) initWithLatitude:(double)latitude
                       longitude:(double)longitude
                        altitude:(double)altitude
                      buildingID:(NSString*)buildingID
                         floorID:(NSString*)floorID;

/**
 * Constructor for creating a position object outside
 *
 * @param latitude The position's latitude
 * @param longitude The position's longitude
 * @param altitude The position's altitude, relative to the outside.  For example
 * if the altitude is 10m, then the position will be 10m above the ground.
 *
 * @version 1.1
 */
-(instancetype) initWithLatitude:(double)latitude
                       longitude:(double)longitude
                        altitude:(double)altitude;

/**
 * Determines if this object is equal to another VMEPosition object.
 *
 * @param position The object to compare self to.
 * @returns YES if the objects are equal, otherwise NO.
 *
 * @version 1.2
 */
-(BOOL) isEqualToPosition:(VMEPosition*)position;

/**
 * The latitude of the position.
 *
 * @version 1.1
 */
@property (nonatomic) double latitude;
/**
 * The longitude of the position.
 *
 * @version 1.1
 */
@property (nonatomic) double longitude;
/**
 * The altitude of the position.
 *
 * @version 1.1
 */
@property (nonatomic) double altitude;
/**
 * The building ID to associate with the position.  If nil, then will attempt to
 * find the best fit building givein the floorID.
 *
 * @note If both buildingID and floorID are nil, then the position will be located
 * in the global layer.
 *
 * @version 1.1
 */
@property (nonatomic, strong) NSString* buildingID;
/**
 * The floor ID of the position.  If nil, then the default floor ID associated with 
 * buildingID will be used.
 *
 * @note If both buildingID and floorID are nil, then the position will be located
 * in the global layer.
 *
 * @version 1.1
 */
@property (nonatomic, strong) NSString* floorID;

@end
