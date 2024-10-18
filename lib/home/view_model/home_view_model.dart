import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/sqlite.dart';
import 'package:flutter_application_1/home/model/client.dart';
import 'package:flutter_application_1/home/view/home.dart';
import 'package:flutter_application_1/login/model/seller.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
 
class HomeViewModel extends GetxController {
  Seller seller;
  ScrollController scrollController = ScrollController();
  HomeViewModel({required this.seller}) {
    Get.to(() => HomeScreen());
  }
  RxList<Client> clientList = RxList();
  @override
  void onInit() {
    getClients();
    super.onInit();
  }

  void getClients() async {
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();
    Client? client;

    String statement =
        '''SELECT codigoAmarre,cupo3,sustituto,Cupo, Ruta5, ciudad2,GrupoPrecios,FechaIngreso,Apellidos,Vendedor2,
        Subcanal,Ordencompra,vendedor5,tipoCredito,cupo4,rutero,celular,tipoCliente,codigo,enlace1,codPadre,factor,
        ruta6,enlace4,latitud,fax,zonaTransporte,canal,Cupo_disponible,cupo5,zonaventas,ruta1,clasifcli,razonsocial,
        vendedor1,clienteSuizo,linea,potencial,vendedor4,totalcore,ciudad,ruta2,enlace3,agencia,unidadMedida,neocli,
        condicionpago,email,direccion,perIca,cupo1,atributo5,telefono2,telefono,Tarjeta_registro,clienteCunit,tipoDoc,
        ruta3,enlace,territorio,digitoVer,cupoc,bloqueado,vendedor,clienteZenu,nombre,vendedor3,longitud,plazo,valor,
        cupo2,vendedor6,tipimp,factor2,ruta4,enlace2,cumpleanos,Actividad_economica,dirEntrega,retencion,enlace5,ica,
        actividad,barrio,tiporegimen,nombres,necesidad,Ruta_parada FROM clientes''';

    try {
      List<Map> result = await db.rawQuery(statement);
      if (result.isNotEmpty) {
        for (var item in result) {
          client = Client(
            codigoAmarre: item["CodigoAmarre"],
            cupo3: item["Cupo3"],
            sustituto: item["Sustituto"],
            cupo: item["Cupo"],
            ruta5: item["Ruta5"],
            ciudad2: item["ciudad2"],
            grupoPrecios: item["GrupoPrecios"],
            fechaIngreso: item["FechaIngreso"],
            apellidos: item["Apellidos"],
            vendedor2: item["Vendedor2"],
            subcanal: item["Subcanal"],
            ordencompra: item["Ordencompra"],
            vendedor5: item["Vendedor5"],
            tipoCredito: item["TipoCredito"],
            cupo4: item["Cupo4"],
            rutero: item["rutero"],
            celular: item["celular"],
            tipoCliente: item["TipoCliente"],
            codigo: item["Codigo"],
            enlace1: item["enlace1"],
            codPadre: item["CodPadre"],
            factor: item["Factor"],
            ruta6: item["Ruta6"],
            enlace4: item["enlace4"],
            latitud: item["latitud"],
            fax: item["fax"],
            zonaTransporte: item["ZonaTransporte"],
            canal: item["Canal"],
            cupoDisponible: item["Cupo_disponible"],
            cupo5: item["Cupo5"],
            zonaventas: item["Zonaventas"],
            ruta1: item["Ruta1"],
            clasifcli: item["clasifcli"],
            razonsocial: item["Razonsocial"],
            vendedor1: item["Vendedor1"],
            clienteSuizo: item["ClienteSuizo"],
            linea: item["Linea"],
            potencial: item["Potencial"],
            vendedor4: item["Vendedor4"],
            totalcore: item["totalcore"],
            ciudad: item["Ciudad"],
            ruta2: item["Ruta2"],
            enlace3: item["enlace3"],
            agencia: item["Agencia"],
            unidadMedida: item["UnidadMedida"],
            neocli: item["neocli"],
            condicionpago: item["condicionpago"],
            email: item["email"],
            direccion: item["Direccion"],
            perIca: item["PerIca"],
            cupo1: item["Cupo1"],
            atributo5: item["atributo5"],
            telefono2: item["Telefono2"],
            telefono: item["Telefono"],
            tarjetaRegistro: item["Tarjeta_registro"],
            clienteCunit: item["ClienteCunit"],
            tipoDoc: item["TipoDoc"],
            ruta3: item["Ruta3"],
            enlace: item["enlace"],
            territorio: item["Territorio"],
            digitoVer: item["DigitoVer"],
            cupoc: item["CUPOC"],
            bloqueado: item["Bloqueado"],
            vendedor: item["Vendedor"],
            clienteZenu: item["ClienteZenu"],
            nombre: item["Nombre"],
            vendedor3: item["Vendedor3"],
            longitud: item["longitud"],
            nit: item["Nit"],
            plazo: item["Plazo"],
            valor: item["Valor"],
            cupo2: item["Cupo2"],
            vendedor6: item["Vendedor6"],
            tipimp: item["tipimp"],
            factor2: item["factor2"],
            ruta4: item["Ruta4"],
            enlace2: item["enlace2"],
            cumpleanos: item["Cumpleanos"],
            actividadEconomica: item["Actividad_economica"],
            dirEntrega: item["DirEntrega"],
            retencion: item["Retencion"],
            enlace5: item["enlace5"],
            ica: item["ICA"],
            actividad: item["Actividad"],
            barrio: item["Barrio"],
            tiporegimen: item["tiporegimen"],
            nombres: item["Nombres"],
            necesidad: item["Necesidad"],
            rutaParada: item["Ruta_parada"],
          );
          clientList.add(client);
        }
        // Get.put(HomeViewModel(client: client!));
      }
    } catch (e) {
      Get.snackbar("Error", 'El usuario no existe',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
    }
  }
}
