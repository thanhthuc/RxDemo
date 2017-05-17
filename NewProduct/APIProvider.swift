//
//  APIProvider.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 27/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

class WrapperAPI <T> {
   var dictionary: [String: AnyObject]!
   var classInstance: Any!
   
   init(jsonDict: [String: AnyObject]) {
      self.dictionary = jsonDict
      
      switch T.self {
      case is LoginRespond.Type:
         self.classInstance = LoginRespond(dict: self.dictionary)
         
      case is SignupRespond.Type:
         self.classInstance = SignupRespond(dict: self.dictionary)
         
      case is ProductsRespond.Type:
         self.classInstance = ProductsRespond(dict: self.dictionary)
         
      case is Product.Type:
         self.classInstance = Product(dict: self.dictionary, isForDetail: true)
         
      case is User.Type:
         self.classInstance = User(dict: self.dictionary)
         
      case is CheckoutRespond.Type:
         self.classInstance = CheckoutRespond(dict: self.dictionary)
         
      default:
         fatalError("WRONG TYPE")
      }
   }
}

class APIProvider<T: RequestType> {
   
   var requestType: T
   
   var request: URLRequest
   
   init(requestType: T) {
      
      self.requestType = requestType
      let urlString = self.requestType.baseURL + self.requestType.path
      self.request = URLRequest(url: URL(string:urlString)!)
      self.request.httpMethod = self.requestType.method.rawValue
      self.request.allHTTPHeaderFields = self.requestType.headers
      
      if let params = self.requestType.parameters {
         let bodyString = generateBodyString(params: params)
         self.request.httpBody = bodyString.data(using: .utf8, allowLossyConversion: true)
      }
   }
   
   private func generateBodyString(params: [String: Any]) -> String {
      
      let beginString = "{"
      let endString = "}"
      var bodyString = ""
      var count = params.count
      
      params.forEach { (key, value) in
         bodyString += "\"\(key)\" : \"\(value)\""
         count -= 1
         if count > 0 {
            bodyString += ","
         }
      }
      let resultString = beginString + bodyString + endString
      return resultString
      
   }
   
   public func APIrequest<T>() -> Observable<T> {
      return APIRespondFrom(request: self.request)
   }
   
   private func APIRespondFrom<T>(request: URLRequest) -> Observable<T> {
      
      return URLSession
         .shared
         .rx
         .response(request: request)
         .debug()
         .flatMapLatest { (response:URLResponse, data:Data) -> Observable<T> in
            
            guard let response = response as? HTTPURLResponse else {
               return Observable<T>.error(HTTPError.ResponseUndefined)
            }
            
            guard 200..<300 ~= response.statusCode else {
               return Observable<T>.error(HTTPError.RequestError(statusCode: response.statusCode))
            }
            
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            
            guard let jsonDict = jsonData else {
               return Observable<T>.error(HTTPError.RequestError(statusCode: response.statusCode))
            }
            
            let objectWrapperAPI = WrapperAPI<T>(jsonDict: jsonDict)
            
            return Observable<T>.just(objectWrapperAPI.classInstance as! T)
      }
   }
   
}
