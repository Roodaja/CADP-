{
TEMA 1-CADP 2024 29/6/2024 
Un supermercado está procesando las compras que realizaron sus clientes. 
Para ello, dispone de una estructura de datos con todas las compras, sin ningún orden en particular. 
De cada compra se conoce código, mes, año (entre 2014 y 2024), monto y el DNI del cliente. 

Un cliente puede haber realizado más de una compra. 
Realizar un programa lea de teclado un año y luego: 
a. Almacene en otra estructura de datos las compras realizadas en el año leído. 
Esta estructura debe quedar ordenada por DNI del cliente. 

b. Una vez almacenada la información, procese los datos del inciso a. e informe: 
1. Para cada cliente, el monto total facturado entre todas sus compras. 
2. Los dos meses con menor facturación. 
3. COMPLETO: La cantidad de compras con código múltiplo de 10.
}

program parcial2024Practica;
const
    año = 2024;
    mes = 12;
type 
    rangoMeses = 1..mes;
    rangoAños = 2014..año;
    
    vecMeses = array [rangoMeses] of real;
    
    compra = record
        codigo : integer;
        mes : rangoMeses;
        año : rangoAños;
        monto : real;
        dni : integer;
    end;
    
    lista = ^nodo
    nodo = record
        dato : compra;
        sig : lista;
    end;
    
procedure cargarListaCompras (var l : lista); // Se dispone

//a. Almacene en otra estructura de datos las compras realizadas en el año leído. 
//Esta estructura debe quedar ordenada por DNI del cliente. 

procedure insertarOrdenado(var l2 : lista; c : compras);
var
    nuevo, ant, act : lista;
begin
    new(nuevo);
    nuevo^.dato := c;
    act := l;
    ant := l;
    
    while (act <> nil) and (act^.dato.dni < nuevo^.dato.dni) do
    begin
        ant := act;
        act := act^.sig;
    end;
    
    if (act = ant) then
    begin
        l2 := nuevo;
    end
    else
    begin
        ant^.sig := nuevo;
    end;
    nuevo^.sig := act;
end;
    
procedure verComprasAños(l : lista; var l2 : lista; año : integer);
var
    
begin 
    while l <> nil do
    begin
        if l^.dato.año = año then
        begin
            insertarOrdenado(l2, l^.dato);
        end;
    end;
end;

{
b. Una vez almacenada la información, procese los datos del inciso a. e informe: 
1. Para cada cliente, el monto total facturado entre todas sus compras. 
2. Los dos meses con menor facturación. 
3. COMPLETO: La cantidad de compras con código múltiplo de 10.
}

procedure inicializarMeses(var v : vecMeses);
var
    i : integer;
begin
    for i := 1 to mes do
    begin
        v[i] := 0;
    end;
end;

procedure actualizarMinimos (v : vecMeses);
var
    i, min, min2 : integer;
    indiceMin, indiceMin2 : integer;
begin
    min := 999;
    min2 := 999;
    indiceMin := 0;
    indiceMin2 := 0;
    
    for i := 1 to mes do
    begin
        if v[i] < min then
        begin
            min2 := min;
            indiceMin2 := indiceMin;
            
            min := v[i];
            indiceMin := i;
        end
        else
        if v[i] < min2 then
        begin
            min2 := v[i];
            indiceMin2 := i;
        end;
    end;
    writeln(indiceMin, indiceMin2);
end;


procedure recorrerLista(l2 : lista);
var
    montoTotal : real;
    dniActual, cantCompras10 : integer;
    vM : vecMeses;
    
begin
    inicializarMeses(vM);
    cantCompras10 := 0;
    
    while (l2 <> nil) do
    begin
        montoTotal := 0;
        dniActual := l^.dato.dni;
        while (l2 <> nil) and (dniActual = l2^.dato.dni) do
        begin
            montoTotal := montoTotal + l2^.dato.monto;
            
            vM[l2^.dato.mes] := vM[l2^.dato.mes] + l2^.dato.monto;
            
            if (l2^.dato.codigo mod 10 = 0) then
            begin
                cantCompras10 := cantCompras10 + 1;
            end;
            
            l2 := l2^.sig;
        end;
        
        writeln(montoTotal); // Inciso B) 1.
    end;
    
    actualizarMinimos(vM); // Inciso B) 2.
    writeln(cantCompras10); // Inciso B) 3.
    
end;
var
    l, l2 : lista;
    c : compra; // Se dispone
    año : rangoAños;
begin
    readln(año);
    l2 := nil; // para que no tenga nada;
    verComprasAños(l, l2, año);
    
    recorrerLista(l2);
end.
