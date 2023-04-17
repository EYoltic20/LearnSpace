//
//  HomeView.swift
//  LearnSpace
//
//  Created by Emilio Y Martinez on 15/04/23.
//

import SwiftUI

struct HomeView: View {
    @Binding var nivel : String
    @State var isActive = true
    var planetas : [PlanetaModel] = [
        PlanetaModel(nombre: "Tierra", color: .cyan, image: "planeta-tierra",dificultad: 1),
        PlanetaModel(nombre: "Marte", color: .red, image: "marte",dificultad: 3)
    ]
    @State var op = 0.0
    var body: some View {
        GeometryReader{geo in
            VStack{
                
                
                //                MARK: -SPLASHSCREEN
                if isActive {
                    VStack{
                        Text("LearnSpace")
                        
                            .font(Font.custom("gemu", size: 60))
                            .foregroundColor(.white.opacity(op))
                            .bold()
                            .padding(.bottom,160)
                            .onAppear{
                                withAnimation(.easeOut(duration: 4)){
                                    op  = op + 1
                                }
                            }
                        
                        
                        animacion(url: "https://assets4.lottiefiles.com/packages/lf20_hvlfn70n.json")
                            .frame(width: geo.size.width-100,height: geo.size.height/3)
                        
                    }.frame(width: geo.size.width,height: geo.size.height)
                        .background{
                            Color.black.ignoresSafeArea()
                        }
                    
                }
                //                MARK: -HOMEVIEW
                else{
                    VStack(alignment:.leading){
                        Text("Exploremos El Universo")
                            .font(Font.custom("gemu", size: 40))
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                        
                        ScrollView{
                            ForEach(planetas,id:\.id){ planeta in
                                NavigationLink(destination:PlanetInfoView(planeta: planeta.nombre, image: planeta.image, texto: getPlanetDescription(planeta.nombre), dificultad: planeta.dificultad,color:planeta.color,nivel:$nivel)){
                                    CardPlanetView(color: planeta.color, Planeta: planeta.nombre, image: planeta.image)
                                        .frame(width:geo.size.width-30,height: geo.size.height/4)
                                        .padding(.top,10)
                                }
                                
                            }
                        }.padding(.trailing,20)
                    }
                    .frame(width:geo.size.width,height: geo.size.height)
                    .padding()
                    .background{
                        Image("space")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                    }
                }
            }
            .frame(width: geo.size.width,height: geo.size.height)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+4.0){
                    isActive = false
                }
            }
            
        }
    }
    
    func getPlanetDescription(_ planet : String)-> String{
        switch planet {
        case "Tierra":
            return "Claro, la Tierra es un planeta rocoso ubicado en la zona habitable del sistema solar, lo que significa que tiene las condiciones adecuadas para la existencia de vida tal como la conocemos. Su atmósfera está compuesta principalmente de nitrógeno y oxígeno, y es responsable de la regulación de la temperatura y la protección de la vida en la superficie de las radiaciones nocivas del espacio"
        case "Marte":
            return "Marte es el cuarto planeta del sistema solar y se encuentra a una distancia media de aproximadamente 228 millones de kilómetros del Sol. Es un planeta rocoso con una atmósfera delgada compuesta principalmente de dióxido de carbono. Tiene un diámetro de aproximadamente 6,779 kilómetros y una masa de 6.39 x 10^23 kilogramos, alrededor de la mitad del tamaño y la masa de la Tierra. Marte tiene dos lunas naturales, Fobos y Deimos. Al igual que la Tierra, Marte también tiene estaciones, pero debido a que su órbita es más alargada que la de la Tierra, sus estaciones son más extremas. La superficie de Marte está cubierta de montañas, cañones, llanuras y cráteres, y cuenta con la montaña más alta conocida en el sistema solar, Olympus Mons. También hay evidencia de que el planeta tuvo agua en algún momento en su historia, lo que ha llevado a la especulación de que puede haber vida en el planeta en el pasado o presente."
        default:
            return ""
        }
    }
}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(nivel: <#Binding<String>#>)
//    }
//}
