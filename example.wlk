class Nave {
 var velocidad=0
 var direccionAlSol=0
 var combustible=0

 method estaDeRelajo() { return
  self.estaTranquila() && tienePocaActividad()
 } 
 method tienePocaActividad() 

 method estaTranquila() {
 return  
 combustible>=4000 && velocidad <= 12000
 self.condicionAdicional()
 } 

 method condicionAdicional

 method cargarCombustible(cuanto) {
   combustible+=cuanto
 }

 method descargarCombustible(cuanto) {
   combustible=0.max()(combustible-cuanto)
 }
 method acelerar(cuanto) {
   velocidad= (velocidad+cuanto).min(100000)
 }
 method desacelerar(cuanto) {
  velocidad= (velocidad-cuanto) .max(0)
 }
 method irHaciaElSol() {
 direccionAlSol=10   
 }

method escaparDelSol() {
  direccionAlSol=-10
}
method ponerseParaleloAlSol() {
  direccionAlSol=0
}
method acercarseUnPocoAlSol() {
  direccionAlSol=(direccionAlSol+1).min(10)
}
method alejarseUnPocoAlSol() {
  direccionAlSol=(direccionAlSol-1).max(-10)
  }

  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
    self.accionAdicional()
  }
  method accionAdicional
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }

  method escapar()
  method avisar()
}

class NaveBaliza inherits Nave{
var colorBaliza
var cambioBaliza=false 
method cambiarColorBaliza(colorNuevo) {
  colorBaliza=colorNuevo
  cambioBaliza=true }

 override method accionAdicional() {
  self.cambiarColorBaliza("verde")
  self.ponerseParaleloAlSol()
  self.acelerar(15000)
 } 
 override method condicionAdicional() {
  return colorBaliza!="rojo"
 }  
 override method escapar() {
 self.irHaciaElSol()   
 }
 override method avisar() {
  self.cambiarColorBaliza("rojo")
 }
 override method tienePocaActividad()= not cambioBaliza
}

class NavePasajeros inherits Nave {
  const pasajeros
  var comida=0
  var bebida=0
  var cantidadComida=0

  method cargar(cantBebida,cantComida) {
    comida= comida + cantComida
    bebida=bebida + cantBebida
    cantidadComida +=cantComida
  }

  method descargar(cantBebida,cantComida) {
    comida= (comida - cantComida).max(0)
    bebida=(bebida - cantBebida).max(0) 
    
  }

  override method accionAdicional() {
    
  self.cargar(6*pasajeros, 4*pasajeros)
  self.acercarseUnPocoAlSol()
  self.acelerar(15000)
 }  

 override method condicionAdicional() {
  return true
  
  }

   override method escapar() {
 self.acelerar(velocidad)   
 }
 override method avisar() {
  self.descargar(pasajeros*2, pasajeros*1)
 }
 override method tienePocaActividad(){
cantidadComida < 50
 }
}

class NaveCombate inherits Nave {  
  var invisible=true
  var misilesDesplegados=false
  const mensajes =[]

  method ponerseVisible() {
   invisible=false
  }
  method ponerseInvisible() {
    invisible=true
  }
  method estaInvisible() { return invisible}
  method desplegarMisibles() {
    misilesDesplegados=true
  }
  method replegarMisibles() {
    misilesDesplegados=false
  }
  
method misilesDesplegados() = misilesDesplegados 
method emitirMensaje(mensaje) {
  mensaje.add(mensaje)
}
method mensajeEmitidos() = mensajes
method cantMensajesEmitidos() = mensajes.size()
method primerMensajeEmitido() {
  if(mensajes.isEmpty()){
    self.error("Aun no hay mensajes emitidos")
  }
  return mensajes.first()
}   

method ultimoMensajeEmitido() {
  if(mensajes.isEmpty()){
    self.error("Aun no hay mensajes emitidos")
  }
  return mensajes.last()
}

method esEscueta() {
  return mensajes.all({m=>m.length()<30})
} 

method emitioMensaje(mensaje) {
  return mensajes.contains(mensaje)
}
  override method accionAdicional() {
  
  self.ponerseVisible()
  self.replegarMisibles()
  self.acelerar(15000)
  self.emitirMensaje("Saliendo en Mision")
 
 }  
override method condicionAdicional() {
  return 
  !misilesDesplegados
}

 override method escapar() {
 self.acercarseUnPocoAlSol()
 self.acercarseUnPocoAlSol()   
 }
 override method avisar() {
  self.emitirMensaje("Amenaza recibida")
 }
 override method tienePocaActividad()=true
}

class NaveHospital inherits NavePasajeros{
  var quirofanosPreparados=false

  override  method condicionAdicional() {
    return  not quirofanosPreparados }

    method prepararQuirofanos() {
      quirofanosPreparados=true
    }

    override method recibirAmenaza() {
      super()
      self.prepararQuirofanos()    
    }

}

class NaveSigilosa inherits NaveCombate {
 
 override method condicionAdicional() {
  return
  super() && not self.estaInvisible()
 } 

 override method escapar() {
   super()
   self.desplegarMisibles()
   self.ponerseInvisible()
 }


}