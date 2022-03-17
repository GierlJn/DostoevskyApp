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
  
  static func midPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
    return CGPoint(x:(p1.x + p2.x) / 2,y: (p1.y + p2.y) / 2)
  }
  
  static func controlPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
    var controlPoint = CGPoint.midPointForPoints(p1:p1, p2:p2)
    let diffY = abs(p2.y - controlPoint.y)
    
    if (p1.y < p2.y){
      controlPoint.y += diffY
    } else if (p1.y > p2.y) {
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

enum LocationCellType{
  case starting, leading, trailing, ending
  
  static func getType(_ i: Int, total: Int)->Self{
    if i == 0{
      return .starting
    }
    if i % 2 == 0{
      return .trailing
    }
    if i % 2 != 0{
      return .leading
    }
    if i == total-1{
      return .ending
    }
    return .leading
  }
}

struct TimeLineView: View {
  
  @EnvironmentObject var viewModel: AppState
  @State var categories = Categories.allCases
  @State var sortSettings = Array.init(repeating: SortType.date, count: Categories.allCases.count)
  
  
  var body: some View {
    
    VStack{
      
      ScrollView(showsIndicators: false){
        ForEach(0 ..< viewModel.locations.biographyLocations.count){ i in
          let location = viewModel.locations.biographyLocations[i]
          Button {
              viewModel.selectedLocation = location
              viewModel.showDetail = ActiveStatus.active
          } label: {
            
            switch i{
            case _ where i == 0 || i >= viewModel.locations.biographyLocations.count-1:
              StartingLocationCell(viewModel: viewModel, location: location)
            case _ where i % 2 == 0:
              LeadingLocationCell(viewModel: viewModel, location: location)
            case _ where i % 2 != 0:
              TrailingLocationCell(viewModel: viewModel, location: location)
            default:
              EmptyView()
            }
          }
          if i < viewModel.locations.biographyLocations.count-1{
            ConnectingLine()
              .stroke(.secondary, style: StrokeStyle(lineWidth: 3, lineCap:.round, lineJoin: .round, dash: [10], dashPhase: 1))
                .frame(width: 3, height: 90)
          }
        }
      }
    }
    .padding()
    .accentColor(.white)
    
  }

  
  func sortLocations(locations: [DLocation], sortType: SortType)->[DLocation]{
    switch sortType{
    case .date:
      return locations.sorted(by: { $0.id < $1.id })
    case .rating:
      return locations.sorted(by: { viewModel.getRatingForLocation(location: $0).rating > viewModel.getRatingForLocation(location: $1).rating })
    case .favorite:
      return locations.sorted { loc1, loc2 in
        viewModel.favoriteIds.hasName(loc1.name.en) && !viewModel.favoriteIds.hasName(loc2.name.en)
      }
    }
  }
  
  func filteredLocations(for category: Categories)->[DLocation]{
    viewModel.showingFavorites ? viewModel.locations.filter{$0.definedCategory == category}.filter({ loc in
      viewModel.favoriteIds.contains("\(loc.name.en)")
    }) : viewModel.locations.filter{$0.definedCategory == category}
  }
}


