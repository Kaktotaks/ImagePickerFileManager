//
//  RealmManager.swift
//  ImagePickerFileManager
//
//  Created by Леонід Шевченко on 12.08.2022.
//

import Foundation
import RealmSwift

struct MyRealmManager {
    
    let realm = try? Realm()
    
    static let shared = MyRealmManager()
    
    private init() { }
    
    // MARK: add All Objects To Realm DONE
    func addAllObjectsToRealm(realmEntities: Object) {
        do {
            try realm?.write {
                realm?.add(realmEntities)
            }
        } catch {
            print("An error while realm try to add objects: \(error).")
        }
    }
    
    // MARK: Display realm object
    func retrieveAllDataForObject<T: Object>(remoteObjects: [T]) -> [T] {
        var realmObjct = [T]()
        guard let results = realm?.objects(T.self) else { return [] }
        for item in results {
            realmObjct.append(item)
        }
        return realmObjct
    }
    
    // MARK: Clear Database from Realm's objects DONE
    func realmTryDeleteAllObjects(_ objects : [Object], completion: @escaping(() -> Void)) {
        do {
            try realm?.write {
                realm?.delete(objects)
            }
        } catch {
            print("An error while realm try delete objects: \(error).")
        }
        completion()
    }
}
