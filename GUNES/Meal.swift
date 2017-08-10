//
//  Meal.swift
//  GUNES
//
//  Created by Güneş Yurdakul on 09/08/2017.
//  Copyright © 2017 gunesyurdakul. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding{
    
    //MARK: Properties
    struct propertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Initializaton

    
    init?(name: String, photo: UIImage?, rating:Int){
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating>=0) && (rating<=5) else{
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: propertyKey.name)
        aCoder.encode(photo, forKey: propertyKey.photo)
        aCoder.encode(rating, forKey: propertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: propertyKey.name)  as? String else {
            os_log("unableto decode name", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: propertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: propertyKey.rating)
        self.init(name: name, photo: photo, rating: rating)
    }
 
}
