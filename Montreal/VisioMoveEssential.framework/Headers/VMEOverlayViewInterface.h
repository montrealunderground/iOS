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
#import "VMEPosition.h"

/**
 * A protocol for adding an overlay view above the map.
 *
 * An overlay view displays content (usually text, buttons or images) in a popup
 * view above the map, at a given location.
 *
 * The content of the info view can be tailored completely.
 *
 * An info view may be anchored to either a latitude/longitude or a place. The
 * info view will be anchored by it's bottom center point.
 *
 * An info view will move automatically with the map when the map is panned.  The
 * info view will be automatically hidden and displayed based on whether it's
 * position is visible within the scene.
 *
 * You may need to move the camera to be able to see the info view.  For example,
 * the info view won't be visible if the floor that it's anchored to isn't visible.
 *
 * @version 1.1
 */
@protocol VMEOverlayViewInterface <NSObject>
/**
 * Adds a native overlay view above the map.
 *
 * @param overlayViewID The id to given to overlay view.  Must be unique.
 * @param view The native view to added to the map.
 * @param position The position to which the overlay view will be anchored.  The
 * bottom center of the view will be tied to the position.
 *
 @code
 View* lView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
 VMEPosition* lPos = [[VMEPosition alloc] initWithLatitude:45.740876918853147
                                                 longitude:4.8805385544669795
                                                  altitude:3
                                                buildingID:@"B3"
                                                   floorID:@"B3-UL01"];
 [self.mapView addOverlayViewID:@"info_overlay_id" view:lView position:lPos];
 @endcode
 * @version 1.1
 */
-(BOOL) addOverlayViewID:(NSString*)overlayViewID view:(UIView*)view position:(VMEPosition*)position;

/**
 * Adds a native overlay view above the map.
 *
 * @param overlayViewID The id to given to overlay view.  Must be unique.
 * @param view The native view to added to the map.
 * @param placeID The view will be anchored to the center point of the place
 * with this ID.  The bottom center of the view will be tied to the place.
 *
 @code
 View* lView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
 [self.mapView addOverlayViewID:@"info_overlay_id" view:lView placeID:@"B2-LL01-ID0008"];
 @endcode
 * @version 1.1
 */
-(BOOL) addOverlayViewID:(NSString*)overlayViewID view:(UIView*)view placeID:(NSString*)placeID;

/**
 * Sets the position of the overlay view
 *
 * @param overlayViewID The id of the overlay view
 * @param position The position to update
 *
 * @version 1.1
 */
-(BOOL) setOverlayViewID:(NSString*)overlayViewID position:(VMEPosition*)position;

/**
 * Sets the place of the overlay view
 *
 * @param overlayViewID The id of the overlay view
 * @param placeID The place id to update
 *
 * @version 1.1
 */
-(BOOL) setOverlayViewID:(NSString*)overlayViewID placeID:(NSString*)placeID;

/**
 * Removes the overlay view from the map.
 *
 * @param overlayViewID The id of the overlay view to remove.
 *
 * @version 1.1
 */
-(BOOL) removeOverlayViewID:(NSString*)overlayViewID;
@end
