//
//  HabHygService.swift
//  habhyglite
//
//  Created by Brian Lanham on 8/18/17.
//  Copyright © 2017 Brian Lanham. All rights reserved.
//

import Foundation

class HabHygService {
    
    var stellarData = [StarData]()
    
    init() {
//        self.reload()
    }
    
    func reload() {
        self.stellarData = [StarData]()
        self.loadHabHygData()
        
    }
    
    func load() {
        let request = NSMutableURLRequest(url: NSURL(string: "http://dmapi.loticfactor.com/api/HabHyg_Lite/4")! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            print (data!)
            print (response!)
            print (error!)
            if error != nil {
                print("Error: \(String(describing: error))")
            } else {
                print("Response: \(String(describing: response))")
                
            }
        })
        
        task.resume()
        
    }
    
    func loadHabHygData () {
        let todoEndpoint: String = "http://dmapi.loticfactor.com/api/HabHyg_Lite/"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared

        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                print("The todo is: " + todo.description)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
}
