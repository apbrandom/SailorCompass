//
//  CloudKitUser.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 07.11.2023.
//

import SwiftUI
import CloudKit


class CloudKitUserViewModel: ObservableObject {
    
    @Published var isSignednToCloud = false
    @Published var userName = "Emtpty Name"
    @Published var userLastName = "Empty Name"
    @Published var isLoading = true
    @Published var error = ""
    
    init() {
        getCloudKitStatus()
        discoverCloudUser()
    }
    
    private func getCloudKitStatus() {
        CKContainer.default().accountStatus { [weak self] status, error in
            DispatchQueue.main.async {
                switch status {
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccontNotDetermined.rawValue
                case .available:
                    self?.isSignednToCloud = true
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
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccontNotDetermined
        case iCloudAccountUnkmown
        case iCloudAccountRestricted
        case iCloudAccountNotFound
        case iCloudAccountTemporarilyUnavailable
    }
    
    func requestPermision() {
    
    }
    
    func fetchCloudRecord() {
        
        CKContainer.default().fetchUserRecordID { id, error in
            DispatchQueue.main.async {
                
            }
        }
    }
    
    func discoverCloudUser() {
            CKContainer.default().fetchUserRecordID { [weak self] recordID, error in
                guard let recordID = recordID, error == nil else {
                    DispatchQueue.main.async {
                        self?.error = error?.localizedDescription ?? "Unknown error"
                        self?.isLoading = false
                    }
                    return
                }

                let operation = CKDiscoverUserIdentitiesOperation(userIdentityLookupInfos: [.init(userRecordID: recordID)])
                operation.userIdentityDiscoveredBlock = { identity, _ in
                    DispatchQueue.main.async {
                        self?.userName = identity.nameComponents?.givenName ?? "Unknown"
                        self?.userLastName = identity.nameComponents?.familyName ?? "Unknown"
                        self?.isLoading = false
                    }
                }

                operation.discoverUserIdentitiesResultBlock = { result in
                    switch result {
                    case .success():
                        // Обработка успешного завершения операции
                        break
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.error = error.localizedDescription
                            self?.isLoading = false
                        }
                    }
                }

                CKContainer.default().add(operation)
            }
        }

}

struct CloudKitUser: View {
    
    @StateObject var viewModel = CloudKitUserViewModel()
    
    var body: some View {
        VStack {
            Text("IS SIGNED IN :\(viewModel.isSignednToCloud.description) ")
            Text(viewModel.error)
        }
    }
}

#Preview {
    CloudKitUser()
}
