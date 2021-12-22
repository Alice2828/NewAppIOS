//
//  UsersManager.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 16.12.2021.
//

import Foundation
import CoreData
import Combine
import FirebaseAuth
import SwiftUI

class UsersManager: ObservableObject {
    let coreDataStore: CoreDataStoring!
    var bag: [AnyCancellable] = []
    @Published var currentUser: MyUser?
    @State var name: String?
    
    init(coreDataStore: CoreDataStoring) {
        self.coreDataStore = coreDataStore
        self._name = State(initialValue: Auth.auth().currentUser?.email ?? "")
        
        if let usrnm = Auth.auth().currentUser?.email{
            let request = NSFetchRequest<MyUser>(entityName: MyUser.entityName)
            request.predicate = NSPredicate(format: "username LIKE[cd] %@", usrnm)
            
            coreDataStore
                .publicher(fetch: request)
                .sink { completion in
                    if case .failure(let error) = completion {
                        print("\(error.localizedDescription)")
                    }
                } receiveValue: { [self] users in
                        self.currentUser = users.first
                }
                .store(in: &bag)
        }
    }
    
    func saveUser(username: String, name: String){
        //deleteAllUsers()
        deleteUserIfExist(username: username)
        let action: Action = { [self] in
            let entity: MyUser = coreDataStore.createEntity()
            entity.username = username
            entity.name = name
        }
        
        coreDataStore
            .publicher(save: action)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { [self] success in
                if success {
                    DispatchQueue.main.async {
                        fetch(username: username)
                    }
                }
            }
            .store(in: &bag)
    }
    
    func fetch(username: String?) {
        if let usrnm = username{
            let request = NSFetchRequest<MyUser>(entityName: MyUser.entityName)
            request.predicate = NSPredicate(format: "username LIKE[cd] %@", usrnm)
            
            coreDataStore
                .publicher(fetch: request)
                .sink { completion in
                    if case .failure(let error) = completion {
                        print("\(error.localizedDescription)")
                    }
                } receiveValue: { [self] users in
                    DispatchQueue.main.async {
                        currentUser = users.first
                        name = currentUser?.name
                        //print("HELLO fetch cur user \(currentUser?.username)")
                    }
                }
                .store(in: &bag)
        }
        else{}
    }
    
    func fetchAll() {
        
        let request = NSFetchRequest<MyUser>(entityName: MyUser.entityName)
        
        coreDataStore
            .publicher(fetch: request)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { users in
                print("HELLO all users \(users)")
            }
            .store(in: &bag)
    }
    
    func saveImage(pngData: Data){
        let action: Action = { [self] in
            currentUser?.setValue(pngData, forKeyPath: "image")
        }
        coreDataSave {
            action()
        }
    }
    
    func deleteImage(){
        let action: Action = { [self] in
            currentUser?.setValue(nil, forKeyPath: "image")
        }
        coreDataSave {
            action()
        }
    }
    
    func changeName(name: String){
        let action: Action = { [self] in
            currentUser?.setValue(name, forKeyPath: "name")
        }
        coreDataSave {
            action()
        }
    }
    
    func coreDataSave(action: @escaping Action){
        coreDataStore
            .publicher(save: action)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { [self] success in
                if success {
                    DispatchQueue.main.async {
                        //print("HELLO coreDataSave \(currentUser?.username)")
                        fetch(username: currentUser?.username)
                    }
                }
            }
            .store(in: &bag)
    }
    
    func deleteAllUsers() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: MyUser.entityName)
        //request.predicate = NSPredicate(format: "first_name LIKE[cd] %@", "Deda")
        coreDataStore
            .publicher(delete: request)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { _ in
                print("all deleted")
            }
            .store(in: &bag)
        
    }
    
    func deleteUserIfExist(username: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: MyUser.entityName)
        request.predicate = NSPredicate(format: "username LIKE[cd] %@", username)
        coreDataStore
            .publicher(delete: request)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { _ in
                print("all deleted")
            }
            .store(in: &bag)
        
    }
    
}
