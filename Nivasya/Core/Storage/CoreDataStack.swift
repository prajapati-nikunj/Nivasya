// File: Core/Storage/CoreDataStack.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import CoreData

public final class CoreDataStack {
    public static let shared = CoreDataStack()
    
    public let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "NivasyaDataModel")
        
        // Ensure the directory exists
        let description = container.persistentStoreDescriptions.first
        description?.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        container.loadPersistentStores { description, error in
            if let error = error {
                StructuredLogger.shared.log("CoreData failed to load: \(error.localizedDescription)", level: .critical)
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
