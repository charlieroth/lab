import Vapor

let temperatureLogger = TemperatureLogger(label: "Tea Kettle")

struct Reading: Content {
    var measurement: Int
}

func routes(_ app: Application) throws {
    app.get("ping") { req async in
        "pong"
    }
    
    app.get("readings") { req async -> [TemperatureReading] in
        let readings = await temperatureLogger.getReadings()
        return readings
    }
    
    app.get("readings", "max") { req async throws -> TemperatureReading in
        do {
            let maxReading = try await temperatureLogger.getMaxReading()
            return maxReading
        } catch TemperatureLoggerError.emptyReadings {
            throw Abort(HTTPStatus.badRequest, reason: "No temperature readings available")
        }
    }

    app.post("reading") { req async throws -> HTTPStatus in
        let temperatureReading = try req.content.decode(TemperatureReading.self)
        await temperatureLogger.addReading(from: temperatureReading)
        return HTTPStatus.ok
    }
}
