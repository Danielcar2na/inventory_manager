class Seller {
  Seller({
    required this.bodega,
    required this.nombre,
    required this.consecutivo,
    required this.codigo,
    required this.moneda,
    required this.tipo,
    required this.empresa,
    required this.fechaLabores,
    required this.fechaConsecutivo,
    required this.portafolio,
    required this.distrito,
  });

  String bodega;
  String nombre;
  int consecutivo;
  String codigo;
  String moneda;
  int tipo;
  String empresa;
  String fechaLabores;
  String fechaConsecutivo;
  String portafolio;
  String distrito;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        bodega: json["bodega"],
        nombre: json["nombre"],
        consecutivo: json["consecutivo"],
        codigo: json["codigo"],
        moneda: json["moneda"],
        tipo: json["tipo"],
        empresa: json["empresa"],
        fechaLabores: json["fechaLabores"],
        fechaConsecutivo: json["fechaConsecutivo"],
        portafolio: json["portafolio"],
        distrito: json["distrito"],
      );

  Map<String, dynamic> toJson() => {
        "bodega": bodega,
        "nombre": nombre,
        "consecutivo": consecutivo,
        "codigo": codigo,
        "moneda": moneda,
        "tipo": tipo,
        "empresa": empresa,
        "fechaLabores": fechaLabores,
        "fechaConsecutivo": fechaConsecutivo,
        "portafolio": portafolio,
        "distrito": distrito,
      };
}
