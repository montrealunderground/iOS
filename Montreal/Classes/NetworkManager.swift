//
//  NetworkManager.swift
//  ReciFoto
//
//  Created by Colin Taylor on 2/26/17.
//  Copyright © 2017 Colin Taylor. All rights reserved.
//

import Foundation
import UIKit

open class NetworkManger : NSObject  {
    static let sharedInstance : NetworkManger = {
        let instance = NetworkManger()
        return instance
    }()
    
    public override init() {
        super.init()
    }
    
}

// MARK: - API

extension NetworkManger {
    
    func authenticateUser(name:String!, userid:String!, accessToken:String!, photourl:String!, isfb:Bool!,completionHandler: @escaping (NSDictionary, String) -> Void) {
        
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.authenticateUser), method: .post, parameters: ["name":name, "userid":userid, "token":accessToken
            , "pictureUrl":photourl, "isfb":isfb])
        
        apiRequest.responseString(completionHandler: { response in
            print(response)
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from authenticateUser")
            }
            
        })
    }
    
    func awardVideo(userid:String!, completionHandler: @escaping (NSDictionary, String) -> Void) {
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.awardVideo), method: .post, parameters: ["userid":userid])
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from awardVideo")
            }
            
        })
    }
    
    func sharedApplication(userid:String!, completionHandler: @escaping (NSDictionary, String) -> Void) {
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.sharedApplication), method: .post, parameters: ["userid":userid])
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from sharedApplication")
            }
            
        })
    }
    
    func purchaseItem(userid:String!, ucitemid:String!, completionHandler: @escaping (NSDictionary, String) -> Void) {
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.purchaseItem), method: .post, parameters: ["userid":userid, "ucitemid":ucitemid])
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from purchaseItem")
            }
            
        })
    }
    
    func sendDeviceTokenRegisterRequest(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.sendDeviceTokenRegisterRequest), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from sendDeviceTokenRegisterRequest")
            }
            
        })
    }
    func getBannerImagesAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getBannerImages), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getBannerImagesAPI")
            }
            
        })
    }
    func getInterstitialAdsAPI(completionHandler: @escaping (NSDictionary, String) -> Void){
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getInterstitialAds), method: .post, parameters: nil)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getInterstitialAdsAPI")
            }
            
        })
    }
    func getShoppingMallsAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getShoppingMalls), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getShoppingMallsAPI")
            }
            
        })
    }
    func getShoppingMallByIdAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getShoppingMallById), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getShoppingMallByIdAPI")
            }
            
        })
    }
    func getStoresAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getStores), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getStoresAPI")
            }
            
        })
    }
    func getUCItemsAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getUCItems), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getUCItemsAPI")
            }
            
        })
    }
    func getEventsAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getEvents), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getEventsAPI")
            }
            
        })
    }
    func getPromotionsAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getPromotions), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getPromotionsAPI")
            }
            
        })
    }
    func getMetroListForStoreAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getMetroListForStore), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getMetroListForStoreAPI")
            }
            
        })
    }
    func getMetroListForRestaurantAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getMetroListForRestaurant), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getMetroListForRestaurantAPI")
            }
            
        })
    }
    func getJobsAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getJobs), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getJobsAPI")
            }
            
        })
    }
    func getParkingsAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getParkings), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getParkingsAPI")
            }
            
        })
    }
    func getFreeWifisAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getFreeWifis), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getFreeWifisAPI")
            }
            
        })
    }
    func getDailyLockersAPI(parameters: [String : String],completionHandler: @escaping (NSDictionary, String) -> Void){
        print(parameters)
        let apiRequest = request(String(format:"%@%@",Constants.API_URL_DEVELOPMENT,Constants.getDailyLockers), method: .post, parameters: parameters)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getDailyLockersAPI")
            }
            
        })
    }
    func getSearchAPI(query:String, pagenum:Int, completionHandler: @escaping (NSDictionary, String) -> Void){
        var requesturl:String = "https://api.swiftype.com/api/v1/engines/montreal-souterrain/document_types/stores/search.json?auth_token=_gv7RtZF4NzJxvtn11by&q="+query
        if (pagenum > 0) {
            requesturl = requesturl + "&page="+String(format:"%d", pagenum)
        }
        //let apiRequest = request("https://api.swiftype.com/api/v1/engines/montreal-souterrain/document_types/stores/search.json?auth_token=_gv7RtZF4NzJxvtn11by&q="+query+"&page="+pagenum, method: .get, parameters: nil)
        let apiRequest = request(requesturl, method: .get, parameters: nil)
        
        apiRequest.responseString(completionHandler: { response in
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                completionHandler(jsonResponse as NSDictionary, "")
            }catch{
                print("Error Parsing JSON from getSearchAPI")
            }
        })
    }
}
