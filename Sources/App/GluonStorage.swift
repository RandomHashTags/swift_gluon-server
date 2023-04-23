//
//  GluonStorage.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

final class GluonStorage<Key: Hashable, Value> {
    private let wrapped:NSCache<WrappedKey, Entry> = NSCache<WrappedKey, Entry>()
    private let lifetime:TimeInterval!
    
    init() {
        lifetime = nil
    }
    init(lifetime: TimeInterval?) {
        self.lifetime = lifetime
    }
    
    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            guard let value:Value = newValue else {
                remove_value(for_key: key)
                return
            }
            insert(value, forKey: key)
        }
    }
    
    func get_or_insert(_ key: Key, _ handler: @escaping () -> Value) -> Value {
        if let existingValue:Value = value(forKey: key) {
            return existingValue
        }
        let insertedValue:Value = handler()
        insert(insertedValue, forKey: key)
        return insertedValue
    }
    func get_or_insert_optional(_ key: Key, _ handler: @escaping () -> Value?) -> Value? {
        if let existingValue:Value = value(forKey: key) {
            return existingValue
        }
        guard let insertedValue:Value = handler() else { return nil }
        insert(insertedValue, forKey: key)
        return insertedValue
    }
    func insert_if_absent(_ val: Value, for_key key: Key) {
        guard value(forKey: key) == nil else { return }
        insert(val, forKey: key)
    }
    private func insert(_ value: Value, forKey key: Key) {
        let expiration:Date? = lifetime != nil ? Date(timeIntervalSinceNow: lifetime) : nil
        let entry:Entry = Entry(value: value, expiration: expiration)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    private func value(forKey key: Key) -> Value? {
        guard let entry:Entry = wrapped.object(forKey: WrappedKey(key)) else { return nil }
        let expiration:Date? = entry.expiration
        guard let expiration:Date = expiration else { return entry.value }
        guard Date() < expiration else {
            remove_value(for_key: key)
            return nil
        }
        return entry.value
    }
    func remove_value(for_key key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
    func remove_all() {
        wrapped.removeAllObjects()
    }
}

private extension GluonStorage {
    final class WrappedKey : NSObject {
        let key:Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override var hash: Int {
            return key.hashValue
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value:WrappedKey = object as? WrappedKey else { return false }
            return value.key == key
        }
    }
    
    final class Entry {
        let value:Value, expiration:Date?
        
        init(value: Value, expiration: Date?) {
            self.value = value
            self.expiration = expiration
        }
    }
}

protocol GluonSharedInstance {
    init()
}
extension GluonSharedInstance {
    static var shared_instance : Self {
        let type:String = String(describing: Self.self)
        if let cached:Self = GluonStorageSharedInstances.instances[type] as? Self {
            return cached
        }
        let bro:Self = Self.init()
        GluonStorageSharedInstances.instances[type] = bro
        return bro
    }
}

enum GluonStorageSharedInstances {
    fileprivate static var instances:GluonStorage<String, GluonSharedInstance> = GluonStorage<String, GluonSharedInstance>()
}
