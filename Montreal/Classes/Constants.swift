//
//  Constants.swift
//  ReciFoto
//
//  Created by Colin Taylor on 1/26/17.
//  Copyright © 2017 Colin Taylor. All rights reserved.
//
import UIKit
let notificationDidUndergroundClicked = "notificationDidUndergroundClicked"
let notificationDidARListClicked = "notificationDidARListClicked"
let notificationDidMetroPlanClicked = "notificationDidMetroPlanClicked"
let notificationDidShoppingMallsClicked = "notificationDidShoppingMallsClicked"
let notificationDidRestaurantsClicked = "notificationDidRestaurantsClicked"
let notificationDidBoutiquesClicked = "notificationDidBoutiquesClicked"
let notificationDidBeautyHealthClicked = "notificationDidBeautyHealthClicked"
let notificationDidAttractionsClicked = "notificationDidAttractionsClicked"
let notificationDidServicesJobsClicked = "notificationDidServicesJobsClicked"
let notificationDidHotelsClicked = "notificationDidHotelsClicked"
let notificationDidEventsClicked = "notificationDidEventsClicked"
let notificationDidPromotionsClicked = "notificationDidPromotionsClicked"
let notificationDidUnderCoinsClicked = "notificationDidUnderCoinsClicked"
struct Constants{
    //API Level
//    static let API_URL_DEVELOPMENT = "http://192.168.1.136/montreal/api/"
    static var profileName:String = ""
    static var profileUserId:String = ""
    static var profileBalance:String = ""
    static var profileImgUrl:String = ""
    
    static let BANNER_ADS_UNIT_ID = "ca-app-pub-5420876778958572/3023558642"
    static let INTERSTITIAL_ADS_UNIT_ID = "ca-app-pub-5420876778958572/8930491446"
    static let AWARDED_VIDEO_ADS_UNIT_ID = "ca-app-pub-5420876778958572/2690733138"
    
//    static let API_URL_DEVELOPMENT = NSLocalizedString("http://vortexapp.ca/montrealadmin/api/", comment: "myurl")
    static let API_URL_DEVELOPMENT = NSLocalizedString("http://montrealsouterrain.com/api/", comment: "myurl")
    static let getBannerImages = "getBannerImages"
    static let getInterstitialAds = "getInterstitialAdsState"
    static let getShoppingMalls = "getShoppingMalls"
    static let getShoppingMallById = "getShoppingMallById"
    static let getRestaurants = "getRestaurants"
    static let getStores = "getStores"
    static let getEvents = "getEvents"
    static let getPromotions = "getPromotions"
    static let getMetroListForStore = "getMetroListForStore"
    static let getMetroListForRestaurant = "getMetroListForRestaurant"
    static let getJobs = "getJobs"
    static let getParkings = "getParkings"
    static let getFreeWifis = "getFreeWifis"
    static let getDailyLockers = "getDailyLockers"
    static let getUCItems = "getUCItems"
    static let sendDeviceTokenRegisterRequest = "registerDeviceToken"
    static let authenticateUser = "registerUser"
    static let awardVideo = "awardVideo"
    static let sharedApplication = "sharedApplication"
    static let purchaseItem = "purchaseItem"
    
    //static let titles = ["Home", "Underground Map", "Metro Plan", "Events", "Promotions", "Facebook page", "Feedback", "Contact us"]
    static let titles = ["Home", "Image Map", "3D Map", "Metro Plan", "My Profile", "UC Store", "Contact us"]
    
    static let menu_titles = ["Underground Map",
                              "AR View",
                              "Metro Plan",
                                 "Shopping Malls",
                                 "Restaurants",
                                 "Boutiques",
                                 "Beauty & Health",
                                 "Attractions",
                                 "Services & Jobs",
                                 "Hotels",
                                 "Events",
                                 "Under Coins"]
//                                 "Promotions"]
    
    //static let proximiioToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImlzcyI6IjZhODFkMGM5LTA2YTYtNDc3OC04YTBkLTY5ZjBiODNlMDk2MiIsInR5cGUiOiJhcHBsaWNhdGlvbiIsImFwcGxpY2F0aW9uX2lkIjoiMDVhMDIzODctM2VjMC00MmIwLTg2ZmEtMWQzMjY5N2M5YzI3In0.mspU6RBMeWCo67ccBDY3n2JhPU4X5zJ8GlaJyngSDE8"
    
    //static let proximiioToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImlzcyI6IjczNzQ4MzdjOTE3MzQzN2VjM2ZmYjRhZWMyNmUxOGI4IiwidHlwZSI6InVzZXIiLCJ1c2VyIjoiUHJveGltaWlvIERldnMiLCJ1c2VyX2lkIjoiMTU1YjEzNmMtNDM2OC00ODdiLTg0MzQtOGRlZGJhNzc1YzVmIiwidGVuYW50X2lkIjoiMmZkOTFmMzUtNTI0My00MjI2LWIxODItZTEzOGQzNDgyNWY1In0.xBV7cKJ82VnExTQMy9J2aOitS59TpbHZHXr-AhwhbLQ"
    static let proximiioEmail = "elias@montrealsouterrain.ca"
    static let proximiioPassword = "password"
}
