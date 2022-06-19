//
//  MainListView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI

extension CGPoint {
  static func getMidPoint(point1: CGPoint, point2: CGPoint) -> CGPoint {
    return CGPoint(
      x: point1.x + (point2.x - point1.x) / 2,
      y: point1.y + (point2.y - point1.y) / 2
    )
  }

  func dist(to: CGPoint) -> CGFloat {
    return sqrt((pow(self.x - to.x, 2) + pow(self.y - to.y, 2)))
  }

  static func midPointForPoints(p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
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

struct TimeLineView: View {

  @EnvironmentObject var viewModel: AppState
  @State var categories = Categories.allCases
  @State var sortSettings = Array.init(repeating: SortType.date, count: Categories.allCases.count)

  var body: some View {

    VStack {

      ScrollView(showsIndicators: false) {
        ForEach(0 ..< viewModel.locations.biographyLocations.count) { index in
          let location = viewModel.locations.biographyLocations[index]
          Button {
              viewModel.selectedLocation = location
              viewModel.showDetail = ActiveStatus.active
          } label: {

            switch index {
            case _ where index == 0 || index >= viewModel.locations.biographyLocations.count-1:
              StartingLocationCell(viewModel: viewModel, location: location)
            case _ where index % 2 == 0:
              LeadingLocationCell(viewModel: viewModel, location: location)
            case _ where index % 2 != 0:
              TrailingLocationCell(viewModel: viewModel, location: location)
            default:
              EmptyView()
            }
          }
          if index < viewModel.locations.biographyLocations.count-1 {
            ConnectingLine()
              .stroke(.secondary, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round, dash: [10], dashPhase: 1))
                .frame(width: 3, height: 90)
          }
        }
      }
    }
    .padding()
    .accentColor(.white)

  }

  func sortLocations(locations: [DLocation], sortType: SortType) -> [DLocation] {
    switch sortType {
    case .date:
      return locations.sorted(by: { $0.id < $1.id })
    case .rating:
      return locations.sorted(by: { viewModel.getRatingForLocation(location: $0).rating > viewModel.getRatingForLocation(location: $1).rating })
    case .favorite:
      return locations.sorted { loc1, loc2 in
        loc1.isFavorite && !loc2.isFavorite
      }
    }
  }

  func filteredLocations(for category: Categories) -> [DLocation] {
    viewModel.showingFavorites ? viewModel.locations.filter {$0.definedCategory == category}.filter({ loc in
      loc.isFavorite
    }) : viewModel.locations.filter {$0.definedCategory == category}
  }
}
