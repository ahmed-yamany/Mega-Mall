import Foundation
import os
// swiftlint:disable all
public final class LoggingCategories {
    static let shared = LoggingCategories()
    var `default`: String { "Default" }
}
extension LoggingCategories {
    var onboarding: String { "Onboarding" }
    var home: String { "Home" }
}
/// The Logging protocol defines a standardized way of logging messages in an application or system.
public protocol Logging {
    func log(_ message: String,
             category: KeyPath<LoggingCategories, String>,
             level: OSLogType,
             file: StaticString,
             function: StaticString,
             line: UInt)
}
class SystemLogger: Logging {
    func log(_ message: String,
             category: KeyPath<LoggingCategories, String>,
             level: OSLogType,
             file: StaticString,
             function: StaticString,
             line: UInt) {
        let logMessage = "\(file) - \(function) - \(line): \(message)"
        let categoryString = LoggingCategories.shared[keyPath: category]
        os.Logger(subsystem: "com.Lepgo.Logger", category: categoryString).log(level: level, "\(logMessage)")        
    }
}
final class Logger {
    private static let loggers: [Logging] = {
        // if in testing return empty array of logging
        if NSClassFromString("XCTest") != nil { return [] }
        return [ SystemLogger() ]
    }()
    static func log(_ message: String,
                    category: KeyPath<LoggingCategories, String>,
                    level: OSLogType,
                    file: StaticString = #fileID,
                    function: StaticString = #function,
                    line: UInt = #line) {
        loggers.forEach { logger in
            logger.log(message, category: category, level: level, file: file, function: function, line: line)
        }
    }
}
// swiftlint:enable all
