//
//  PlaceModel.swift
//  FourSquareCloneApp
//
//  Created by burak ozen on 27.10.2021.
//

import Foundation
import UIKit
import MapKit


class PlaceModel {
    
    
//    Singleton ın asıl olayı olsuturulan class içerisinde sadece benim belirlediğim id ve benzeri bilgilerin gösterilmesini sağlamak
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var plceType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    
    var placeLatitude = ""
    var placeLongitude = ""
    
    
    private init(){
        
    }
    
    
    
}


