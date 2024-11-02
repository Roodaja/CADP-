{
La Secretaría de Apoyo a Empresas desea analizar la información de los créditos otorgados a las 1450 empresas registradas
en su sistema (Una empresa puede tener más de un crédito). 

- Corte de control ?

La secretaría otorga 6 tipos de créditos distintos: 1. Contratación de personal, 2. Compra de equipos, 
3. Cursos y capacitaciones, 4. Asesoramiento, 5. Viajes y 6. Otros. 
Además, la secretaría dispone de una estructura de datos con información de las 1450 empresas. 

- se dispone esa info
De cada empresa se conoce su código (entre 1 y 1450), nombre, localidad y cantidad de empleados. 

a) Realice un módulo que retorne una estructura de datos con la información de los créditos registrados. 
De cada crédito se conoce el tipo de crédito, el código de la empresa (entre 1 y 1450), 
el monto de dinero otorgado y el año en que fue otorgado. La lectura finaliza al ingresar un crédito de monto -1. 

b) Realice un módulo que reciba la información de las empresas y la información de los créditos, 
y retorne la cantidad de créditos otorgados a empresas al menos de 40 empleados de las las localidades 
de Neuquén o de Bariloche, y el tipo de crédito con menor monto total de créditos otorgados.
}

program practicaRedictado;
const 
    empresas = 1450;
    creditos = 6;
type
    rangoEmpresas = 1..empresas;
    rangoCreditos = 1..creditos;
    
    vectorEmpresas = array [rangoEmpresas] of infoEmpresas;
    
    infoEmpresas = record
        codigo : rangoEmpresas;
        nombre : string;
        localidad : string;
        cantEmpleados : integer;
    end;
    
    vectorCreditos = array [rangoCreditos] of integer;
    
    creditos = record
        tipo : rangoCreditos;
        codigoEmpresa : rangoEmpresas;
        monto : real; // Que fue otorgado
        año : integer; // Que fue otorgado
    end;
    
    listaCreditos = ^nodo;
    nodo = record
        dato : creditos;
        sig : listaCreditos;
    end;
    
procedure cargarVector (var v : vectorEmpresas); // Se dispone la info de las empresas.

procedure leerLista (var c : creditos);
begin
    readln(c.monto);
    while c.monto <> -1 do
    begin
        readln(c.tipo);
        readln(c.codigoEmpresa);
        readln(c.año);
    end;
end;

procedure cargarLista (var l : listaCreditos;  c : creditos);
var
    nuevo : lista;
begin
    new(nuevo);
    nuevo^.dato := c;
    nuevo^.sig := l;
    l := nuevo;
end;

// b) Realice un módulo que reciba la información de las empresas y la información de los créditos, 
// y retorne la cantidad de créditos otorgados a empresas al menos de 40 empleados de las las localidades 
// de Neuquén o de Bariloche, y el tipo de crédito con menor monto total de créditos otorgados.

procedure inicializarVector(var v : vectorCreditos);
var
    i : rangoCreditos;
begin
    for i := 1 to creditos do
    begin
        v[i] := 0;
    end;
end;

procedure actualizarMinimo(v : vectorCreditos; monto : real; var credito : integer);
var
    i : integer;
begin
    for i := 1 to creditos do
    begin
        if v[i] < monto then
        begin
            monto := v[i];
            credito := i;
        end;
    end;
end;

procedure recorrerLista (l : listaCreditos, v : vectorEmpresas);
var
    cantCreditos, creditoMin : integer;
    montoMin : real;
    vC : vectorCreditos;
begin
    montoMin := 999;
    creditoMin := 1;
    
    inicializarVector(vC); // Inciso B
    
    cantCreditos := 0;
    
    while l<>nil do
    begin
        if (v[l^.dato.codigoEmpresa].cantEmpleados >= 40) then
        begin
            if (v[l^.dato.codigoEmpresa].localidad = 'Bariloche') or (v[l^.dato.codigoEmpresa].localidad = 'Neuquen') then
            begin
                cantCreditos := cantCreditos + 1; // Inciso B
            end;
        end;
        
        vC[l^.dato.tipo] := vC [l^.dato.tipo] + l^.dato.monto;
        
        l := l^.sig;
    end;
    
    actualizarMinimo(vC, montoMin, creditoMin);
    
    writeln(creditoMin); // Inciso B
end;

var
    c : creditos;
    l : listaCreditos;
    v : vectorEmpresas;
begin
    cargarVector(v); // Se dispone
    while c.monto <> -1 do
    begin
        leerLista(c); // Inciso A
        cargarLista(l, c); // Inciso A
    end;
    recorrerLista (l, v); // Inciso B
end.
