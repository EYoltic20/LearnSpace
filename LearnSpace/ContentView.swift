//
//  ContentView.swift
//  LearnSpace
//
//  Created by Emilio Y Martinez on 15/04/23.
//

import SwiftUI
import RealityKit
import CoreImage
import CoreImage.CIFilterBuiltins
import Combine
import AVKit

struct ContentView : View {
    @State var nivel = "home"
    @State private var ispregunta: Bool = false
//    @State var postProcessController: EntityPostProcessController?
    //    @StateObject var viewModel = ViewModel()
    var body: some View {
        switch nivel{
        case "home":
            HomeView(nivel: $nivel)
        case "Tierra":
            GeometryReader{geo in
                VStack(alignment:.leading){
                    Button{
                        nivel = "home"
                    }label: {
                        Circle().fill(.gray.opacity(0.5)).overlay{
                            VStack(alignment: .center){
                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                                    .frame(width:100,height:geo.size.height/9)
                                    .background{
                                        Color.black.opacity(0.1)
                                    }
                            }
                            
                        }.frame(width:100,height:geo.size.height/12)
                            .padding()
                    }
                    
                    
                    ARViewContainer(pregunta: $ispregunta)
                        .edgesIgnoringSafeArea(.all)
                        .sheet(isPresented:$ispregunta){
                            Text("hey")
                        }
                    
                    
                }
                .frame(width:geo.size.width,height:geo.size.height)
            }
        default:
            HomeView(nivel: $nivel)
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    //    @ObservedObject var viewModel: ViewModel
    let arView = ARView(frame: .zero)
    @Binding var pregunta : Bool
//    @Binding var postProcessController: EntityPostProcessController?
    var ciContext : CIContext?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

        
        // Crear techo de estrellas
        if let url = Bundle.main.url(forResource: "nubes-9825", withExtension: "mp4") {
            
            // Create an AVPlayer instance to control playback of that movie.
            let player = AVPlayer(url: url)
            let queuePlayer = AVQueuePlayer(url: url)
            
            
            // Instantiate and configure the video material.
            let material = VideoMaterial(avPlayer: player)
            let queueMat = VideoMaterial(avPlayer: queuePlayer)
            
            
            // Configure audio playback mode.
            material.controller.audioInputMode = .spatial
            queueMat.controller.audioInputMode = .spatial
            
            // Create a new model entity using the video material.
            let plane2 = MeshResource.generatePlane(width: 1000.0, height: 1000)
            let modelEntity2 = ModelEntity(mesh: plane2, materials: [queueMat])
            modelEntity2.position = [0, 100, 0]
            modelEntity2.orientation = simd_quatf(angle: .pi/2, axis: [1, 0, 0])
            
            let plane = MeshResource.generatePlane(width: 1000.0, height: 1000)
            let modelEntity = ModelEntity(mesh: plane, materials: [material])
            modelEntity.position = [0, 100, 0]
            modelEntity.orientation = simd_quatf(angle: .pi/2, axis: [1, 0, 0])
            player.play()
            
            let anchor = AnchorEntity()
            anchor.addChild(modelEntity2)
            arView.scene.anchors.append(anchor)
        }
        
        
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target:context.coordinator,action: #selector(Coordinator.handleTap(_:))))
        return arView
    }
    
    

    func postProcess(context: ARView.PostProcessContext){
        let sourceColor = CIImage(mtlTexture: context.sourceColorTexture)!
        
        let thermal = CIFilter.thermal()
        thermal.inputImage = sourceColor
        
        let destiniation = CIRenderDestination(mtlTexture: context.targetColorTexture, commandBuffer: context.commandBuffer)
        
        destiniation.isFlipped = true
        
        _ = try? self.ciContext?.startTask(toRender: thermal.outputImage!, to: destiniation)
    }
    func updateUIView(_ uiView: ARView, context: Context) {
        
            
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        
        let parent: ARViewContainer
        
        init(_ parent: ARViewContainer) {
            self.parent = parent
        }
        
        func makeRandom(){
            
        }
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            let location = sender.location(in:parent.arView)
            //            print("loacion: ", location)
            let tapResults = parent.arView.hitTest(location)
            //            print(tapResults)
            for tapResult in tapResults {
                
                if let cubeModel = tapResult.entity as? ModelEntity {
                    // Hacer algo con el cubo tocado
                    //                      print("Cubo tocado: \(cubeModel.children)")
                    
                    parent.pregunta = true
                }
            }
            print("cha cha chau")
        }
    }
    
    
}


