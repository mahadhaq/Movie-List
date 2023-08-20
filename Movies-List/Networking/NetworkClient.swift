//
//  NetworkClient.swift
//  Movies-List
//
//  Created by Mahad on 8/20/23.
//


/*******************************************************************
 FUNCTION PARAMS
 
 'keyPath': By default this wrapper parse JSON from 'response["data"]'
 but if required object is at nested path within 'response["data"]' then keyPath can be use to parse that object. This param can be use to parse a nested object till level 5. You can pass multiple keypath string separated by comma. For example
 
 {
    "data" : {
            "user" : {
                      "favourites": {
                                "fruit" : {
 
                                 }
 
                      }
            }
     }
 }
 
 To parse fruit object in above JSON we can use keyPath as
 keyPath = "user,favourites,fruit"
 
 'parseCompleteResponseToRequiredObject': By default wrapper convert JSON to model object from 'response["data"]' path but if you want to convert whole JSON into your model then pass true in this param
 
********************************************************************/

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

enum Errors: String {
    case NETWORK_ERROR, SERIALIZATION_ERROR, OTHER
    
    var description: String {
        switch self {
        case .NETWORK_ERROR:
            return "No internet connection!"
        case .SERIALIZATION_ERROR:
            return "Cannot parse data. Data is not in the correct format"
        case .OTHER:
            return "Something went wrong"
        }
    }
}


class NetworkClient: NetworkManager {
    
    static let shared = NetworkClient()
    
    var isNetworkAvailable:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    private init() {
        super.init()
    }
    
    
    func getRequest<T: Decodable>(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, keyPath:String = "",checkInternetConnectivity:Bool = true, parseCompleteResponseToRequiredObject: Bool = false,  showLoader:Bool = true, completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        if checkInternetConnectivity {
            if !isNetworkAvailable {
                failure(Errors.NETWORK_ERROR.description)
                return
            }
        }
        
        getRequest(url, parameters: parameters, headers: headers, completion: { [weak self] response in
            if let json = response {
                self?.parseJSON(json: json, completion: completion, failure: failure)
            }
        })
    }
    
    func parseJSON<T: Decodable>(json:JSON, completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        do {
            let data = try json.rawData()
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            completion(parsedData)
            
        }
        
        catch DecodingError.keyNotFound(let key, let context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch DecodingError.valueNotFound(let type, let context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch DecodingError.typeMismatch(let type, let context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch DecodingError.dataCorrupted(let context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        }
    }
}
