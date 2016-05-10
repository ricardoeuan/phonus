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
    func postExam(exam: [String: AnyObject], completionHandler: (Result<AnyObject, NSError>) -> Void) {
        Alamofire.request(ExamRouter.RegisterExam(exam))
        .response { (request, response, data, error) in
            if let error = error {
                print(error)
                completionHandler(.Failure(error))
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

