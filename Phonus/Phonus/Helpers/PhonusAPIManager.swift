//
//  PhonusAPIManager.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 4/16/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation


class PhonusAPIManager: NSObject {
    
    // Single instance for API calls
    static let sharedInstance = PhonusAPIManager()
    
    // Get ExamDetails by ID and serialize JSON resposne into ExamDetails Object
    func getExamDetails(examId: Int, completionHandler: (Result<ExamDetails, NSError>) -> Void) {
        Alamofire.request(ExamRouter.GetExamById(examId))
        .responseObject { (response: Response<ExamDetails, NSError>) in
            completionHandler(response.result)
        }
    }
    
    // Post Exam
    func postExam(name: String, maxFrequency: Double, minFrequency: Double, ipAddress: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, completionHandler: (Result<AnyObject, NSError>) -> Void) {
        
        let parameters: [String: AnyObject] = [
            "NombreAplicante" : "\"\(name)\"",
            "FrecuenciaMaxima" : minFrequency,
            "FrecuenciaMinima" : maxFrequency,
            "DireccionIp" : "\"\(ipAddress)\"",
            "Latitud" : latitude,
            "Longitud" : longitude
        ]
        
        print(parameters)
        
        Alamofire.request(ExamRouter.RegisterExam(parameters))
        .response { (request, response, data, error) in
            guard error == nil else {
                print(error)
                completionHandler(.Failure(error!))
                return
            }
            self.clearCache()
            completionHandler(.Success(true))            
        }
    }
    
    func clearCache() {
        let cache = NSURLCache.sharedURLCache()
        cache.removeAllCachedResponses()
    }
}

