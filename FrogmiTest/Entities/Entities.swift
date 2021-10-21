//  Created by Felipe Ignacio Zapata Riffo
import Foundation

// MARK: - ResultData
public struct ResultData: Codable {
    let data: [Datum]

}

// MARK: - Datum
public struct Datum: Codable {
    let id, type: String
    let attributes: Attributes
    let links: Link

}

// MARK: - Attributes
public struct Attributes: Codable {
    let name, code: String
    let active: Bool
    let full_address: String
    let coordinates: Coordinates
    let created_at: String

}

// MARK: - Coordinates
public struct Coordinates: Codable {
    let latitude, longitude: Double
}


// MARK: - Links
public struct Link: Codable {
    let prev:String?
    let next, first, last: String?
    let `self` : String?
  
     
}

  
