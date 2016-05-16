//
//  ExamRouter.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 4/23/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import Foundation
import Alamofire

enum ExamRouter: URLRequestConvertible {
    
    static let baseURLString:String = "https://phonus.azurewebsites.net/api/examen/"
    
    // GET http://phonus.azurewebsites.net/api/examen/DetallesExamen?examenID=param
    case GetExamById(Int)
    // POST http://phonus.azurewebsites.net/api/examen/Registrar
    case RegisterExam([String: AnyObject])
    
    // Create URL request
    var URLRequest: NSMutableURLRequest {
        var method: Alamofire.Method {
            switch self {
            case .GetExamById:
                return .GET
            case .RegisterExam:
                return .POST
            }
        }
        
        let url:NSURL = {
            //build up and return the URL for each endpoint
            let relativePath:String?
            switch self {
            case .GetExamById(let examId):
                relativePath = "DetallesExamen?examenID=\(examId)"
            case .RegisterExam:
                relativePath = "Registrar"
            }
            
            var URL = NSURL(string: ExamRouter.baseURLString)!
            if let relativePath = relativePath {
                URL = URL.URLByAppendingPathComponent(relativePath)
            }
            return URL
        }()
        
        let params: ([String: AnyObject]?) = {
            switch self {
            case .GetExamById:
                return nil
            case .RegisterExam(let params):
                return params
            }
        }()
        
        let URLRequest = NSMutableURLRequest(URL: url)
        
        // Uncomment to set OAuth token once we have one
        /*
            if let token = PhonusAPIManager.sharedInstance.OAuthToken {
                URLRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
            }
        */
        
        let encoding = Alamofire.ParameterEncoding.JSON
        let (encodedRequest, _) = encoding.encode(URLRequest, parameters: params)
        
        encodedRequest.HTTPMethod = method.rawValue        
        
        return encodedRequest                
    }
}