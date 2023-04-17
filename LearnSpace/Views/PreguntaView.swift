//
//  PreguntaView.swift
//  LearnSpace
//
//  Created by Emilio Y Martinez on 17/04/23.
//

import SwiftUI

struct PreguntaView: View {
    @Binding var nivel : String
    var pregunta : String
    var respuesta: String
    var opciones : [String]
    @Binding var score : Int
    @State var alumnoRespuesta = ""
    @State var isCorrect = false
    @Environment(\.dismiss) var dismiss
    @State var buttonState = 0
    
    var body: some View {
        GeometryReader{ geo in
            VStack{
                Text(pregunta)
                    .font(.system(size:30))
                    .foregroundColor(.white)
                    .padding(.top,100)
                
                Spacer()
                
                VStack{
                    HStack{
                        Button{
                            if(comprobarRespuesta(alumnRespuesta: opciones[0], respuesta: respuesta)){
                                buttonState = 1
                                score += 1
                                DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                                    nivel = "Tierra"
                                }
                            }
                        }label: {
                            RoundedRectangle(cornerRadius: 10)
                                .fill((buttonState == 1) ? .green : .white)
                                .overlay{
                                    Text(opciones[0])
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .bold()
                                    
                                }
                        }
                        Button{
                            if(comprobarRespuesta(alumnRespuesta: opciones[1], respuesta: respuesta)){
                                buttonState = 2
                                score += 1
                                DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                                    nivel = "Tierra"
                                }
                                
                                
                            }
                            
                        }label: {
                            RoundedRectangle(cornerRadius: 10)
                                .fill((buttonState == 2) ? .green : .white)
                                .overlay{
                                    Text(opciones[1])
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .bold()
                                }
                            
                        }
                    }
                    HStack{
                        Button{
                            if(comprobarRespuesta(alumnRespuesta: opciones[2], respuesta: respuesta)){
                                buttonState = 3
                                score += 1
                                DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                                    nivel = "Tierra"
                                }
                            }
                            
                        }label: {
                            RoundedRectangle(cornerRadius: 10)
                                .fill((buttonState == 3) ? .green : .white)
                                .overlay{
                                    Text(opciones[2])
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .bold()
                                }
                            
                        }
                        Button{
                            if(comprobarRespuesta(alumnRespuesta: opciones[3], respuesta: respuesta)){
                                buttonState = 4
                                score += 1
                                DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                                    nivel = "Tierra"
                                }
                            }
                        }label: {
                            RoundedRectangle(cornerRadius: 10)
                                .fill((buttonState == 4) ? .green : .white)
                                .overlay{
                                    Text(opciones[3])
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .bold()
                                }
                            
                        }
                        
                    }
                }
                .frame(width:geo.size.width,height: geo.size.height/3)
                
                
            }
            .frame(width:geo.size.width,height: geo.size.height)
            .background{
                Color.black.ignoresSafeArea()
            }
        }
    }
    func comprobarRespuesta(alumnRespuesta:String,respuesta:String)-> Bool{
        if (alumnRespuesta == respuesta){
            return true
        }
        return false
    }
    

    
}
//
//struct PreguntaView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreguntaView(pregunta: "Te gusta la kk", respuesta: "no", opciones: ["si","np","no","chance"],score: 0)
//    }
//}
