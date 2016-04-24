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
    
    // Function for debug purposes only
    func printExamResults() -> Void {
        Alamofire.request(ExamRouter.GetExamById(21))
            .responseString { response in
                if let receivedString = response.result.value {
                    print(receivedString)
                }
        }
    }
}
