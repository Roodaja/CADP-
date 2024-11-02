{Un fabricante de dispositivos electrónicos desea procesar información de
los repuestos que compró. De cada repuesto conoce su código, precio,
código de marca (entre 1 y 130) y nombre del país del que proviene. El
fabricante dispone de una estructura de datos con la información de los
repuestos, ordenados por nombre de país.
Realizar un programa que:

a. Lea el código y el nombre de las 130 marcas con las que trabaja, y
las almacene en una estructura de datos. La información se ingresa sin
ningún orden en particular,

b. Una vez completada la carga, procese la información de los repuestos
e informe: 1. La cantidad de países a los que se le compró más de 100
repuestos.

2. Para cada marca, nombre de la marca y el precio del producto más
barato.

3. COMPLETO: La cantidad de repuestos que no poseen ningún cero en su
código.

Implemente el programa principal que invoque a los módulos de los
incisos a y b, e imprima los resultados.
}   

program pracParcial2024;
const  
    marcas = 130;
type
    rangoMarcas = 1..marcas;
    vecMarcas = array [rangoMarcas] of string;
    vecPrecios = array[rangoMarcas] of real;
    
    repuesto = record
        codigo : integer;
        precio : real;
        codigoMarca : rangoMarcas;
        nombrePais : string;
    end;
    
    lista = ^nodo;
    nodo = record
        dato : repuesto;
        sig : lista;
    end;
        
    procedure cargarLista (var l: lista); // Se dispone
    
    //Inciso A
    
    procedure leerMarcas (var vM : vecMarcas);
    
    var
        nombre : string;
        i, cod : integer;
    begin
        cod := 0;
        
        for i := 1 to marcas do
        begin
            readln(nombre);
            readln(cod);
            vM [cod] := nombre // Guardo el nombre de la marca en el codigo que corresponda.
        end;
    end;
    
    // Inciso B
    
    procedure inicializarVP(var vP : vecPrecios);
    var
        i : integer;
    begin
        for i := 1 to marcas do
        begin
            vP[i] := 999; // Inicializo los precios en un n° alto porque busco el minimo.
        end;
    end;
        
    procedure actualizarMinimo (var minimo : real; actual : integer);
    begin
        
        if actual < minimo then
        begin
            minimo := actual;
        end;
    end;
    
    function sinCeros (cod : integer) : boolean;
    var
        aux : boolean;
        dig: integer
    begin
        dig := 0;
        aux := true;
        
        while (cod <> 0) and (aux = true) do 
        begin
            dig := cod mod 10;
            if (dig = 0) then
            begin
                aux = false;
            end
            else
            begin
                cod := cod div 10;
            end;
        end;
    
        if (aux = false) then
        begin
            sinCeros = true
        end
        else 
        begin
            sinCeros = false;
        end;
    end;
    
    
    procedure procesarLista (l : lista);
    var 
        cantRepuestos, cantPaisesMasRepuestos, cantRepuestosSinCeros : integer;
        vM : vecMarcas;
        vP : vecPrecios;
    begin
        cantPaisesMasRepuestos := 0;
        
        inicializarVP(vP);
        
        while l<>nil do
        begin
            cantRepuestos := 0;
            paisActual := l^.dato.nombrePais;
            
            while (l<>nil) and (paisActual = l^.dato.nombrePais) do 
            begin
                cantRepuestos := cantRepuestos + 1;
                
                actualizarMinimo(vP[l^.dato.codigoMarca], l^.dato.precio); // Inciso B, punto 2;
                //Se fija cual fue el producto mas barato de dicha marca.
                
                if (sinCeros(l^.dato.codigo)) then
                begin
                    cantRepuestosSinCeros := cantRepuestosSinCeros + 1 // Inciso B, punto 3;
                end;
                
                l := l^.sig;
            end;
            
            if (cantRepuestos > 100) then
            begin
                cantPaisesMasRepuestos := cantPaisesMasRepuestos + 1 // Inciso B, punto 1.
            end;
        end;
        
        writeln (cantPaisesMasRepuestos);
        for i := 1 to marcas do
        begin
            writeln (vM[i], vP[i]);
        end;
        writeln (cantRepuestosSinCeros);
    end;
    
var
    vMar : vecMarcas;
    lRep : lista;
begin
    cargarLista(lRep); // Se dispone
    leerMarcas(vMar);
    procesarLista(lRep);
end.
    
