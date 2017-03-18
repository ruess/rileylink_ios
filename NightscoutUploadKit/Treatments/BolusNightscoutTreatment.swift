//
//  BolusNightscoutTreatment.swift
//  RileyLink
//
//  Created by Pete Schwamb on 3/10/16.
//  Copyright © 2016 Pete Schwamb. All rights reserved.
//

import Foundation

public class BolusNightscoutTreatment: NightscoutTreatment {
    
    enum BolusType: String {
        case Normal = "normal"
        case Square = "square"
        case DualWave = "dual"
    }
    
    let bolusType: BolusType
    let amount: Double
    let programmed: Double
    let unabsorbed: Double
    let duration: TimeInterval
    let carbs: Int
    let ratio: Double
    
    init(timestamp: Date, enteredBy: String, bolusType: BolusType, amount: Double, programmed: Double, unabsorbed: Double, duration: TimeInterval, carbs: Int, ratio: Double, notes: String? = nil) {
        self.bolusType = bolusType
        self.amount = amount
        self.programmed = programmed
        self.unabsorbed = unabsorbed
        self.duration = duration
        self.carbs = carbs
        self.ratio = ratio
        super.init(timestamp: timestamp, enteredBy: enteredBy, notes: notes)
    }
    
    override public var dictionaryRepresentation: [String: Any] {
        var rval = super.dictionaryRepresentation
        if carbs > 0 {
            rval["eventType"] = "Meal Bolus"
            rval["carbs"] = carbs
            rval["ratio"] = ratio
        } else {
            rval["eventType"] = "Correction Bolus"
        }
        rval["type"] = bolusType.rawValue
        rval["insulin"] = amount
        rval["programmed"] = programmed
        rval["unabsorbed"] = unabsorbed
        rval["duration"] = duration.minutes
        return rval
    }
}
