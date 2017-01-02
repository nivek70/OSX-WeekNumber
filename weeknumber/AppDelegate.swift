//
//  AppDelegate.swift
//  weeknumber
//
//  Created by angelo on 18/01/16.
//  Copyright © 2016 no-one. All rights reserved.
//

import Cocoa
import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
    @IBOutlet weak var statusMenu: NSMenu!

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)

    @IBOutlet weak var Quit: NSMenuItem!

    @IBOutlet weak var _WeekNumber: NSString!
    
    @IBOutlet weak var _DayofYear: NSString!
    
    @IBOutlet weak var timer : NSTimer!
    
    @IBOutlet weak var currentImage : NSImage!
    
    var _week_ : Int! = 0
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        TestUpdateValues()
        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(aNotification: NSNotification) {
// Insert code here to tear down your application
    }


    @IBAction func QuitCliked(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    @IBAction func dummy(sender: AnyObject) {
    }

    override func awakeFromNib() {
        
        // periodic task (neverending loop)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector:"UpdateValues", userInfo:nil, repeats:true)
         }

    
    func UpdateValues() {
        // read week number and day of year values using shell command date
        let task = NSTask()
        task.launchPath = "/bin/date"
        task.arguments = ["+%V %j"]
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        
        // parse the output and put it into array fullNameArr
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = NSString (data: data, encoding: NSUTF8StringEncoding)
        let fullNameArr = output!.componentsSeparatedByString(" ")
        
        _WeekNumber = fullNameArr[0]
        _DayofYear  = fullNameArr[1].substringToIndex(fullNameArr[1].endIndex.predecessor())

        // drawing alternatives
  
       /*
        // 1) attributed string for title
        let Title =  NSAttributedString(string: ( (_WeekNumber as String) ), attributes: [ NSFontAttributeName: NSFont(name: "Futura Medium Italic", size: 18 )! ] )
        statusItem.button?.attributedTitle = Title
        statusItem.button?.toolTip = "Week: " + (_WeekNumber as String) + "\n" + "Day of Year: " + (_DayofYear as String)
        */
        
        /*
        // 2) NSImage adding Text
        currentImage = NSImage(named: "test")
        currentImage.size = NSSize(width: 32, height:32)
        currentImage.lockFocus()
        _WeekNumber.drawAtPoint(NSPoint(x: 8.0 , y: 4.0 ), withAttributes: [ NSFontAttributeName: NSFont(name: "Futura Medium Italic", size: 12 )! ])
        currentImage.unlockFocus()
        //currentImage.drawAtPoint(NSPoint(x: 0.0 , y: 0.0 ), fromRect: NSRect(x:0 , y:0 , width:32 , height:32), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1.0)
       // currentImage.drawInRect( NSRect(x:0 , y:0 , width:32 , height:32))
        //draw (layer: CALayer, inContext: (NSGraphicsContext.currentContext()?.CGContext)!)
        //statusItem.button?.frame = NSRect(x:0 , y:0 , width:32 , height:32)
        statusItem.image = currentImage
        //statusItem.button?.bezelStyle = NSBezelStyle.ThickSquareBezelStyle
        statusItem.button?.toolTip = "Week: " + (_WeekNumber as String) + "\n" + "Day of Year: " + (_DayofYear as String)
        */
        
        // 3) NSImage drawn by ourselves
        currentImage = NSImage(named: "template")
        currentImage.size = NSSize(width: 24, height:24)
        currentImage.lockFocus()
        NSEraseRect(NSRect(x:4 , y:3 , width:16 , height:11))
        //currentImage.drawInRect(NSRect(x:0 , y:0 , width:32 , height:32))
        _WeekNumber.drawAtPoint(NSPoint(x: 5.0 , y: 0.0 ), withAttributes: [ NSFontAttributeName: NSFont(name: "Futura Medium Italic", size: 12 )! ])
        currentImage.unlockFocus()
        //currentImage.drawAtPoint(NSPoint(x: 0.0 , y: 0.0 ), fromRect: NSRect(x:0 , y:0 , width:32 , height:32), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1.0)
        // currentImage.drawInRect( NSRect(x:0 , y:0 , width:32 , height:32))
        //draw (layer: CALayer, inContext: (NSGraphicsContext.currentContext()?.CGContext)!)
        //statusItem.button?.frame = NSRect(x:0 , y:0 , width:32 , height:32)
      
        statusItem.image = currentImage
        //statusItem.button?.bezelStyle = NSBezelStyle.ThickSquareBezelStyle
        statusItem.button?.toolTip = "Week: " + (_WeekNumber as String) + "\n" + "Day of Year: " + (_DayofYear as String)
        
    }

    func TestUpdateValues() {
        // read week number and day of year values using shell command date
        let task = NSTask()
        task.launchPath = "/bin/date"
        task.arguments = ["+%V %j"]
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        
        // parse the output and put it into array fullNameArr
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = NSString (data: data, encoding: NSUTF8StringEncoding)
        let fullNameArr = output!.componentsSeparatedByString(" ")
        
        _WeekNumber = fullNameArr[0]
        _DayofYear  = fullNameArr[1].substringToIndex(fullNameArr[1].endIndex.predecessor())

        if (_week_ >= 56) {
            _week_ = 0
        } else {
            _week_ = _week_ + 1
        }
        
        _WeekNumber = (_week_ as NSNumber).stringValue
        // 3) NSImage drawn by ourselves
            currentImage = NSImage(named: "template")
        currentImage.size = NSSize(width: 24, height:24)
 
        //currentImage.drawInRect(NSRect(x:0 , y:0 , width:32 , height:32))
        currentImage.lockFocus()
        NSEraseRect(NSRect(x:4 , y:3 , width:16 , height:11))
       // _WeekNumber.drawInRect(NSRect(x:5 , y:4 , width:16 , height:14), withAttributes: [ NSFontAttributeName: NSFont(name: "Futura Medium Italic", size: 12 )!  ])

        _WeekNumber.drawAtPoint(NSPoint(x: 5.0 , y: 0.0 ), withAttributes: [ NSFontAttributeName: NSFont(name: "Futura Medium Italic", size: 12 )!  ])
        currentImage.unlockFocus()
        //currentImage.drawAtPoint(NSPoint(x: 0.0 , y: 0.0 ), fromRect: NSRect(x:0 , y:0 , width:32 , height:32), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1.0)
        // currentImage.drawInRect( NSRect(x:0 , y:0 , width:32 , height:32))
        //draw (layer: CALayer, inContext: (NSGraphicsContext.currentContext()?.CGContext)!)
        //statusItem.button?.frame = NSRect(x:0 , y:0 , width:32 , height:32)
        
        statusItem.image = currentImage
        //statusItem.button?.bezelStyle = NSBezelStyle.ThickSquareBezelStyle
        statusItem.button?.toolTip = "Week: " + (_WeekNumber as String) + "\n" + "Day of Year: " + (_DayofYear as String)

        
    }

    
}

