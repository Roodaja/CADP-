program parcial2022Practica;
type
rangoCat = 1..3;

infoCat = record
    nombre : string;
    precioKilo : real;
end;

vCat = array [rangoCat] of infoCat;
vecRecaudaciones = array [rangoCat] of real;

compra = record
    dniCliente : integer;
    catProducto : vCat;
    cantKilos : integer;
end;

listaCompras = ^nodoCompras;
nodoCompras = record
    dato : compra;
    sig : listaCompras;
end;

procedure cargarListaCompras (var l: listaCompras; c : compra);
var
    nuevo : listaCompras;
    act, ant : listaCompras;
begin
    new(nuevo);
    nuevo^.dato := c;
    act := l;
    ant := l;
    
    while (act <> nil) and (c.dniCliente > act^.dato.dniCliente) do
    begin
        ant := act;
        act := act^.sig;
    end;
    
    if (act = ant) then
    begin
        l := nuevo
    end
    else
    begin
        ant^.sig := nuevo
    end;
    nuevo^.sig := act;
end;

procedure leerInfoCat (var v : vCat);
var
    i : integer;
begin
    for i := 1 to 3 do
    begin
        readln(v[i].nombre);
        // readln(v[i]) // Aca leeria el codigo?
        readln(v[i].precioKilo);
    end;
end;

function maximo (dni : integer; cantCompras: integer) : integer;
var
    max : integer;
begin
    max := -1;
    if cantCompras > max then
    begin   
        max := cantCompras; 
        maximo := dni;
    end;
end;

function cumpleDni(dni : integer) : boolean;
var
    cantPar, cantImpar, dig : integer;
begin
    cantPar := 0;
    cantImpar := 0;
    dig := 0;
    while (dni <> 0) do
    begin
        dig := dni mod 10;
        if (dig div 2 = 0) then 
        begin
            cantPar := cantPar + 1;
        end
        else begin
            cantImpar := cantImpar + 1;
        end;
        dni := dni div 10;
    end;
    
    if (cantPar > 3) then 
    begin
        cumpleDni := true
    end
    else
    begin
        cumpleDni := false;
    end;
end;
        

procedure procesarListaCompras (l : listaCompras);
var
    cantCompras, i, dni, dniMax : integer;
    v : vCat;
    vecReca: vecRecaudaciones;
    cantComprasDniPares : integer;
    montoTotal : real;
begin
    while (l<>nil) do
    begin
        cantCompras := 0;
        cantComprasDniPares := 0;
        dni := l^.dato.dniCliente;
        
        while (l<>nil) and (dni = l^.dato.dniCliente) do
        begin
            cantCompras := cantCompras + 1;
            dniMax := maximo(cantCompras, dni); // Inciso 1
            
            v[l^.dato.codigo].precioKilo := 0;
            
                montoTotal := v[l^.dato.codigo].precioKilo * l^.dato.cantKilos;
                vecReca[i] := vecReca[i] + montoTotal; 
            
            if (cumpleDni(l^.dato.dniCliente)) then // Inciso 3
            begin
                cantComprasDniPares := cantComprasDniPares + 1
            end;
            
            l := l^.sig;
        end;
    
    end;
end;

var 
    l : listaCompras;
    c : compra;
    vC : vCat;
begin
    
    l := nil;
    cargarListaCompras (l,c);
    leerInfoCat(vC); // Inciso A.
    procesarListaCompras(l); // Inciso B.
    
end.
