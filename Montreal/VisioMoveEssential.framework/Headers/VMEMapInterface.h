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
#import <VisioMoveEssential/VMEViewMode.h>
#import "VMEMacros.h"


#pragma mark - VMECameraHeading
/**
 * @brief VMECameraHeading represents a heading element that may be associated
 * with a VMECameraUpdate object.
 *
 * It encapsulates some logic for controlling the camera's heading. It should only 
 * be constructed using the factory helper methods below.
 *
 * @version 1.2
 */
@interface  VMECameraHeading : NSObject

/**
 * Keep the camera's current heading.
 *
 * @version 1.2
 */
+(instancetype)cameraHeadingCurrent;

/**
 * Use the place's defined heading.
 *
 * @param placeID The id of the place who's heading should be used.
 *
 * @version 1.2
 */
+(instancetype)cameraHeadingForPlaceID:(NSString*) placeID;

/**
 * Provide a specific heading
 *
 * @param heading The heading value to be applied to the camera (0 for north, 
 * increasing value start to east).
 *
 * @version 1.2
 */
+(instancetype)cameraHeadingWithHeading:(float)heading;

@end

#pragma mark - VMECameraUpdate
/**
 * @brief Represents a camera update that can be applied to the VMEMapView.
 *
 * Use the provided constructors to instantiate different types of camera updates.
 * A camera update will update the camera's viewpoint and if necessary will also
 * update the scene so that the viewpoint is focused on the correct building/floor.
 *
 * @version 1.0
 */
@interface VMECameraUpdate : NSObject

/**
 * Update the view mode and the focused building and floor.
 *
 * @param viewMode The view mode to change to.  Pass VMEViewModeUnknown to leave the
 * current view mode.
 * @param buildingID The building id to apply focus.  If nil and pFloor is nil, then
 * the focused building won't change.  If nil and pFloor is not nil, then focused
 * building will be determined automatically to correspond with the floor.
 * @param floorID The floor id to apply focus.  If nil and pBuilding is not nil, then
 * the focused floor will either remain unchanged (if the building already has a focused 
 * floor) or the default floor will be applied.
 *
 * @version 1.0
 * @deprecated Deprecated in 1.2.  Replaced with VMECameraUpdate::cameraUpdateForViewMode:heading:,
 * VMECameraUpdate::cameraUpdateForViewMode:heading:buildingID: and VMECameraUpdate::cameraUpdateForViewMode:heading:floorID:
 */
-(instancetype) initWithViewMode:(VMEViewMode)viewMode
                      buildingID:(NSString*)buildingID
                         floorID:(NSString*)floorID VME_DEPRECATED_MSG("Please use either: cameraUpdateForViewMode:heading:, cameraUpdateForViewMode:heading:buildingID: or cameraUpdateForViewMode:heading:floorID:");


/**
 * Adjusts the camera to view the given place id.
 *
 * This method will call VMECameraUpdate::initWithPlaceID:marginTop:marginBottom:marginLeft:marginRight:heading: 
 * passing 0px margins and requesting the camera heading remains unchanged
 *
 * @param placeID The id of the place to focus on.
 *
 * @version 1.0
 * @deprecated Deprecated in 1.2.  Replaced with VMECameraUpdate::cameraUpdateForPlaceID:
 */
-(instancetype) initWithPlaceID:(NSString*)placeID VME_DEPRECATED_MSG("Please use cameraUpdateForPlaceID:");


/**
 * Set's the view mode to either VMEViewModeFloor or VMEViewModeGlobal (depending
 * on where the positions are located) and updates the camera's viewpoint so that it englobes
 * all those positions.
 *
 * @param positions An array of VMEPosition objects.  All floorID values must be
 * coherent within the VMEPosition objects.
 * @param marginTop The top padding area's height to use (in pixels)
 * @param marginBottom The bottom padding area's height to use (in pixels)
 * @param marginLeft The left padding area's width to use (in pixels)
 * @param marginRight The right padding area's width to use (in pixels)
 * @param heading The heading (read as a double) to apply to the camera.  Pass
 * nil to keep existing heading.
 *
 * @version 1.1
 * @deprecated Deprecated in 1.2.  Replaced with VMECameraUpdate::cameraUpdateForPositions:heading:paddingTop:paddingBottom:paddingLeft:paddingRight:
 */
-(instancetype) initWithPositions:(NSArray*)positions
                        marginTop:(NSUInteger)marginTop
                     marginBottom:(NSUInteger)marginBottom
                       marginLeft:(NSUInteger)marginLeft
                      marginRight:(NSUInteger)marginRight
                          heading:(NSNumber*)heading VME_DEPRECATED_MSG("Please use cameraUpdateForPositions:heading:paddingTop:paddingBottom:paddingLeft:paddingRight");

/**
 * Resets the camera and scene to their initial state.
 *
 * @see See VMECameraUpdate::cameraUpdateResetWithHeading: for more info.
 *
 * By default the heading will be the camera's current heading.
 *
 * @version 1.2
 */
+(instancetype) cameraUpdateReset;

/**
 * Resets the camera and scene to their initial state.
 *
 * If there is a default building, then it will be given focus, otherwise no
 * building will be given will be given focus.
 *
 * @param heading The heading to be applied to the camera.
 *
 * @version 1.2
 */
+(instancetype) cameraUpdateResetWithHeading:(VMECameraHeading*)heading;

/**
 * Update the view mode.  The focused building and floor will not be changed.
 *
 * @param viewMode The view mode to change to.  Pass VMEViewModeUnknown to leave the
 * current view mode.
 * @param heading The heading to be applied to the camera.
 *
 * @version 1.2
 */
+(instancetype) cameraUpdateForViewMode:(VMEViewMode)viewMode
                                heading:(VMECameraHeading*)heading;

/**
 * Update the view mode and the focused building and floor.
 *
 * @param viewMode The view mode to change to.  Pass VMEViewModeUnknown to leave the
 * current view mode.
 * @param heading The heading to be applied to the camera.
 * @param buildingID The building id to apply focus.  The focused floor will be
 * determined by the first of the following:
 *  - the current floor if it is associated with the building
 *  - the building's default floor, if it has one.
 *  - otherwise the ground floor will be given focus.
 *
 * @version 1.2
 */
+(instancetype) cameraUpdateForViewMode:(VMEViewMode)viewMode
                                heading:(VMECameraHeading*)heading
                             buildingID:(NSString*)buildingID;


/**
 * Update the view mode and the focused building and floor.
 *
 * @param viewMode The view mode to change to.  Pass VMEViewModeUnknown to leave the
 * current view mode.
 * @param heading The heading to be applied to the camera.
 * @param floorID The floor id to apply focus.  The building id associated with
 * the floorID will be deduced.
 *
 * @version 1.2
 */
+(instancetype) cameraUpdateForViewMode:(VMEViewMode)viewMode
                                heading:(VMECameraHeading*)heading
                                floorID:(NSString*)floorID;


/**
 * Adjusts the camera to focus a the place.
 *
 * @see VMECameraUpdate::cameraUpdateForPlaceID:heading:paddingTop:paddingBottom:paddingLeft:paddingRight for more info
 *
 * By default, there will be no padding margins and the camera's heading will remain
 * unchanged
 *
 * @param placeID The id of the place to focus on.
 *
 * @version 1.2
 */
+(instancetype) cameraUpdateForPlaceID:(NSString*)placeID;

/**
 * Adjusts the camera to focus a the place.
 *
 * Set's the view mode to either VMEViewModeFloor or VMEViewModeGlobal (depending on where
 * the place is located) and updates the camera's viewpoint so that it's suitable for the place.
 *
 * The camera's altitude will be adjusted so that it's viewpoint encompasses all the points of
 * the place's bounding box and the place fills the available view.  If the place's bounding box
 * contains a single point, then the camera's altitude won't change.
 *
 * @param placeID The id of the place to focus on.
 * @param heading The heading to be applied to the camera.
 * @param top The top padding in pixels
 * @param bottom The bottom padding in pixels
 * @param left The left padding in pixels
 * @param right The right padding in pixels
 *
 * @version 1.2
 */
+(instancetype) cameraUpdateForPlaceID:(NSString*)placeID
                               heading:(VMECameraHeading*)heading
                            paddingTop:(CGFloat)top
                         paddingBottom:(CGFloat)bottom
                           paddingLeft:(CGFloat)left
                          paddingRight:(CGFloat)right;

/**
 * Set's the view mode to either VMEViewModeFloor or VMEViewModeGlobal (depending
 * on where the positions are located) and updates the camera's viewpoint so that it
 * englobes all those positions.
 *
 * @param positions An array of VMEPosition objects.  All floorID values must be
 * coherent within the VMEPosition objects.
 * @param heading The heading to be applied to the camera.
 * @param top The top padding in pixels
 * @param bottom The bottom padding in pixels
 * @param left The left padding in pixels
 * @param right The right padding in pixels
 *
 * @version 1.2
 */
+(instancetype) cameraUpdateForPositions:(NSArray*)positions
                                 heading:(VMECameraHeading*)heading
                              paddingTop:(CGFloat)top
                           paddingBottom:(CGFloat)bottom
                             paddingLeft:(CGFloat)left
                            paddingRight:(CGFloat)right;

@end

#pragma mark - VMESceneUpdate

/**
 * @brief Represents a scene update that can be applied to the VMEMapView.
 *
 * Use the provided constructors to instantiate different types of scene updates.
 * A scene update can be used to change the following:
 *  - view mode
 *  - focused building 
 *  - focused floor
 * 
 * Updating the scene will not update the camera.
 *
 * @note Due to the "zoom storyboard", if the camera is focused on a different
 * building to that in the requested scene update, then the next time the user 
 * interacts with the map, the focused building will change automatically.
 *
 * @version 1.2
 */
@interface VMESceneUpdate : NSObject


/**
 * Update the scene's view mode.  The current focused building and floor will 
 * remain unchanged.
 *
 * @param viewMode The view mode to change to.  Pass VMEViewModeUnknown to leave
 * the current view mode.
 *
 * @version 1.2
 */
+(instancetype) sceneUpdateForViewMode:(VMEViewMode)viewMode;


/**
 * Update the scene.
 *
 * @param viewMode The view mode to change to.  Pass VMEViewModeUnknown to leave
 * the current view mode.
 * @param buildingID The building id to apply focus.  The focused floor will be
 * determined by the first of the following:
 *  - the current floor if it is associated with the building
 *  - the building's default floor, if it has one.
 *  - otherwise the ground floor will be given focus.
 *
 * @version 1.2
 */
+(instancetype) sceneUpdateForViewMode:(VMEViewMode)viewMode
                            buildingID:(NSString*)buildingID;

/**
 * Update the scene
 *
 * @param viewMode The view mode to change to.  Pass VMEViewModeUnknown to leave
 * the current view mode.
 * @param floorID The floor id to apply focus.  The building id associated with
 * the floorID will be deduced.
 *
 * @version 1.2
 */
+(instancetype) sceneUpdateForViewMode:(VMEViewMode)viewMode
                               floorID:(NSString*)floorID;
@end

#pragma mark - VMEMapInterface
/**
 * @brief A protocol for controlling the camera and the scene.
 *
 * @version 1.0
 */
@protocol VMEMapInterface <NSObject>

/**
 * Apply an update to the camera.
 *
 * @param update The update to apply.
 * @param animated YES if the update should be animated, NO if it should be immediate.
 *
 * @version 1.0
 * @deprecated Deprecated in 1.2.  Replaced with VMEMapInterface::updateCamera:
 * and VMEMapInterface::animateCamera:
 * 
 * <b>Example</b>
 @code
 VMECameraUpdate* lUpdate = [[VMECameraUpdate alloc] initWithViewMode:VMEViewModeFloor
                                                           buildingID:nil
                                                              floorID:@"B2-UL00"];
 [self.mapView moveCamera:lUpdate animated:YES];
 @endcode
 */
-(void) moveCamera:(VMECameraUpdate*)update animated:(BOOL)animated VME_DEPRECATED_MSG("Please use either animateCamera: or updateCamera:");

/**
 * Repositions the camera according to the instructions defined in the update. 
 * The update is instantaneous.
 *
 * @see VMECameraUpdate for the available update constructors.
 *
 * @param update The update to apply.
 *
 * @version 1.2
 *
 * <b>Example</b>
 @code
 VMECameraUpdate* lUpdate = [VMECameraUpdate cameraUpdateForViewMode:VMEViewModeFloor
                                                             heading:[VMECameraHeading cameraHeadingCurrent]
                                                             floorID:@"B2-UL00"];
 [self.mapView updateCamera:lUpdate];
 @endcode
 */
-(void) updateCamera:(VMECameraUpdate*)update;

/**
 * Animates the movement of the camera from the current position to the position 
 * defined in the update.
 *
 * @see VMECameraUpdate for the available update constructors.
 *
 * @param update The update to apply.
 *
 * @version 1.2
 *
 * <b>Example</b>
 @code
 VMECameraUpdate* lUpdate = [VMECameraUpdate cameraUpdateForViewMode:VMEViewModeFloor
                                                             heading:[VMECameraHeading cameraHeadingForPlaceID:@"B2"]]
                                                             floorID:@"B2-UL00"];
 [self.mapView animateCamera:lUpdate];
 @endcode
 */
-(void) animateCamera:(VMECameraUpdate*)update;

/**
 * Updates the change of scene from the current scene to the scene
 * defined in the update.  The update is instantaneous.
 *
 * @see VMESceneUpdate for the available update constructors.
 *
 * @param update The update to apply.
 *
 * @version 1.2
 *
 * <b>Example</b>
 @code
 VMESceneUpdate* lUpdate = [VMESceneUpdate sceneUpdateForViewMode:VMEViewModeFloor
                                                          floorID:@"B2-UL00"];
 [self.mapView updateScene:lUpdate];
 @endcode
 */
-(void) updateScene:(VMESceneUpdate*)update;

/**
 * Animates the change of scene from the current scene to the scene
 * defined in the update.
 *
 * @see VMESceneUpdate for the available update constructors.
 *
 * @param update The update to apply.
 *
 * @version 1.2
 *
 * <b>Example</b>
 @code
 VMESceneUpdate* lUpdate = [VMESceneUpdate sceneUpdateForViewMode:VMEViewModeFloor
                                                          floorID:@"B2-UL00"];
 [self.mapView animateScene:lUpdate];
 @endcode
 */
-(void) animateScene:(VMESceneUpdate*)update;

@end

