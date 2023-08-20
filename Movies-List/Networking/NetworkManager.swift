//
//  NetworkManager.swift
//  Movies-List
//
//  Created by Mahad on 8/20/23.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import UIKit
import SwiftyJSON

class NetworkManager: SessionManager {
    
    
    // MARK: - Public methods
    func getRequest(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, completion: @escaping (JSON?) -> Void ) {
        
        Alamofire.request(url, method: .get , parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            self.handleResponse(response: response, completion: completion)
        }
    }
        
    func handleResponse(response: DataResponse<Any>, completion: @escaping (JSON?) -> Void) {
        switch response.result {
        case .success:
            self.showRequestDetailForSuccess(responseObject: response)
            completion(JSON(response.result.value!))
            break

        case .failure:
            self.showRequestDetailForFailure(responseObject: response)
            if let responseValue = response.result.value {
                completion(JSON(responseValue))
            }
            break
        }
    }


    func showRequestDetailForSuccess(responseObject response : DataResponse<Any>) {

        print("\n\n\n ✅ ✅ ✅ ✅ ✅  ------- Success Response Start -------  ✅ ✅ ✅ ✅ ✅ \n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)

        if let bodyData : Data = response.request?.httpBody
        {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + bodyString!)

        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }

        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + responseString!)

        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }

        print("\n\n\n ✅ ✅ ✅  ------- Success Response End -------  ✅ ✅ ✅ \n\n\n")

    }


    func showRequestDetailForFailure(responseObject response : DataResponse<Any>) {

        print("\n\n\n ❌ ❌ ❌ ❌ ❌ ------- Failure Response Start ------- ❌ ❌ ❌ ❌ ❌ \n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)

        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + bodyString!)

        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }

        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + responseString!)

        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }

        print("\n\n\n ❌ ❌ ❌ ------- Failure Response End ------- ❌ ❌ ❌ \n")

    }
}

