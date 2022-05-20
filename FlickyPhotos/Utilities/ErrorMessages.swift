//
//  ErrorMessages.swift
//  FlickyPhotos
//
//  Created by Abdallah Ehab on 20/05/2022.
//

import Foundation

enum FLICKError: String , Error{
    case invalidUserName   = "invalid request. Please try again."
    case unableToComplete  = "Unable to Complete your Request. please Check internet Connection"
    case invalidResponse   = "invalid Response from Server. please Check The internet and try again."
    case invalidData       = "The data Recived from server was invalid. please try again."
}
