// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    String agrupacion;
    String archivo;
    String bodega;
    String categoria;
    String cenExt2;
    dynamic clave;
    String codigo;
    dynamic core;
    String ean;
    String gm4;
    String grupo;
    String itf;
    int iva;
    String linea;
    String lineaproduccion;
    String marca;
    String nombre;
    String pagaPastilla;
    double peso;
    String portafolio;
    double precio;
    int saldo;
    String sector;
    String subcategoria;
    String sublinea;
    String unidades;
    String unidadesxcaja;
    String unidadmedida;
    String vendedor;
    String marcadd;
    DateTime createAt;

    Product({
        required this.agrupacion,
        required this.archivo,
        required this.bodega,
        required this.categoria,
        required this.cenExt2,
        required this.clave,
        required this.codigo,
        required this.core,
        required this.ean,
        required this.gm4,
        required this.grupo,
        required this.itf,
        required this.iva,
        required this.linea,
        required this.lineaproduccion,
        required this.marca,
        required this.nombre,
        required this.pagaPastilla,
        required this.peso,
        required this.portafolio,
        required this.precio,
        required this.saldo,
        required this.sector,
        required this.subcategoria,
        required this.sublinea,
        required this.unidades,
        required this.unidadesxcaja,
        required this.unidadmedida,
        required this.vendedor,
        required this.marcadd,
        required this.createAt,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        agrupacion: json["Agrupacion"],
        archivo: json["Archivo"],
        bodega: json["Bodega"],
        categoria: json["Categoria"],
        cenExt2: json["Cen_ext2"],
        clave: json["Clave"],
        codigo: json["Codigo"],
        core: json["Core"],
        ean: json["Ean"],
        gm4: json["GM4"],
        grupo: json["Grupo"],
        itf: json["Itf"],
        iva: json["Iva"],
        linea: json["Linea"],
        lineaproduccion: json["Lineaproduccion"],
        marca: json["Marca"],
        nombre: json["Nombre"],
        pagaPastilla: json["Paga_pastilla"],
        peso: json["Peso"]?.toDouble(),
        portafolio: json["Portafolio"],
        precio: json["Precio"],
        saldo: json["Saldo"],
        sector: json["Sector"],
        subcategoria: json["Subcategoria"],
        sublinea: json["Sublinea"],
        unidades: json["Unidades"],
        unidadesxcaja: json["Unidadesxcaja"],
        unidadmedida: json["Unidadmedida"],
        vendedor: json["Vendedor"],
        marcadd: json["Marcadd"],
        createAt: DateTime.parse(json["CreateAt"]),
    );

    Map<String, dynamic> toJson() => {
        "Agrupacion": agrupacion,
        "Archivo": archivo,
        "Bodega": bodega,
        "Categoria": categoria,
        "Cen_ext2": cenExt2,
        "Clave": clave,
        "Codigo": codigo,
        "Core": core,
        "Ean": ean,
        "GM4": gm4,
        "Grupo": grupo,
        "Itf": itf,
        "Iva": iva,
        "Linea": linea,
        "Lineaproduccion": lineaproduccion,
        "Marca": marca,
        "Nombre": nombre,
        "Paga_pastilla": pagaPastilla,
        "Peso": peso,
        "Portafolio": portafolio,
        "Precio": precio,
        "Saldo": saldo,
        "Sector": sector,
        "Subcategoria": subcategoria,
        "Sublinea": sublinea,
        "Unidades": unidades,
        "Unidadesxcaja": unidadesxcaja,
        "Unidadmedida": unidadmedida,
        "Vendedor": vendedor,
        "Marcadd": marcadd,
        "CreateAt": createAt.toIso8601String(),
    };
}
