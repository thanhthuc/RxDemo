//
//  HTTPError.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 4/30/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

enum HTTPError : Error {
   case RequestError(statusCode: Int)
   case ResponseUndefined
}

enum HTTPMethod : String {
   case GET = "GET"
   case POST = "POST"
}


enum APIClientError: Error {
   case CouldNotDecodeJSON
   case BadStatus(status: Int)
   case Other(Error)
}

extension APIClientError: CustomDebugStringConvertible {
   var debugDescription: String {
      switch self {
      case .CouldNotDecodeJSON:
         return "Could not decode JSON"
      case let .BadStatus(status):
         return "Bad status \(status)"
      case let .Other(error):
         return "\(error)"
      }
   }
}
