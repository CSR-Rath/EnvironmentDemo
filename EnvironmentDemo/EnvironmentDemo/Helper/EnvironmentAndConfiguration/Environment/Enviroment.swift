//
//  Enviroment.swift
//  EnvironmentDemo
//
//  Created by Rath! on 5/6/24.
//MARK: References cofiguration enviroment URL Link https://www.youtube.com/watch?v=1GAgBtlwKJ4

import Foundation

enum DemoEnvironment {
    
    private static let infoDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError ("plist is not found" )
        }
        return dict
    }()
    
    static let rootURL: URL = {
        
        guard let uriString = DemoEnvironment.infoDict["Root_URL"] as? String else {
            fatalError ("Root_UL is not found")
        }
        
        guard let url = URL (string: uriString) else {
            fatalError ("Root_URL is invalid")
        }
        return url
    }()
    
    

    static let apiKey: URL = {
        
        guard let apiKey = DemoEnvironment.infoDict["Api_Key"] as? String else {
            fatalError ("Api_Key is not found")
        }
        
        guard let api = URL (string: apiKey) else {
            fatalError ("Api_Key is invalid")
        }
        return api
    }()
    

    
    
    // For google service API_KEY, GCM_SENDER_ID, BUNDLE_ID, PROJECT_ID, STORAGE_BUCKET, GOOGLE_AP_ID
    static let API_KEY: String = {
        
        guard let API_KEY = DemoEnvironment.infoDict["API_KEY"] as? String else {
            fatalError ("API_KEY is not found")
        }
        return API_KEY
    }()
    
    static let GCM_SENDER_ID: String = {
        
        guard let GCM_SENDER_ID = DemoEnvironment.infoDict["GCM_SENDER_ID"] as? String else {
            fatalError ("GCM_SENDER_ID is not found")
        }
        return GCM_SENDER_ID
    }()
    
    static let BUNDLE_ID: String = {
        
        guard let bundleId = DemoEnvironment.infoDict["BUNDLE_ID"] as? String else {
            fatalError ("BUNDLE_ID is not found")
        }
        return BUNDLE_ID
    }()
    
    
    static let PROJECT_ID: String = {
        
        guard let PROJECT_ID = DemoEnvironment.infoDict["PROJECT_ID"] as? String else {
            fatalError ("PROJECT_ID is not found")
        }
        return PROJECT_ID
    }()
    
    
    static let STORAGE_BUCKET: String = {
        
        guard let STORAGE_BUCKET = DemoEnvironment.infoDict["STORAGE_BUCKET"] as? String else {
            fatalError ("STORAGE_BUCKET is not found")
        }
        return STORAGE_BUCKET
    }()
    
    
    static let GOOGLE_AP_ID: String = {
        
        guard let GOOGLE_AP_ID = DemoEnvironment.infoDict["GOOGLE_AP_ID"] as? String else {
            fatalError ("GOOGLE_AP_ID is not found")
        }
        return GOOGLE_AP_ID
    }()
    
//    static let bundleId = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
    
}
