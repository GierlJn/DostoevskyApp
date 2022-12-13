import SwiftUI

extension CGPoint {
    static func getMidPoint(point1: CGPoint, point2: CGPoint) -> CGPoint {
        CGPoint(x: point1.x + (point2.x - point1.x) / 2,
                y: point1.y + (point2.y - point1.y) / 2)
    }

    func dist(to: CGPoint) -> CGFloat {
        sqrt(pow(x - to.x, 2) + pow(y - to.y, 2))
    }

    static func midPointForPoints(p1: CGPoint, p2: CGPoint) -> CGPoint {
        CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
    }

    static func controlPointForPoints(p1: CGPoint, p2: CGPoint) -> CGPoint {
        var controlPoint = CGPoint.midPointForPoints(p1: p1, p2: p2)
        let diffY = abs(p2.y - controlPoint.y)

        if p1.y < p2.y {
            controlPoint.y += diffY
        } else if p1.y > p2.y {
            controlPoint.y -= diffY
        }
        return controlPoint
    }
}

struct ConnectingLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}
