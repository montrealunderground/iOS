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
#import <CoreLocation/CoreLocation.h>
#import <VisioMoveEssential/VisioMoveEssential.h>


#pragma mark - VMELocationInterface
/**
 * A protocol for updating the current physical location within the map
 *
 * @version 1.0
 */
@protocol VMELocationInterface <NSObject>

/**
 * Updates the uses current physical location within the map.
 *
 * @param update The location update to apply.  If nil is passed, then the current
 * location will be removed from the map.
 *
 *
 * @version 1.0
 * @version 1.2 Change update parameter from CLLocation to VMELocation.
 *
 * <b>Example</b>
 @code
 #pragma mark - CLLocationManagerDelegate
 - (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
 {
     CLLocation* lCLLocation = locations.lastObject;
     VMELocation* lVMELocation = [self.mapView createLocationFromLocation:lCLLocation];
     [self.mapView updateLocation:lVMELocation];
 }
 @endcode
 */
-(void) updateLocation:(VMELocation*)update;


/**
 * Takes a native location object and converts it to a VisioMove Essential object
 * Uses the geo-fences within the map bundle to determine if the location falls
 * within a building and if so, what floor.
 *
 * @note The CLLocation's floor property is currently ignored.  Please use the
 * altitude property to determine the physical floor.
 *
 * @param location A location object.  The 'altitude' attribute will be used to
 * determine the correct floor.
 *
 * @return A VMELocation indicating the location within the venue, or nil if the
 * location is invalid or does exist not within the venue.
 *
 * @version 1.2
 */
-(VMELocation*) createLocationFromLocation:(CLLocation*) location;

/**
 * Takes a native location object and converts it to a VisioMove Essential object
 * Uses the geo-fences within the map bundle to determine if the location falls
 * within a builing and if so, what floor.
 *
 * @param location A location object.  The 'altitude' attribute will be used to
 * determine the correct floor.
 *
 * @return A VMEPosition indicating the location within the venue, or nil if the
 * location is invalid or does not exist within the venue.
 *
 * @version 1.2
 */
-(VMEPosition*) createPositionFromLocation:(CLLocation*) location;

@end

