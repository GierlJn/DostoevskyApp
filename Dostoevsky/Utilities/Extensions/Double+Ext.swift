import Foundation

extension Double {
    static func initFromCommaString(str: String) -> Double {
        Double(str.split(separator: ",").joined(separator: ".")) ?? 0
    }
}
