// ********************** Utilities *********************************
// * Copyright © Cearus, LLC - All Rights Reserved
// * Created on 5/10/21, for DAFIF_DVD_Zipper
// * Matthew Elmore <matt@cearus.llc>
// * Unauthorized copying of this file is strictly prohibited
// ********************** Utilities *********************************


import Foundation
import SwiftUI

struct Utilities {
        
    func chooseLocationWhereTheMagicHappens() -> URL {
        var result = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!
        let dialog = NSOpenPanel()
        dialog.title = "Choose where you want the magic to happen"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = true
        dialog.canCreateDirectories = true
        dialog.allowsMultipleSelection = false
        
        if dialog.runModal() == NSApplication.ModalResponse.OK {
            guard let result_ = dialog.url else {return result}
            result = result_
        } else {
            return result
        }
        print(result)
        return result
    }
    
    var createLocation: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}
