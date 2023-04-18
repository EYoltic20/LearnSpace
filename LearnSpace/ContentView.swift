//
//  ContentView.swift
//  LearnSpace
//
//  Created by Emilio Y Martinez on 15/04/23.
//

import SwiftUI
import RealityKit
import ARKit
import AVKit

struct ContentView : View {
    @State var nivel = "home"
    //    @State private var ispregunta: Bool = false
    @State var preguntaNum = 0
    @State var score = 0
    //    @State var postProcessController: EntityPostProcessController?
    //    @StateObject var viewModel = ViewModel()
    var preguntasTierr = [
        PreguntasModel(id: 0, pregunta: "¿Si Juan tiene 15 manzanas y se come 6, cuantas manzanas le quedan?", respuesta: "9", opciones: ["7","6","8","9"]),
        PreguntasModel(id: 1, pregunta: "Si en una carrera vas tres puestos por detrás del vigésimo segundo, ¿en qué puesto vas?", respuesta: "19", opciones: ["19","20","21","22"]),
        PreguntasModel(id: 2, pregunta: "¿Qué planeta es el más cercano al Sol?", respuesta: "Mercurio", opciones: ["Marte","Mercurio","Jupiter","La Luna"]),
        PreguntasModel(id: 3, pregunta: "¿Quién fue el primer hombre en pisar la Luna?", respuesta: "Neil Armstrong", opciones: ["Neil Armstrong","Juan Escutia","Alan Galvan","Isaac Newton"])
    ]
    var body: some View {
        NavigationView{
            switch nivel{
            case "home":
                HomeView(nivel: $nivel)
            case "Tierra":
                GeometryReader{geo in
                    
                    VStack(alignment:.leading){
                        HStack{
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
                            Spacer()
                            Text("Puntaje:\(score)/\(preguntasTierr.count)")
                                .foregroundColor(.white)
                                .bold()
                                .font(.title)
                        }
                        
                        ARViewContainer( preguntaNum: $preguntaNum,nivel: $nivel)
                            .edgesIgnoringSafeArea(.all)
                        
                        //
                        
                    }
                    .frame(width:geo.size.width,height:geo.size.height)
                    
                    //                    .sheet(isPresented:$ispregunta){
                    //
                    //                        let pm = preguntasTierr[preguntaNum]
                    //                        PreguntaView(pregunta: pm.pregunta, respuesta: pm.respuesta, opciones: pm.opciones,score: $score,ispregunta:$ispregunta)
                    //                        //
                    //                    }
                }
            case "pregunta":
                PreguntaView(nivel:$nivel,pregunta: preguntasTierr[preguntaNum].pregunta, respuesta: preguntasTierr[preguntaNum].respuesta, opciones: preguntasTierr[preguntaNum].opciones,score: $score)
            default:
                HomeView(nivel: $nivel)
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    let arView = ARView(frame: .zero)
    //    @Binding var pregunta : Bool
    @Binding var preguntaNum: Int
    @Binding var nivel:String
    
    
    func makeUIView(context: Context) -> ARView {
        
        
        
        
        let config=ARWorldTrackingConfiguration()
        let anchor = AnchorEntity()
        config.planeDetection=[.horizontal,.vertical]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            config.sceneReconstruction = .mesh
        }
        
        arView.session.run(config)
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
            
            anchor.addChild(modelEntity2)
            
        }
        
        let names = ["tree3", "palm3"]
        //                Agregando arboles
        //        let models:[String] = {
        //            let filemanager = FileManager.default
        //            guard let path = Bundle.main.resourcePath, let file = try? filemanager.contentsOfDirectory(atPath: path) else{
        //                return []
        //            }
        //            var availableModels : [String] = []
        //            for filesname in file where filesname.hasSuffix(".usd"){
        //                let modelname = filesname.replacingOccurrences(of: ".usd", with: "")
        //                availableModels.append(modelname)
        //            }
        //            return availableModels
        //        }()
        
        
        let numEntities = 20
        for _ in 0..<numEntities {
            guard let modelEntity = try? ModelEntity.load(named: "\(names.randomElement()!).usd") else {
                continue
            }

            let randomX = Float.random(in: -20.0...20.0)
            let randomZ = Float.random(in: -20.0...20.0)
            modelEntity.position = [randomX, -5, randomZ]


            anchor.addChild(modelEntity)
            arView.scene.addAnchor(anchor)
        }

        for i in 0..<4{
            let mesh = MeshResource.generateBox(width: 2, height: 2, depth: 2)
            
            let meshMaterial = [SimpleMaterial(color: .red, isMetallic: true)]
            
            let box = ModelEntity(mesh: mesh,materials: meshMaterial)
            let boxShape = ShapeResource.generateBox(size: [2, 2, 2])
            let colission = CollisionComponent(shapes: [boxShape])
            let randomX = Float.random(in: -20.0...20.0)
            let randomZ = Float.random(in: -20.0...20.0)
            box.position = [randomX, -5, randomZ]
            box.components.set(colission)
            box.name = String("Libro"+String(i))
            let anchor = AnchorEntity()
            anchor.addChild(box)
            arView.scene.anchors.append(anchor)
            
        }
        
        arView.scene.anchors.append(anchor)
        arView.addGestureRecognizer(UITapGestureRecognizer(target:context.coordinator,action: #selector(Coordinator.handleTap(_:))))
        
        return arView
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
                    if (cubeModel.name == "Libro0"){
                        parent.preguntaNum = 0
                        parent.nivel = "pregunta"
                    }
                    if (cubeModel.name == "Libro1"){
                        parent.preguntaNum = 1
                        parent.nivel = "pregunta"
                    }
                    if (cubeModel.name == "Libro2"){
                        parent.preguntaNum = 2
                        parent.nivel = "pregunta"
                    }
                    if (cubeModel.name == "Libro3"){
                        parent.preguntaNum = 3
                        parent.nivel = "pregunta"
                    }
                    
                }
            }
            print("cha cha chau")
        }
    }
    
    
}


