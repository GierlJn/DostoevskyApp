//
//  MainListView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI

struct MainListView: View {
    
    var locations = [DLocation]()
    
    var body: some View {
        List{
            ForEach(locations, id: (\.self)){ location in
                
            }
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
