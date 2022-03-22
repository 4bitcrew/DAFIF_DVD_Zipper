// ********************** Zipper *********************************
// * Copyright © Cearus, LLC - All Rights Reserved
// * Created on 5/9/21, for DAFIF_DVD_Zipper
// * Matthew Elmore <matt@cearus.llc>
// * Unauthorized copying of this file is strictly prohibited
// ********************** Zipper *********************************

import Foundation
import SwiftUI
import Zip
import Scripts


class Zipper: ObservableObject {
    
    @Published var working: Bool = false
    
    let awsURL = "https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3Fstate%3DhashArgs%2523%26isauthcode%3Dtrue&client_id=arn%3Aaws%3Aiam%3A%3A015428540659%3Auser%2Fhomepage&forceMobileApp=0&code_challenge=grRD-Nsl2pnPqdyYkwvrIT6hvp5DtyyTeIkLmxzbbYc&code_challenge_method=SHA-256"
    
    
    public func zipTheShit() {
        working = true
        let documents = FileManager().homeDirectoryForCurrentUser
        doCatch({
            let utilities = Utilities()
            let dafif8DVDLocation = utilities.chooseLocationWhereTheMagicHappens()
            let mainDafifFolder = documents.appendingPathComponent("DAFIF8")
            if FileManager.default.fileExists(atPath: mainDafifFolder.path) {
                deleteAllFiles(in: mainDafifFolder)
            } else {
                try FileManager.default.createDirectory(at: mainDafifFolder, withIntermediateDirectories: false, attributes: nil)
            }
            let files = FM.getUrls(of: dafif8DVDLocation)
            for file in files {
                print(file.lastPathComponent)
                if file.lastPathComponent == "DAFIFT" || file.lastPathComponent == "VERSION" {
                    try FileManager.default.copyItem(at: file, to: mainDafifFolder.appendingPathComponent(file.lastPathComponent))
                }
            }
            _ = try Zip.zipFiles(paths: [mainDafifFolder.appendingPathComponent("DAFIFT")], zipFilePath: mainDafifFolder.appendingPathComponent("DAFIFT.zip"), password: nil, progress: nil)
            _ = try Zip.zipFiles(paths: [mainDafifFolder], zipFilePath: documents.appendingPathComponent("DAFIF8.zip"), password: nil, progress: nil)
            try FileManager.default.removeItem(at: mainDafifFolder)
            let storLocation = utilities.chooseLocationWhereTheMagicHappens().appendingPathComponent("DAFIF8.zip")

            try FileManager.default.moveItem(at: documents.appendingPathComponent("DAFIF8.zip"), to: storLocation)
            working = false
            NSWorkspace.shared.open(URL(string: awsURL)!)
        })
    }

    public func deleteAllFiles(in url: URL) {
        do {
            let listOfFiles = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for url in listOfFiles {
                try FileManager.default.removeItem(at: url)
            }} catch { print(error) }}

    func doCatch(_ do_: () throws -> Void, _ catch_: (() -> Void)? = nil) {
        do {
            try do_()
        } catch {
            if catch_ != nil {
                catch_!()
            }
            print(error)
        }
    }

    

}

