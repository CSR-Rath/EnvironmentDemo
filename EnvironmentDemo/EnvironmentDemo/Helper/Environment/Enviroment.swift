//
//  Enviroment.swift
//  EnvironmentDemo
//
//  Created by Rath! on 5/6/24.
//

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
    
    static let bundleID: String = {
        
        guard let bundleId = DemoEnvironment.infoDict["BUNDLE_ID"] as? String else {
            fatalError ("BUNDLE_ID is not found")
        }
        
        return bundleId
    }()
    
    
//    static let bundleId = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
    
}
