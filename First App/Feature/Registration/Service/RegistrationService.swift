//
//  RegistrationService.swift
//  First App
//
//  Created by fiqahalim on 21/09/2023.
//

import Foundation
import Firebase
import FirebaseDatabase
import Combine

struct RegistrationCredentials {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var role: String
}

protocol RegistrationService {
    func register(with credentials: RegistrationCredentials) -> AnyPublisher<Void, Error>
}

enum RegistrationKeys: String {
    case firstName
    case lastName
    case role
}

final class RegistrationServiceImpl: RegistrationService {
    
    func register(with credentials: RegistrationCredentials) -> AnyPublisher<Void, Error> {
        
        Deferred {

            Future { promise in
                
                Auth.auth().createUser(withEmail: credentials.email,
                                       password: credentials.password) { res, error in
                    
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        
                        if let uid = res?.user.uid {
                            
                            let values = [RegistrationKeys.firstName.rawValue: credentials.firstName,
                                          RegistrationKeys.lastName.rawValue: credentials.lastName,
                                          RegistrationKeys.role.rawValue: credentials.role] as [String : Any]
                            
                            Database
                                .database()
                                .reference()
                                .child("users")
                                .child(uid)
                                .updateChildValues(values) { error, ref in
                                    
                                    if let err = error {
                                        promise(.failure(err))
                                    } else {
                                        promise(.success(()))
                                    }
                                }
                        }
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
