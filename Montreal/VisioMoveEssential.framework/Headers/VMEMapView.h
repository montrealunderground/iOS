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

#import <UIKit/UIKit.h>

#import <VisioMoveEssential/VMEComputeRouteInterface.h>
#import <VisioMoveEssential/VMELocationInterface.h>
#import <VisioMoveEssential/VMEMapInterface.h>
#import <VisioMoveEssential/VMEMapListener.h>
#import <VisioMoveEssential/VMEOverlayViewInterface.h>
#import <VisioMoveEssential/VMEPlaceInterface.h>
#import <VisioMoveEssential/VMESearchViewInterface.h>

/**
 * This is the main class of VisioMove Essential for iOS and is the entry point
 * for all methods related to the map.
 *
 * The map view can be created either with the initWithFrame: method or within 
 * a nib.
 *
 * VMEMapView can only be read and modified from the main thread, similar
 * to all UIKit objects. Calling these methods from another thread will result in
 * an exception or undefined behavior.
 *
 * @version 1.0
 */
IB_DESIGNABLE
@interface VMEMapView : UIView
< VMEComputeRouteInterface
, VMELocationInterface
, VMEMapInterface
, VMEOverlayViewInterface
, VMEPlaceInterface
, VMESearchViewInterface >

#pragma mark - Static methods

/**
 * Retrieve the current version of VisioMove Essential (iOS).
 *
 * @version 1.0
 */
+(NSString*) getVersion;


/**
 * Retrieves the minimum version string major.minor.patch of the data that this 
 * SDK can handle.  
 *
 * In other words, the map bundle must have been generated with
 * at least this SDK version, otherwise it will not be loaded.  You can find the 
 * sdk_version that a map bundle was generated with within its descriptor.json file.
 *
 * @version 1.0
 */
+(NSString*) getMinDataSDKVersion;

#pragma mark - Methods

/**
 * Use this constructor to create the VMEMapView programatically
 *
 * @version 1.0
 */
-(instancetype) initWithFrame:(CGRect)frame;

/**
 * Loads the map using the current map configuration.  If the map is already loaded,
 * this will reload the map.
 * 
 * This method must be called at least once in order for the map to be loaded.
 *
 * @version 1.0
 */
-(void) loadMap;


#pragma mark - IBOutlets
/**
 * The directory path of the embedded map bundle, relative to the main bundle.
 *
 * @version 1.0
 */
@property (nonatomic) IBInspectable NSString *mapPath;
/**
 * The embedded map's secret code.  
 *
 * @note The secret code is used to salt the map's license.  Before authorizing
 * the loading of the map, the secret code is validated with the map's license.
 *
 * @version 1.0
 */
@property (nonatomic) IBInspectable NSString *mapSecretCode;
/**
 * The online map's hash. 
 * 
 * @note The hash is used for retrieving the map from a map server.
 *
 * @version 1.0
 */
@property (nonatomic) IBInspectable NSString *mapHash;
/**
 * The map server url.  
 *
 * @note If left blank, the map server will defaul to @"https://mapserver.visioglobe.com"
 *
 * @version 1.0
 */
@property (nonatomic) IBInspectable NSString *mapServerURL;

/**
 * The map listener delegate to receive map related notifications.
 *
 * @version 1.0
 */
@property (nonatomic, weak) IBOutlet id <VMEMapListener> mapListener;

@end
