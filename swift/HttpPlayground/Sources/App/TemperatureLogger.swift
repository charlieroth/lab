//
//  TempatureLogger.swift
//
//
//  Created by Charlie Roth on 2024-02-28.
//

import Foundation
import Vapor

enum TemperatureLoggerError: Error {
    case emptyReadings
}

struct TemperatureReading: Sendable, Content {
    var timestamp: Date
    var measurement: Double
}

actor TemperatureLogger {
    let label: String
    private var readings: [TemperatureReading]
    
    init(label: String) {
        self.label = label
        self.readings = []
    }
    
    func getReadings() -> [TemperatureReading] {
        return readings
    }
    
    func getMaxReading() throws -> TemperatureReading {
        guard readings.count > 0 else {
            throw TemperatureLoggerError.emptyReadings
        }
        
        var maxReading = readings[0]
        for reading in readings {
            if reading.measurement > maxReading.measurement {
                maxReading = reading
            }
        }
        
        return maxReading
    }
    
    func convertFahrenheitToCelsius() {
        readings = readings.map { reading in
            TemperatureReading(
                timestamp: reading.timestamp,
                measurement: (reading.measurement - 32) * 5 / 9
            )
        }
    }
    
    func addReading(from reading: TemperatureReading) {
        readings.append(reading)
    }
}
