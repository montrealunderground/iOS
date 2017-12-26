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
#import <UIKit/UIkit.h>
#import "VMEPosition.h"
#import "VMEMacros.h"


#pragma mark - VMEPlaceOrientation
/**
 * @brief VMEPlaceOrientation represents an orientation element that may be
 * associated with a place object.
 *
 * It encapsulates some logic for controlling the camera's heading. It should only
 * be constructed using the factory helper methods below.
 * @version 1.1
 */
@interface  VMEPlaceOrientation : NSObject
/**
 * Place is always camera facing.
 *
 * @version 1.1
 * @deprecated Deprecated in 1.2.  Replaced with VMEPlaceOrientation::placeOrientationFacing
 */
+(instancetype)initPlaceOrientationFacing VME_DEPRECATED_MSG("Please use placeOrientationFacing");

/**
 * Place is always camera facing.
 *
 * @version 1.2
 */
+(instancetype)placeOrientationFacing;

/**
 * Place is flat on ground and facing camera
 *
 * @version 1.1
 * @deprecated Deprecated in 1.2.  Replaced with VMEPlaceOrientation::placeOrientationFlat
 */
+(instancetype)initPlaceOrientationFlat VME_DEPRECATED_MSG("Please use placeOrientationFlat");

/**
 * Place is flat on ground and facing camera
 *
 * @version 1.2
 */
+(instancetype)placeOrientationFlat;

/**
 * Place is flat on ground and has a fixed heading
 *
 * @version 1.1
 * @deprecated Deprecated in 1.2.  Replaced with VMEPlaceOrientation::placeOrientationFixedWithHeading:
 */
+(instancetype)initPlaceOrientationFixedWithHeading:(float)heading VME_DEPRECATED_MSG("Please use placeOrientationFixedWithHeading:");

/**
 * Place is flat on ground and has a fixed heading
 *
 * @version 1.2
 */
+(instancetype)placeOrientationFixedWithHeading:(float)heading;

@end


#pragma mark - VMEPlaceAnchorMode
/**
 * This enum defines the possible anchor modes.
 * An anchor mode determines how an place object is
 * anchored to a given position.
 *
 * @version 1.1
 */
typedef NS_ENUM(NSInteger, VMEPlaceAnchorMode) {
    /**
     * Anchor to the top left.
     *
     * @version 1.1
     */
    VMEPlaceAnchorModeTopLeft,
    /**
     * Anchor to the top center
     *
     * @version 1.1
     */
    VMEPlaceAnchorModeTopCenter,
    /**
     * Anchor to the top right
     *
     * @version 1.1
     */
    VMEPlaceAnchorModeTopRight,
    /**
     * Anchor to the center left
     *
     * @version 1.1
     */
    VMEPlaceAnchorModeCenterLeft,
    /**
     * Anchor to the center
     *
     * @version 1.1
     */
    VMEPlaceAnchorModeCenter,
    /**
     * Anchor to the center right
     *
     * @version 1.1
     */
    VMEPlaceAnchorModeCenterRight,
    /**
     * Anchor to the bottom left
     *
     * @version 1.1
     */
    VMEPlaceAnchorModeBottomLeft,
    /**
     * Anchor to the bottom center
     *
     * @version 1.1
     */
    VMEPlaceAnchorModeBottomCenter,
    /**
     * Anchor to the bottom right
     *
     * @version 1.1
     */
    VMEPlaceAnchorModeBottomRight

};


#pragma mark - VMEPlaceAltitudeMode
/**
 * This enum defines the possible altitude modes. An altitude mode determines
 * how the altitude is interpreted.
 *
 * @version 1.1
 */
typedef NS_ENUM(NSInteger, VMEPlaceAltitudeMode) {
    /**
     * The altitude is interpreted relative to the terrain.
     *
     * @version 1.1
     */
    VMEPlaceAltitudeModeRelative,
    /**
     * The altitude is interpreted as the height above the WGS84 ellipsoid
     *
     * @version 1.1
     */
    VMEPlaceAltitudeModeAbsolute
};


#pragma mark - VMEPlaceDisplayMode
/**
 * This enum defines the possible display modes. A display mode determines
 * how the point is displayed within the map.
 *
 * @version 1.1
 */
typedef NS_ENUM(NSInteger, VMEPlaceDisplayMode) {
    /**
     * The place will obscured when located behind map surfaces.
     *
     * @version 1.1
     */
    VMEPlaceDisplayModeInlay,
    /**
     * The place is displayed on top of all map surfaces, regardless of whether
     * they are physical infront of the place.
     *
     * @version 1.1
     */
    VMEPlaceDisplayModeOverlay
};


#pragma mark - VMEPlaceVisibilityRamp
/**
 * An object that controls the place's visibility as a function of the camera's
 * altitude.
 *
 * @version 1.1
 */
@interface VMEPlaceVisibilityRamp : NSObject
/**
 * Creates a visibility ramp object with some default values.
 *
 * @note When using this method, the other properties of the object are initialized
 * to appropriate values. See the property default values for more info.
 *
 * @version 1.1
 */
-(instancetype)init;
/**
 * Creates a visibility ramp object with a user defined ramp.
 *
 * @param startVisible Distance in meters at which it starts becoming visible.
 * @param fullyVisible Distance in meters at which it is fully visible.
 * @param startInvisible Distance in meters at which it starts to become invisible.
 * @param fullyInVisible Distance in meters at which it is fully invisible.
 *
 * @version 1.1
 */
-(instancetype)initWithStartVisible:(double)startVisible
                       fullyVisible:(double)fullyVisible
                     startInvisible:(double)startInvisible
                     fullyInVisible:(double)fullyInVisible;

/**
 * Distance in meters at which it starts becoming visible. If set to 0.0, it is
 * always visble no matter how close you are.
 *
 * The default value of this property is 2.0.
 *
 * @version 1.1
 */
@property (nonatomic) double startVisible;
/**
 * Distance in meters at which it is fully visible. If set to 0.0, it is always
 * visible when you are close.
 *
 * The default value of this property is 5.0.
 *
 * @version 1.1
 */
@property (nonatomic) double fullyVisible;
/**
 * Distance in meters at which it starts to become invisible.
 *
 * The default value of this property is 3000.
 *
 * @version 1.1
 */
@property (nonatomic) double startInvisible;
/**
 * Distance in meters at which it is fully invisible. If set to a very large
 * value, it will never fade out.
 *
 * The default value of this property is 5000.
 *
 * @version 1.1
 */
@property (nonatomic) double fullyInvisible;
@end


#pragma mark - VMEPlaceSize
/**
 * An object that determines the size of the place within the map
 * @version 1.1
 */
@interface VMEPlaceSize : NSObject
/**
 * Create an place size object with a scale
 *
 * @param scale The scale in meters to apply to the place.
 *
 * @version 1.1
 */
-(instancetype)initWithScale:(float)scale;
/**
 * Create an place size object with a scale and a constant size distance.
 *
 * @param scale The scale in meters to apply to the place.
 * @param constantSizeDistance Controls the distance at which the place does not
 * become bigger as you approach it
 *
 * @version 1.1
 */
-(instancetype)initWithScale:(float)scale
        constantSizeDistance:(float)constantSizeDistance;
/**
 * Controls the distance at which the place does not become bigger as you approach
 * it. When the camera is within this distance of the place, the visible size of
 * the place on the screen will be the same as what it looked like when it was
 * constantSizeDistance meters away. If set to 0.0, the size of the place will be
 * determined by scale, regardless of it's distance from the camera.
 *
 * Default value is set to 0.
 *
 * @version 1.1
 */
@property (nonatomic) float constantSizeDistance;
/**
 * The scale in meters to apply to the place.
 *
 * @version 1.1
 */
@property (nonatomic) float scale;
@end


#pragma mark - VMEPlaceInterface

/**
 * Interface protocol for managing places within the map.
 *
 * Places are POI's within the map.  Using the methods in this interface, it's possible to perform
 * certain actions to the place, such changing it's associated data.
 *
 * Depending on the type of place, some actions may not be possible.  For example, only a place that
 * is a surface can have it's color set.
 *
 * Places can be either:
 * - static - Static places are created within VisioMapEditor by assigning an ID to either a surface
 * or an icon.  When the map is built that are embedded within the map bundle.
 * - dynamic - Dynamic places are icons that added to the map at run time.  It's not currently
 *             possible to create a route to or from a dynamic place.
 *
 * @version 1.1
 */
@protocol VMEPlaceInterface <NSObject>

/**
 * Update the place data content within the map.
 *
 * This should be called within the VMEMapListener::mapReadyForPlaceUpdate: notification.
 *
 * @param data An NSDictionary object that contains the updated place data.  See the
 * below json snippet for the valid format.
 *
 * @note Applies to:
 * - static places
 *
@code
// The localization that corresponds with places within the map
{
    // Optional
    // This object contains a list of place objects
    "places": {
        // Required
        // The <id> must correspond with a place id
        // within the map bundle
        "<id>": {
            // Required
            // Display name of the place.
            "name": "<string>",
            // Optional
            // The path of an icon that’s associated with
            // the place.  The icon path can be either
            // relative to the resources directory or an
            // external https link
            "icon": "<string>",
            // Optional
            // The categories associated with the place.
            // An array of category ids.
            "categories": [<string>],
            // Optional
            // The description can contain html or an
            // external https link
            "description": "<string>"
        }
    },
    // Optional
    // This object contains a list of category objects
    "categories": {
        // Required
        "<id>": {
            // Required
            // Display name of the category.
            "name": "<string>",
            // Optional
            // The path of an icon that’s associated with
            // the place.  The icon path can be either
            // relative to the resources directory or an
            // external https link
            "icon": "<string>"
        }
    }
}
@endcode
 *
 * @version 1.0
 *
 * <b>Example</b>
 @code
-(void) mapReadyForPlaceUpdate:(VMEMapView *)mapView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"visio_island_cms_update" ofType:@"json"];
    NSData *returnedData = [[NSFileManager defaultManager] contentsAtPath:path];

    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:returnedData
                     options:0
                     error:&error];

        if(error == nil
           && [object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *results = object;
            [mapView updatePlaceData:[results valueForKeyPath:@"locale.en"]];
        }
    }
}
 @endcode
 */
-(void) updatePlaceData:(NSDictionary*) data;

/**
 * Updates the place data associated with a place ID.
 *
 * @param placeID The place ID who's data is to change
 * @param data The data that will be used to update the place.  Pass nil to remove data from map.
 *
 * @note For best performance, use updatePlaceData to populate the initial place
 * data.
 *
 * @return YES if the places data was updated, otherwise NO.
 *
 * @note Applies to:
 * - dynamic places
 * - static places
 *
 * @version 1.1
 */
-(BOOL) setPlaceID:(NSString*)placeID data:(NSDictionary*)data;

/**
 * Update the place's color.
 *
 * @param placeID The place ID
 * @param color The color to apply to the place.
 *
 * @return YES if the places color was updated, otherwise NO.
 *
 * @note Applies to:
 * - static places
 *
 * @version 1.1
 */
-(BOOL) setPlaceID:(NSString*)placeID color:(UIColor *)color;

/**
 * Reset the place's color back to it's initial value.
 *
 * @param placeID The place ID
 *
 * @return YES if the places color was reset, otherwise NO.
 *
 * @note Applies to:
 * - static places
 *
 * @version 1.1
 */
-(BOOL) resetPlaceIDColor:(NSString*)placeID;


/**
 * Adds a dynamic place to the map.
 *
 * @param placeID The ID of the place.  If the ID corresponds to an existing dynamic
 * place, then it will be replaced.  If the ID corresponds with a static place ID,
 * then this call will fail.
 * @param imageURL A URL that references an image that will be used to represent
 * the place within the map.  Secure http (i.e. https) is not currently supported.
 * @param data A data object for populating the place information. See code snippet
 * below for the expected format.
 * @param position The place's position within the map
 * @param size Controls the place's size
 * @param anchorMode Determines how the place will be anchored to the map.
 * @param altitudeMode Determines how to interpret the altitude attribute of the
 * position parameter.
 * @param displayMode Determines how the place is displayed
 * @param orientation Controls the place's orientation
 * @param visibilityRamp Controls the place's visibility
 *
 * @return YES if the place was successfully added to the map, otherwise NO.
 *
 * @note This method will only work if called during or after the 
 * VMEMapListener::mapDidLoad: method.  It will not work if called within the 
 * VMEMapListener::mapReadyForPlaceUpdate:.
 *
 * @note Applies to:
 * - dynamic places
 *
 @code

 VMEPosition* lPos = [[VMEPosition alloc] initWithLatitude:45.74131
                                                 longitude:4.88216
                                                  altitude:0.0
                                                buildingID:nil
                                                   floorID:nil];

 NSDictionary *placeData = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Cat tracker", @"name",
                            @"https://en.wikipedia.org/wiki/Cat", @"description",
                            @"http://www.clipartbest.com/cliparts/aTe/K4e/aTeK4en8c.png", @"icon",
                            @[@"2", @"3", @"99"], @"categories",
                            nil];

 NSURL* lIconUrl = [NSURL URLWithString:@"http://www.clipartbest.com/cliparts/aTe/K4e/aTeK4en8c.png"];

 [self.mapView addPlaceID:@"cat_tracker_id"
                 imageURL:lIconUrl
                     data:placeData
                 position:lPos
                     size:[[VMEPlaceSize alloc] initWithScale:50.0]
               anchorMode:VMEPlaceAnchorModeBottomCenter
             altitudeMode:VMEPlaceAltitudeModeRelative
              displayMode:VMEPlaceDisplayModeOverlay
              orientation:[VMEPlaceOrientation placeOrientationFacing]
           visibilityRamp:[[VMEPlaceVisibilityRamp alloc] init]
  ];
 @endcode
 *
 * @version 1.1
 */
-(BOOL) addPlaceID:(NSString*)placeID
          imageURL:(NSURL*)imageURL
              data:(NSDictionary*)data
          position:(VMEPosition*)position
              size:(VMEPlaceSize*)size
        anchorMode:(VMEPlaceAnchorMode)anchorMode
      altitudeMode:(VMEPlaceAltitudeMode)altitudeMode
       displayMode:(VMEPlaceDisplayMode)displayMode
       orientation:(VMEPlaceOrientation*)orientation
    visibilityRamp:(VMEPlaceVisibilityRamp*)visibilityRamp;

/**
 * Adds a dynamic place to the map.
 *
 * @param placeID The ID of the place.  If the ID corresponds to an existing dynamic
 * place, then it will be replaced.  If the ID corresponds with a static place ID,
 * then this call will fail.
 * @param imageURL A URL that references an image that will be used to represent
 * the place within the map. Secure http (i.e. https) is not currently supported.
 * @param data A data object for populating the place information. See code snippet
 * below for the expected format.
 * @param position The place's position within the map
 *
 * @return YES if the place was successfully added to the map, otherwise NO.
 *
 * @note When using this method, the other properties of the object are initialized
 * to appropriate values:
 * - size is set to 20.0
 * - anchorMode is set to VMEPlaceAnchorModeBottomCenter
 * - altitudeMode is set to VMEPlaceAltitudeModeAbsolute
 * - displayMode is set to VMEPlaceDisplayModeOverlay
 * - orientation is set using @c [VMEPlaceOrientation placeOrientationFacing]
 * - visibilityRamp is set using @c [[VMEPlaceVisibilityRamp alloc] init]]
 *
 * @see VMEPlaceInterface::addPlaceID:imageURL:data:position:size:anchorMode:altitudeMode:displayMode:orientation:visibilityRamp:
 *
 * @note Applies to:
 * - dynamic places
 *
 @code

 VMEPosition* lPos = [[VMEPosition alloc] initWithLatitude:45.74131
                                                 longitude:4.88216
                                                  altitude:0.0
                                                buildingID:nil
                                                   floorID:nil];

 NSDictionary *placeData = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Cat tracker", @"name",
                            @"https://en.wikipedia.org/wiki/Cat", @"description",
                            @"http://www.clipartbest.com/cliparts/aTe/K4e/aTeK4en8c.png", @"icon",
                            @[@"2", @"3", @"99"], @"categories",
                            nil];

 NSURL* lIconUrl = [NSURL URLWithString:@"http://www.clipartbest.com/cliparts/aTe/K4e/aTeK4en8c.png"];

 [self.mapView addPlaceID:@"cat_tracker_id"
                 imageURL:lIconUrl
                     data:placeData
                 position:lPos];
  ];
 @endcode
 *
 * @version 1.1
 */
-(BOOL) addPlaceID:(NSString*)placeID
          imageURL:(NSURL*)imageURL
              data:(NSDictionary*)data
          position:(VMEPosition*)position;


/**
 * Update the place's position.
 *
 * @param placeID The place ID
 * @param position The place's new position
 * @param animated Determines whether the change should be animated.
 *
 * @return YES if the place's position was updated, otherwise NO.
 *
 * @note Applies to:
 * - dynamic places
 *
 * @version 1.1
 */
-(BOOL) setPlaceID:(NSString*)placeID position:(VMEPosition*)position animated:(BOOL)animated;

/**
 * Update the place's size.
 *
 * @param placeID The place ID
 * @param size The place's new size
 * @param animated Determines whether the change should be animated.
 *
 * @return YES if the place's size was updated, otherwise NO.
 *
 * @note Applies to:
 * - dynamic places
 *
 * @version 1.1
 */
-(BOOL) setPlaceID:(NSString*)placeID size:(VMEPlaceSize*)size animated:(BOOL)animated;


/**
 * Remove the place from the map.
 *
 * @param placeID The ID of the place to be removed.
 *
 * @return YES if the place was removed, otherwise NO.
 *
 * @note Applies to:
 * - dynamic places
 *
 * @version 1.1
 */
-(BOOL) removePlaceID:(NSString*)placeID;

@end
