// ********************** ContentView *********************************
// * Copyright © Cearus, LLC - All Rights Reserved
// * Created on 5/9/21, for DAFIF_DVD_Zipper
// * Matthew Elmore <matt@cearus.llc>
// * Unauthorized copying of this file is strictly prohibited
// ********************** ContentView *********************************


import SwiftUI


struct ContentView: View {
    
    @ObservedObject var zipper = Zipper()
    var workingDotSize: CGFloat = 20
    
    var body: some View {
        VStack {
            Button {
                zipper.zipTheShit() }
                label: { Text("Zip it!!") }
            Spacer()
            Circle()
                .frame(width: workingDotSize, height: workingDotSize)
                .foregroundColor(zipper.working ? .red : .green)
        }.padding()
        .frame(width: 300, height: 100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
