//
//  ContentView.swift
//  LearnSpace
//
//  Created by Emilio Y Martinez on 15/04/23.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State var nivel = 0
    var body: some View {
        if nivel == 0 {
            Text("Diego Puto")
            Button{
                nivel+=1
            }label: {
                Text("cambiar")
            }
        }
        else{
            ARViewContainer().edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
