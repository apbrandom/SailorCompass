//
//  CloudKitUser.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 07.11.2023.
//

//let admin = "_0fec703d16870d299f25b91b66629fef"

import SwiftUI
import CoreData
import CloudKit

class CloudKitUserViewModel: ObservableObject {
    
    @State private var userIDs = [String]()
    
    @Published var isSignedIn = false
    @Published var isAdmin = false
    @Published var permisionStatus = false
    @Published var isLoading = true
    @Published var error = ""
    @Published var isAtSea = false
    @Published var crewRole = ""
    @Published var showingEditScreen = false
    
    init() {
        requestPermision()
        getCloudStatus()
        fetchCloudUserRecordID()
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccontNotDetermined
        case iCloudAccountUnkmown
        case iCloudAccountRestricted
        case iCloudAccountNotFound
        case iCloudAccountTemporarilyUnavailable
    }
    
    private func getCloudStatus() {
        CKContainer.default().accountStatus { [weak self] status, error in
            DispatchQueue.main.async {
                switch status {
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccontNotDetermined.rawValue
                case .available:
                    self?.isSignedIn = true
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .temporarilyUnavailable:
                    self?.error = CloudKitError.iCloudAccountTemporarilyUnavailable.rawValue
                @unknown default:
                    self?.error = CloudKitError.iCloudAccountUnkmown.rawValue
                }
            }
        }
    }
    
    func requestPermision() {
        CKContainer.default().requestApplicationPermission(.userDiscoverability) { [weak self] status, error in
            DispatchQueue.main.async {
                if status == .granted {
                    self?.permisionStatus = true
                }
            }
        }
    }
    
    func fetchCloudUserRecordID() {
        CKContainer.default().fetchUserRecordID { [weak self] recordID, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if let error = error {
                    self.error = error.localizedDescription
                    self.isLoading = false
                    return
                }
                
                guard let userID = recordID?.recordName else {
                    self.error = "Unknown error: User ID is not available"
                    self.isLoading = false
                    return
                }
                
                CloudKitService.shared.fetchAdminUserIDs { result in
                    switch result {
                    case .success(let admins):
                        self.isAdmin = admins.contains(userID)
                    case .failure(let error):
                        self.error = error.localizedDescription
                    }
                    
                    if let unwrappedRecordID = recordID {
                        self.discoverCloudUser(userID: unwrappedRecordID)
                    } else {
                        self.error = "Record ID is nil"
                    }
                    self.isLoading = false
                }
            }
        }
    }
    
    func discoverCloudUser(userID: CKRecord.ID) {
        let operation = CKDiscoverUserIdentitiesOperation(userIdentityLookupInfos: [.init(userRecordID: userID)])
        operation.userIdentityDiscoveredBlock = { identity, _ in
            DispatchQueue.main.async {
                let newName = identity.nameComponents?.givenName ?? "Unknown"
                let newLastName = identity.nameComponents?.familyName ?? "Unknown"
                
                UserDefaults.standard.set(newName, forKey: "userName")
                UserDefaults.standard.set(newLastName, forKey: "userLastName")
                
                self.isLoading = false
            }
        }
        
        operation.discoverUserIdentitiesResultBlock = { result in
            switch result {
            case .success():
                // Обработка успешного завершения операции
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
        CKContainer.default().add(operation)
    }
}

extension CloudKitUserViewModel {
    static var preview: CloudKitUserViewModel {
        let viewModel = CloudKitUserViewModel()
        viewModel.isAdmin = false
        viewModel.isSignedIn = true
        return viewModel
    }
}
