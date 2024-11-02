{
    Un local de venta de dispositivos de almacenamiento está analizando las ventas realizadas durante la navidad del 2020. 
    El local organiza los dispositivos que vende en 5 categorías: 
    1. Discos Magnéticos Externos, 2. Discos sólidos externos, 3. Pendrives, 4. Tarjetas de memoria, 5. Otros. 
    Además, el local dispone de una estructura de datos con información de todas sus ventas. 
    De cada venta se conoce el código del dispositivo vendido, la cantidad vendida y el DNI del cliente. 
    a) Realice un módulo que retorne una estructura de datos con la información de los 650 dispositivos que tiene a la venta. 
    De cada dispositivo conoce su categoría (1 a 5), cantidad de gigabytes (GB) de almacenamiento, marca, precio y código (entre 1 y 650). 
    La información de cada dispositivo es ingresada por teclado sin ningún orden en particular. 
    b) Realice un módulo que reciba la información de las ventas y la información de los dispositivos, 
    y retorne la cantidad de ventas de dispositivos de marca Kingston de a lo sumo de 200 GB de cualquier categoría, 
    y la categoría de dispositivos con menor monto total de ventas.
}
program redictado2021;
const 
    dispo = 5;
    cosas = 650;
type
    rangoCatDispo = 1..dispo;
    rangoCosas = 1..cosas;
    // Se dispone de info de todas las ventas.
    // De cada venta se conoce:
    venta = record
        codigo : integer;
        cantVendida : integer;
        dniCliente : integer;
    end;
    
    listaVentas = ^nodo;
    nodo = record
        dato : venta;
        sig : lista;
    end;
    
    vecCosasalaVenta = array [rangoCosas] of infoCosas;
    
    infoCosas = record
        categoria : rangoCatDispo;
        cantidadGB : integer; // Almacenamiento
        marca : string;
        precio : real;
    end;
    
    vecCategorias = array [rangoCatDispo] of integer; // Aca guardo la cantidad vendida
    vecMontos = array [rangoCatDispo] of real; // Aca guardo los montos

procedure cargarVentas (var l : listaVentas; v : venta); // Se dispone. // Esta info no esta ordenada.

// a) Realice un módulo que retorne una estructura de datos con la información de los 650 dispositivos que tiene a la venta. 
// De cada dispositivo conoce su categoría (1 a 5), cantidad de gigabytes (GB) de almacenamiento, marca, precio y código (entre 1 y 650). 
// La información de cada dispositivo es ingresada por teclado sin ningún orden en particular. 

procedure leerCosas (var v : vecCosasalaVenta);
var
    i : integer;
    codigo : rangoCosas;
begin
    for i := 1 to cosas do // La info se ingresa sin ningun orden en particular.
    begin
        writeln('Ingrese el codigo del producto');
        readln(codigo);
        writeln('Ingrese la categoria del producto');
        readln(v[codigo].categoria);
        writeln('Ingrese la cantidad de almacenamiento del producto');
        readln(v[codigo].cantidadGB);
        writeln('Ingrese la marca del producto');
        readln(v[codigo].marca);
        writeln('Ingrese el precio del producto');
        readln(v[codigo].precio);
    end;
end;

//    b) Realice un módulo que reciba la información de las ventas y la información de los dispositivos, 
//    y retorne la cantidad de ventas de dispositivos de marca Kingston de a lo sumo de 200 GB de cualquier categoría, 
//    y la categoría de dispositivos con menor monto total de ventas.

function cumple (marca : string; GB : integer) : boolean;
begin
    if (marca = 'Kingston') and (codigo >= 200) then
    begin
        cumple = true
    end;
end;

inicializarVectorCategorias (var v : vecCategorias);
var
    i : integer;
begin
    for i := 1 to dispo do
    begin
        v[i] := 0;
    end;
end;

inicializarVectorMontos (var v : vecMontos);
var
    i : integer;
begin
    for i := 1 to dispo do
    begin
        v[i] := 0;
    end;
end;

//    b) Realice un módulo que reciba la información de las ventas y la información de los dispositivos, 
//    y retorne la cantidad de ventas de dispositivos de marca Kingston de a lo sumo de 200 GB de cualquier categoría, 
//    y la categoría de dispositivos con menor monto total de ventas.

procedure actualizarMinimo(vC : vecCategorias; vM : vecMontos; montoMinimo : real; var catMenorMontoTotal : integer);
var 
    i : integer;
    montoTotal : real;
begin
    montoTotal := 0;
    for i := 1 to dispo do
    begin
        montoTotal := (vC[i] * vM[i]); // Cantidad de ventas * Precio
        if montoTotal < montoMin then 
        begin
            montoMin := montoTotal 
            catMenorMontoTotal := i;
        end;
    end;
end;

procedure recorrerLista (l : listaVentas; v : vecCosasalaVenta);
var
    cantVentasCumple, catMenorMontoTotal : integer;
    montoMin : real;
    vCat : vecCategorias;
    vMon : vecMontos;
begin
    montoMin := 999;
    catMenorMontoTotal := 1;
    cantVentasCumple := 0;
    while (l<>nil) do
    begin
        if cumple(v[l^.dato.codigo].marca, v[l^.dato.codigo].cantidadGB) then
        begin
            cantVentasCumple := cantVentasCumple + 1
        end;
        
        vCat[v[l^.dato.codigo].categoria] := vCat[v[l^.dato.codigo].categoria] + l^.dato.cantVendida; // Guardo la cantidad de ventas por categoria
        
        vMon[v[l^.dato.codigo].categoria] := vMon[v[l^.dato.codigo].categoria] + v[l^.dato.codigo].precio; // Guardo el precio de cada producto
        
        l := l^.sig;
    end;
    
    actualizarMinimo (vCat, vMon, montoMin, catMenorMontoTotal);
    writeln(cantVentasCumple);
    writeln(catMenorMontoTotal);
end;
var
    l : listaVentas;
    vec : vecCosasalaVenta;
    v : venta;
    vCat : vecCategorias;
    vMont : vecMontos;
begin
    cargarVentas(l, v); // Se dispone
    leerCosas(vec); // A
    inicializarVectorCategorias (vCat);
    inicializarVectorMontos (vMont);
    recorrerLista(l, vec); // B
end.
