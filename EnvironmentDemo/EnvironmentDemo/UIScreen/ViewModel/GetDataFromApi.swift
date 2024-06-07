//
//  GetdataFromApi.swift
//  EnvironmentDemo
//
//  Created by Rath! on 7/6/24.
//

import Foundation

open class GetDataFromApi{
    
    let api = ApiManager()
    
    func tappedButtomRed(success: @escaping (PunchCardModel) -> Void) {
        
        api.apiConnection(url: "http://uat-api-prime.combomkt.com/master/punch-card?query=&page=0&size=10",
                          method: .GET,
                          param: nil,
                          headers: api.getHeader())
        { (data: PunchCardModel) in
            
            DispatchQueue.main.async {
                if data.response?.status == 200 {
                    success(data)
                }else{
                    print("data fail")
                }
            }
        }
    }
    
    func tappedButtomOrange(success: @escaping (RedeemListModel) -> Void) {
        
        api.apiConnection(url: "http://uat-api-prime.combomkt.com/master/merchandise?query=&page=0&size=10",
                          method: .GET,
                          param: nil,
                          headers: api.getHeader())
        { (data: RedeemListModel) in
            
            DispatchQueue.main.async {
                if data.response?.status == 200 {
                    success(data)
                }else{

                    print("data fail")
                }
            }
        }
    }
}


struct RedeemListModel : Codable{
    var page: Int?
    var size: Int?
    var total: Int?
    var totalPage: Int?
    var response : Response?
    var results : [ResultsRedeemListModel]?
}

struct ResultsRedeemListModel : Codable{
    var id: Int?
    var name: String?
    var code: String?
    var photo: String?
    var description: String?
    var point: Int?
    var memberType: [String]?
    var stores: [StoreModel]?
    var startDate: Int?
    var endDate: Int?
    var enable:Bool?
}

struct Response:Codable {
    var status: Int?
    var message: String?
}

struct RefreshToken : Codable{
    
    var results : ResultsPinCodeModel?
    var response : Response?
}

struct ResultsPinCodeModel : Codable{
    var token : String?
    var refreshToken : String?
}

struct PunchCardModel: Codable{
    var page, size, total, totalPage : Int?
    var results: [ResultsPunchCardModel]?
    var response : Response?
}

struct ResultsPunchCardModel: Codable{
    var id,stamp,maxStamp: Int?
    var spentAmount : Double?
    
    var startDate,
        endDate : Int?
    var name, photo, type,
        description
    : String?
        var stores: [StoreModel]?
    var enable: Bool?
}



struct PunchCardEditModel: Codable{
    
    var results: ResultsPunchCardEditModel?
    var response : Response?
}


struct ResultsPunchCardEditModel: Codable{
    var id: Int?
    var name: String?
    var photo: String?
    var stores: [StoreModel]?
    var type: String?
    var description:String?
    var maxStamp: Int?
    var stamp: Int?
    var spentAmount: Int?
    var startDate: Int?
    var endDate: Int?
    var enable : Bool?
}

struct  StoreModel : Codable{
    var id : Int?
    var name : String?
}
