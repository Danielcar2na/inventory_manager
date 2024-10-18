import 'dart:ffi';

class Client {
  Client({
    this.codigoAmarre,
    this.cupo3,
    this.sustituto,
    this.cupo,
    this.ruta5,
    this.ciudad2,
    this.grupoPrecios,
    this.fechaIngreso,
    this.apellidos,
    this.vendedor2,
    this.subcanal,
    this.ordencompra,
    this.vendedor5,
    this.tipoCredito,
    this.cupo4,
    this.rutero,
    this.celular,
    this.tipoCliente,
    this.codigo,
    this.enlace1,
    this.codPadre,
    this.factor,
    this.ruta6,
    this.enlace4,
    this.latitud,
    this.fax,
    this.zonaTransporte,
    this.canal,
    this.cupoDisponible,
    this.cupo5,
    this.zonaventas,
    this.ruta1,
    this.clasifcli,
    this.razonsocial,
    this.vendedor1,
    this.clienteSuizo,
    this.linea,
    this.potencial,
    this.vendedor4,
    this.totalcore,
    this.ciudad,
    this.ruta2,
    this.enlace3,
    this.agencia,
    this.unidadMedida,
    this.neocli,
    this.condicionpago,
    this.email,
    this.direccion,
    this.perIca,
    this.cupo1,
    this.atributo5,
    this.telefono2,
    this.telefono,
    this.tarjetaRegistro,
    this.clienteCunit,
    this.tipoDoc,
    this.ruta3,
    this.enlace,
    this.territorio,
    this.digitoVer,
    this.cupoc,
    this.bloqueado,
    this.vendedor,
    this.clienteZenu,
    this.nombre,
    this.vendedor3,
    this.longitud,
    this.nit,
    this.plazo,
    this.valor,
    this.cupo2,
    this.vendedor6,
    this.tipimp,
    this.factor2,
    this.ruta4,
    this.enlace2,
    this.cumpleanos,
    this.actividadEconomica,
    this.dirEntrega,
    this.retencion,
    this.enlace5,
    this.ica,
    this.actividad,
    this.barrio,
    this.tiporegimen,
    this.nombres,
    this.necesidad,
    this.rutaParada,
  });

  String? codigoAmarre;
  dynamic? cupo3;
  dynamic? sustituto;
  double? cupo;
  String? ruta5;
  String? ciudad2;
  String? grupoPrecios;
  dynamic? fechaIngreso;
  String? apellidos;
  String? vendedor2;
  String? subcanal;
  dynamic? ordencompra;
  String? vendedor5;
  dynamic? tipoCredito;
  dynamic? cupo4;
  String? rutero;
  String? celular;
  dynamic? tipoCliente;
  String? codigo;
  String? enlace1;
  String? codPadre;
  String? factor;
  String? ruta6;
  String? enlace4;
  double? latitud;
  dynamic? fax;
  String? zonaTransporte;
  String? canal;
  double? cupoDisponible;
  dynamic? cupo5;
  String? zonaventas;
  String? ruta1;
  dynamic? clasifcli;
  String? razonsocial;
  String? vendedor1;
  dynamic? clienteSuizo;
  String? linea;
  String? potencial;
  String? vendedor4;
  dynamic? totalcore;
  String? ciudad;
  String? ruta2;
  String? enlace3;
  String? agencia;
  dynamic? unidadMedida;
  dynamic? neocli;
  String? condicionpago;
  String? email;
  String? direccion;
  dynamic? perIca;
  dynamic? cupo1;
  String? atributo5;
  String? telefono2;
  String? telefono;
  dynamic? tarjetaRegistro;
  dynamic? clienteCunit;
  String? tipoDoc;
  String? ruta3;
  String? enlace;
  String? territorio;
  dynamic? digitoVer;
  dynamic? cupoc;
  String? bloqueado;
  dynamic? vendedor;
  dynamic? clienteZenu;
  String? nombre;
  String? vendedor3;
  double? longitud;
  String? nit;
  dynamic? plazo;
  String? valor;
  dynamic? cupo2;
  String? vendedor6;
  dynamic? tipimp;
  String? factor2;
  String? ruta4;
  String? enlace2;
  dynamic? cumpleanos;
  dynamic? actividadEconomica;
  dynamic? dirEntrega;
  dynamic? retencion;
  String? enlace5;
  String? ica;
  String? actividad;
  String? barrio;
  dynamic? tiporegimen;
  String? nombres;
  String? necesidad;
  dynamic? rutaParada;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        codigoAmarre: json["CodigoAmarre"],
        cupo3: json["Cupo3"],
        sustituto: json["Sustituto"],
        cupo: json["Cupo"],
        ruta5: json["Ruta5"],
        ciudad2: json["ciudad2"],
        grupoPrecios: json["GrupoPrecios"],
        fechaIngreso: json["FechaIngreso"],
        apellidos: json["Apellidos"],
        vendedor2: json["Vendedor2"],
        subcanal: json["Subcanal"],
        ordencompra: json["Ordencompra"],
        vendedor5: json["Vendedor5"],
        tipoCredito: json["TipoCredito"],
        cupo4: json["Cupo4"],
        rutero: json["rutero"],
        celular: json["celular"],
        tipoCliente: json["TipoCliente"],
        codigo: json["Codigo"],
        enlace1: json["enlace1"],
        codPadre: json["CodPadre"],
        factor: json["Factor"],
        ruta6: json["Ruta6"],
        enlace4: json["enlace4"],
        latitud: json["latitud"].toDouble(),
        fax: json["fax"],
        zonaTransporte: json["ZonaTransporte"],
        canal: json["Canal"],
        cupoDisponible: json["Cupo_disponible"].toDouble(),
        cupo5: json["Cupo5"],
        zonaventas: json["Zonaventas"],
        ruta1: json["Ruta1"],
        clasifcli: json["clasifcli"],
        razonsocial: json["Razonsocial"],
        vendedor1: json["Vendedor1"],
        clienteSuizo: json["ClienteSuizo"],
        linea: json["Linea"],
        potencial: json["Potencial"],
        vendedor4: json["Vendedor4"],
        totalcore: json["totalcore"],
        ciudad: json["Ciudad"],
        ruta2: json["Ruta2"],
        enlace3: json["enlace3"],
        agencia: json["Agencia"],
        unidadMedida: json["UnidadMedida"],
        neocli: json["neocli"],
        condicionpago: json["condicionpago"],
        email: json["email"],
        direccion: json["Direccion"],
        perIca: json["PerIca"],
        cupo1: json["Cupo1"],
        atributo5: json["atributo5"],
        telefono2: json["Telefono2"],
        telefono: json["Telefono"],
        tarjetaRegistro: json["Tarjeta_registro"],
        clienteCunit: json["ClienteCunit"],
        tipoDoc: json["TipoDoc"],
        ruta3: json["Ruta3"],
        enlace: json["enlace"],
        territorio: json["Territorio"],
        digitoVer: json["DigitoVer"],
        cupoc: json["CUPOC"],
        bloqueado: json["Bloqueado"],
        vendedor: json["Vendedor"],
        clienteZenu: json["ClienteZenu"],
        nombre: json["Nombre"],
        vendedor3: json["Vendedor3"],
        longitud: json["longitud"].toDouble(),
        nit: json["Nit"],
        plazo: json["Plazo"],
        valor: json["Valor"],
        cupo2: json["Cupo2"],
        vendedor6: json["Vendedor6"],
        tipimp: json["tipimp"],
        factor2: json["factor2"],
        ruta4: json["Ruta4"],
        enlace2: json["enlace2"],
        cumpleanos: json["Cumpleanos"],
        actividadEconomica: json["Actividad_economica"],
        dirEntrega: json["DirEntrega"],
        retencion: json["Retencion"],
        enlace5: json["enlace5"],
        ica: json["ICA"],
        actividad: json["Actividad"],
        barrio: json["Barrio"],
        tiporegimen: json["tiporegimen"],
        nombres: json["Nombres"],
        necesidad: json["Necesidad"],
        rutaParada: json["Ruta_parada"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoAmarre": codigoAmarre,
        "Cupo3": cupo3,
        "Sustituto": sustituto,
        "Cupo": cupo,
        "Ruta5": ruta5,
        "ciudad2": ciudad2,
        "GrupoPrecios": grupoPrecios,
        "FechaIngreso": fechaIngreso,
        "Apellidos": apellidos,
        "Vendedor2": vendedor2,
        "Subcanal": subcanal,
        "Ordencompra": ordencompra,
        "Vendedor5": vendedor5,
        "TipoCredito": tipoCredito,
        "Cupo4": cupo4,
        "rutero": rutero,
        "celular": celular,
        "TipoCliente": tipoCliente,
        "Codigo": codigo,
        "enlace1": enlace1,
        "CodPadre": codPadre,
        "Factor": factor,
        "Ruta6": ruta6,
        "enlace4": enlace4,
        "latitud": latitud,
        "fax": fax,
        "ZonaTransporte": zonaTransporte,
        "Canal": canal,
        "Cupo_disponible": cupoDisponible,
        "Cupo5": cupo5,
        "Zonaventas": zonaventas,
        "Ruta1": ruta1,
        "clasifcli": clasifcli,
        "Razonsocial": razonsocial,
        "Vendedor1": vendedor1,
        "ClienteSuizo": clienteSuizo,
        "Linea": linea,
        "Potencial": potencial,
        "Vendedor4": vendedor4,
        "totalcore": totalcore,
        "Ciudad": ciudad,
        "Ruta2": ruta2,
        "enlace3": enlace3,
        "Agencia": agencia,
        "UnidadMedida": unidadMedida,
        "neocli": neocli,
        "condicionpago": condicionpago,
        "email": email,
        "Direccion": direccion,
        "PerIca": perIca,
        "Cupo1": cupo1,
        "atributo5": atributo5,
        "Telefono2": telefono2,
        "Telefono": telefono,
        "Tarjeta_registro": tarjetaRegistro,
        "ClienteCunit": clienteCunit,
        "TipoDoc": tipoDoc,
        "Ruta3": ruta3,
        "enlace": enlace,
        "Territorio": territorio,
        "DigitoVer": digitoVer,
        "CUPOC": cupoc,
        "Bloqueado": bloqueado,
        "Vendedor": vendedor,
        "ClienteZenu": clienteZenu,
        "Nombre": nombre,
        "Vendedor3": vendedor3,
        "longitud": longitud,
        "Nit": nit,
        "Plazo": plazo,
        "Valor": valor,
        "Cupo2": cupo2,
        "Vendedor6": vendedor6,
        "tipimp": tipimp,
        "factor2": factor2,
        "Ruta4": ruta4,
        "enlace2": enlace2,
        "Cumpleanos": cumpleanos,
        "Actividad_economica": actividadEconomica,
        "DirEntrega": dirEntrega,
        "Retencion": retencion,
        "enlace5": enlace5,
        "ICA": ica,
        "Actividad": actividad,
        "Barrio": barrio,
        "tiporegimen": tiporegimen,
        "Nombres": nombres,
        "Necesidad": necesidad,
        "Ruta_parada": rutaParada,
      };
}
