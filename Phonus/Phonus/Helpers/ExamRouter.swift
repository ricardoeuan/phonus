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
        
        let result: (path: String, parameters: [String: AnyObject]?) = {
            switch self {
            case .GetExamById(let examID):
                return ("/DetallesExamen?examenID=\(examID)", nil)
            case .RegisterExam(let exam):
                return ("/Registrar", exam)
            }
        }()
        
        let URL = NSURL(string: ExamRouter.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        
        let encoding = Alamofire.ParameterEncoding.JSON
        let (encodedRequest, _) = encoding.encode(URLRequest, parameters: result.parameters)
        
        encodedRequest.HTTPMethod = method.rawValue
        
        return encodedRequest
    }
}