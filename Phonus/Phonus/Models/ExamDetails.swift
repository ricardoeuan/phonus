//
//  Result.swift
//  Phonus
//
//  Created by Ricardo Euán Romo on 4/24/16.
//  Copyright © 2016 Ricardo Euán Romo. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExamDetails: ResponseJSONObjectSerializable {
    
    var date: String!
    var name: String!
    var maxFrequency: Int!
    var minFrequency: Int!
    
    required init (json: JSON) {
        self.date = json["FechaRealizacion"].string
        self.name = json["NombreAplicante"].string
        self.maxFrequency = json["FrecuenciaMaxima"].int
        self.minFrequency = json["FrecuenciaMinima"].int
    }
    
    func description() -> String {
        return "Date: \(self.date)\n" +
            "Name: \(self.name)\n" +
            "Max Frequency: \(self.maxFrequency)\n" +
            "Min Frequency: \(self.minFrequency)\n"
    }
}