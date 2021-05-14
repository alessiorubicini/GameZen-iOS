// BiometricLogic.swift
// Copyright (C) 2021 Alessio Rubicini.
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

import Foundation
import SwiftUIComponents
import LocalAuthentication

// This function performs a biometric authentication
// It's used for delicate actions like order cancelation
// The function uses a specific hardware component based on the iPhone model (TouchID or FaceID)
func authenticateWithBiometric(completion: @escaping (Bool) -> Void) {
    
    let context = LAContext()
    var error: NSError?
    
    // Check if the device has biometric hardware available
    if context.biometryType == .none {
        completion(false)
    }

    // Check whether biometric authentication is possible
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        
        // It's possible, so go ahead and use it
        let reason = "per eseguire azioni delicate come l'annullamento dell'ordine"

        // Perform authentication
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
            
            // Authentication completed
            DispatchQueue.main.async {
                
                if success {
                    
                    // Authenticated successfully
                    completion(true)
                    
                } else {
                    
                    // Encountered a problem, generating error haptic feedback
                    HapticGenerator().notificationFeedback(type: .error)
                    completion(false)
                    
                }
                
            }
        }
    } else {
        
        // No biometrics
        HapticGenerator().notificationFeedback(type: .error)
    }
}

extension LAContext {
    
    enum BiometricType: String {
        case none
        case touchID
        case faceID
    }

    var biometricType: BiometricType {
        var error: NSError?

        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }

        if #available(iOS 11.0, *) {
            switch self.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            @unknown default:
                return .none
            }
        }
        
        return self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
    }
}
