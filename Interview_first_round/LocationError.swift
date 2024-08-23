//
//  LocationError.swift
//  Interview_first_round
//
//  Created by Arseniy Churanov on 8/21/24.
//

import Foundation

enum LocationError: Error {
    case missingData
    case networkError
    case unexpectedError(error: Error)
}

extension LocationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Found Missing Data.", comment: "missing data")
        case .networkError:
            return NSLocalizedString("Error connecting to network.", comment: "network error")
        case .unexpectedError(let error):
            return NSLocalizedString("Unexpected Error. \(error.localizedDescription)", comment: "unexpected error")
        }
    }
}
