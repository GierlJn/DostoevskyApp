//
//  RatingManager.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 24.02.22.
//

import Foundation

 class RatingManager{
     
     var location: DLocation
     
     init(location: DLocation){
         self.location = location
     }
     
    var hasVotedUp: Bool{
        let intValue = UserDefaults.standard.integer(forKey: location.name)
        return intValue > 0
    }
 }
