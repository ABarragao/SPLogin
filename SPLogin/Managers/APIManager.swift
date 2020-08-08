//
//  APIManager.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 02/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import Foundation

enum wsError: Error{
    case urlError
    case parsingError
    case invalidFormat
    case missingToken
    case noInternet
    case apiError
}

struct APIManager {
    
    private let baseUrl = "https://us-central1-student-pop-technical-test.cloudfunctions.net/api"
    
    public static let shared = APIManager()
    
    private init(){}
    
    func login(email:String, password:String, completion: @escaping (wsError?, User?)->()){
        
        if !ReachabilityManager.shared.isReachable{
            completion(.noInternet, nil)
            return
        }
        
        guard let url = URL.init(string: baseUrl + "/login") else{
            completion(.urlError,nil)
            return
        }

        guard let body = ["email": email, "password": password].getData() else{
            completion(.invalidFormat,nil)
            return
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = body
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
          if let error = error {
            completion(.apiError,nil)
            print("Error with login: \(error)")
            return
          }
            
            if let data = data,
                let tokenDict = try? JSONDecoder().decode([String:String].self, from: data),
                let token = tokenDict["token"]{
                UserDefaults.standard.saveToken(token)
                
                self.getMe { (error, user) in
                    if(error != nil){
                        UserDefaults.standard.removeToken()
                    }
                    completion(.apiError,user)
                }
            }
            else{
                completion(.parsingError,nil)
            }

        }
        task.resume()
        
    }
    
    func getMe(completion: @escaping (wsError?,User?)->()){
        
        if !ReachabilityManager.shared.isReachable{
            CoreDataManager.shared.getUser { (user) in
                if user != nil {
                    completion(nil, user)
                }
                else{
                    completion(.noInternet, nil)
                }
            }
        }
        else{
            
            guard let token = UserDefaults.standard.getToken() else{
                completion(.missingToken, nil)
                return
            }
            
            guard let url = URL.init(string: baseUrl + "/me?token=\(token)") else{
                completion(.urlError, nil)
                return
            }
            
            var urlRequest = URLRequest.init(url: url)
            urlRequest.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    completion(.apiError, nil)
                    print("Error with login: \(error)")
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.apiFormat)
                
                if let data = data,
                    let user = try? decoder.decode(User.self, from: data){
                    DispatchQueue.main.async {
                        UserEntity.insert(user)
                        CoreDataManager.shared.saveContext()
                        completion(nil, user)
                    }
                }
                else{
                    completion(.parsingError, nil)
                }
                
            }
            task.resume()
        }
        
    }
    
    
}
