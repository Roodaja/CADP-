{
    Redictado de CADP 2023 - PARCIAL 3RA FECHA (13/12) TEMA 1
    Una tienda virtual necesita un programa para administrar la información de sus clientes. 
    De cada cliente se lee: número, DNI, apellido y nombre, fecha de nacimiento (día, mes y año), nivel (1..5) y puntaje. 
    La lectura finaliza cuando se lee el cliente con DNI 33444555, que debe procesarse. 
    Se pide: 
    A) Generar una estructura que contenga número, apellido y nombre de aquellos clientes 
    con DNI compuesto solamente por digitos impares. 
    B) Informar los niveles con mayor y menor puntaje acumulado por los clientes nacidos antes del año 2000. 
    C) Implementar un módulo que elimine, de la estructura generada, 
    la información relacionada a un número de cliente recibido por parámetro. 
    Tener en cuenta que dicho número puede no existir en la estructura.
}
program redictadoTerceraFecha;

const 
    mes = 12;
    nivel = 5;
type
    rangoNivel = 1..nivel;
    rangoMeses = 1..mes;
    
    vectorNiveles = array [rangoNivel] of integer;
    
    infoFecha = record
        dia : integer;
        mes : rangoMeses;
        anio : integer;
    end;
    
    cliente = record
        numero : integer;
        dni : integer;
        nomYap : string;
        fecha : infoFecha;
        nivel : rangoNivel;
        puntaje : integer;
    end;
    
    clienteCumple = record
        numero : integer;
        nomYap : string;
    end;
    
    listaCumple = ^nodo;
    nodo = record
        dato : clienteCumple;
        sig : listaCumple;
    end;
    
procedure leerClientes (var c : cliente);
begin
    writeln('Ingrese el numero del cliente');
    readln(c.numero);
    writeln('Ingrese el dni del cliente');
    readln(c.dni);
    writeln('Ingrese el nomYap del cliente');
    readln(c.nomYap);
    writeln('Ingrese la fecha de nacimiento del cliente');
    writeln('dia');
    readln(c.fecha.dia);
    writeln('mes');
    readln(c.fecha.mes);
    writeln('anio');
    readln(c.fecha.anio);
    writeln('Ingrese el nivel del cliente');
    readln(c.nivel);
    writeln('Ingrese el puntaje del cliente');
    readln(c.puntaje);
end;

procedure cargarListaCumple (var l : listaCumple; numero : integer ; nomYap : string);
var
    nuevo : listaCumple;
begin
    new(nuevo);
    nuevo^.dato.numero := numero;
    nuevo^.dato.nomYap := nomYap;
    nuevo^.sig := l;
    l := nuevo;
end;


//  A) Generar una estructura que contenga número, apellido y nombre de aquellos clientes 
//    con DNI compuesto solamente por digitos impares. 

function cumpleDni(dni : integer) : boolean;
var
    dig : integer;
    found : boolean;
begin
    found := true;
    while (dni <> 0) and (found = true) do
    begin
        dig := dni mod 10;
        if (dig mod 2 = 0) then
        begin
            found := false
        end;
        dni := dni div 10;
    end;
    
    cumpleDni := found;
end;

 //   B) Informar los niveles con mayor y menor puntaje acumulado por los clientes nacidos antes del año 2000. 
 
procedure incializarVectorNiveles (var v : vectorNiveles);
var
    i : integer;
begin
    for i := 1 to nivel do
    begin
        v[i] := 0;
    end;
end;

procedure actualizarMinimosMaximos(v : vectorNiveles; minimo : integer; maximo : integer; var nivelMin : integer; var nivelMax : integer);
var
    i : integer;
begin
    for i := 1 to nivel do
    begin
        if (v[i] < minimo) then
        begin
            minimo := v[i];
            nivelMin := i;
        end;
        if (v[i] > maximo) then
        begin
            maximo := v[i];
            nivelMax := i;
        end;
    end;
end;

procedure recorrerClientes (var l : listaCumple);
var
    minimoNivel : integer;
    maximoNivel : integer;
    
    nivelMinimo : integer;
    nivelMaximo : integer;
    
    v : vectorNiveles;
    c : cliente;
begin
    minimoNivel := 999;
    maximoNivel := -1;
    nivelMinimo := 1;
    nivelMinimo := 1;
    repeat
        leerClientes(c); // lee el cliente
        
        if cumpleDni(c.dni) then // Se fija si cumple con todos los digitos impares
        begin
            cargarListaCumple(l, c.numero, c.nomYap); // Lo agrega a la lista si cumple
        end;
        
        if (c.fecha.anio < 2000) then
        begin
            v[c.nivel] := v[c.nivel] + c.puntaje
        end;
    until (c.dni = 33);
    
    actualizarMinimosMaximos(v, minimoNivel, maximoNivel, nivelMinimo, nivelMaximo);
    writeln ('El nivel minimo fue ', nivelMinimo);
    writeln ('El nivel maximo fue ', nivelMaximo);
    
end;

 //   C) Implementar un módulo que elimine, de la estructura generada, 
//    la información relacionada a un número de cliente recibido por parámetro. 
//    Tener en cuenta que dicho número puede no existir en la estructura.

procedure eliminarCliente (l : listaCumple; numero : integer);
var
    act, ant : listaCumple;
begin
    act := l;
    ant := l;
    while (act <> nil) and (act^.dato.numero <> numero) do
    begin
        ant := act;
        act := act^.sig;
    end;
    
    if (act = nil) then
    begin
        writeln('El numero no existe')
    end
    else
    begin
        ant^.sig := act^.sig;
        dispose(act);
    end;
end;


procedure imprimirListaCumple(l : listaCumple);
begin
    while l<>nil do
    begin
        writeln(l^.dato.numero);
        writeln(l^.dato.nomYap);
        l := l^.sig;
    end;
end;

var
    l : listaCumple;
    c : cliente;
    num : integer;
    v : vectorNiveles;
begin
    incializarVectorNiveles(v);
    l := nil;
    recorrerClientes(l);
    writeln('ListaCumple Generada');
    imprimirListaCumple(l);
    writeln('Ingrese un numero de cliente que desea eliminar');
    readln(num);
    eliminarCliente(l, num);
    imprimirListaCumple(l); // Imprime basura si se elimina el cliente.
end.