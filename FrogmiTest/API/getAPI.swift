//
//  getAPI.swift
//
//  Created by MAC-DESMOBILE on 21-10-21.
//

import Foundation
import HGPlaceholders
import ViewAnimator

//MARK: - APICaller
class APICaller {
    
    func fecthData ( completion: @escaping (Result<ResultData, Error>) -> Void){
 
        let urlBase = "https://api.frogmi.com/api/v3/stores?per_page=1"
        let url = URL(string: urlBase)
        guard let requestUrl = url else { fatalError() }
       

        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.setValue("application/vnd.api+json", forHTTPHeaderField: "Accept")

        request.setValue("f778cdddd11be8468161f9d9bc8a0a33", forHTTPHeaderField: "Authorization")

        request.setValue("b7fa583e-a144-4ec2-9464-e1e514512fb4", forHTTPHeaderField: "X-Company-UUID")
        
        
       let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
           guard let data = data else {return }
           
           do{
               let jsonResult = try JSONDecoder().decode(ResultData.self, from: data)
               
               DispatchQueue.main.async {
                
                   completion(.success( jsonResult))
                
               }
               
           }
           catch {
              let error = error
              print("\(error.localizedDescription) to parse json")
                
           }
        
       }.resume()
    }
    
    func fecthDataPerPage (urlBase:String, completion: @escaping (Result<ResultData, Error>) -> Void){
        
        
        let url = URL(string: urlBase)
        guard let requestUrl = url else { fatalError() }
       

        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.setValue("application/vnd.api+json", forHTTPHeaderField: "Accept")

        request.setValue("f778cdddd11be8468161f9d9bc8a0a33", forHTTPHeaderField: "Authorization")

        request.setValue("b7fa583e-a144-4ec2-9464-e1e514512fb4", forHTTPHeaderField: "X-Company-UUID")
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: {
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {return }
                
                do{
                    let jsonResult = try JSONDecoder().decode(ResultData.self, from: data)
                    
                    DispatchQueue.main.async {
                      
                        completion(.success(jsonResult))
                     
                    }
                    
                }
                catch {
                   let error = error
                   print("\(error.localizedDescription) to parse json")
                     
                }
             
            }.resume()
        })
        
    }
}
