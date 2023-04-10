//
//  AppDelegate.swift
//  macOS-EsayAI
//
//  Created by Emirhan Saygiver on 10.04.2023.
//

import Foundation
import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let contentView = ContentView()
            .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
            .environmentObject(Model())
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "brain", accessibilityDescription: "Brain")
            statusButton.action = #selector(togglePopover)
        }
        
        popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 400)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
    }
    
    @objc
    private func togglePopover() {
        guard let button = statusItem.button else {
            return
        }
        if popover.isShown {
            popover.performClose(nil)
        } else {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }
}
