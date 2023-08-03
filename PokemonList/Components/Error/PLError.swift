//
//  PLError.swift
//  PokemonList
//
//  Created by patricia.martinez on 4/7/23.
//

import Foundation

enum PLError: String, Error {
    case invalidRequest = "Invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
