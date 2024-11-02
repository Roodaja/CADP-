{
PROBLEMA:
Redictado de CADP 2023 - PARCIAL 1RA FECHA (31/10) 
TEMA 1 
Un restaurante necesita un programa para administrar la información de los platos que ofrece. 
Se dispone de una estructura con la información de los platos. 
De cada plato se conoce: 
nombre, precio, categoría (1: Entrada, 2: Principal, 3: Postre, 4: Minuta), cantidad de ingredientes 
y nombre de cada uno de los ingredientes (a lo sumo 10). 
A) Generar una nueva estructura con nombre y precio de cada plato que posea "perejil" entre sus ingredientes. 
B) Informar las dos categorías con mayor cantidad de platos ofrecidos. 
C) Informar el precio promedio de los platos con más de 5 ingredientes.
}

program parcialPractica2023;
const
    cat = 4;
    ing = 10;
type
    rangoCategorias = 1..cat;
    rangoIngredientes = 1..ing;
    
    vecCategorias = array [rangoCategorias] of integer;
    vecIngredientes = array [rangoIngredientes] of string;
    
    plato = record;
        nombre : string;
        precio : real;
        categoria : rangoCategorias;
        cantIngredientes : rangoIngredientes;
        nombreIngredientes : string;
    end;
    
    lista = ^nodo;
    nodo = record
        dato : plato;
        sig : lista;
    end;
    
    infoNuevoPlato = record;
        nombre : string;
        precio : real;
    end;
    
    
procedure cargarLista (var l : lista); // Se dispone

inicializarVectorCategorias(var vC : vecCategorias);
var
    i : integer;
begin  
    for i := 1 to cat do
    begin  
        vC[i] := 0;
    end;
end;
    
// A) Generar una nueva estructura con nombre y precio de cada plato que posea "perejil" entre sus ingredientes. 
procedure agregarAdelante (var l2 : lista; nP : infoNuevoPlato);
var
    nuevo : lista;
begin 
    new(nuevo);
    nuevo^.dato := nP;
    nuevo^.sig := l;
    l := nuevo;
end;

// B) Informar las dos categorías con mayor cantidad de platos ofrecidos. 
procedure actualizarMaximo (vC : vecCategorias);
var
    i : integer;
	max, max2 : integer;
	indiceMax, indiceMax2 : integer;
begin
	max := -1; 
	max2 := -1;
	indiceMax := 0; 
	indiceMax2 := 0;
	
	for i:= 1 to cat do
	begin
		if vC[i] > max then
		begin
			max2 := max;
			indiceMax2 := indiceMax;
			
			max := vC[i];
			indiceMax := i;
		end
		else if vC[i] > max2 then
		begin
			max2 := vC[i];
			indiceMax2 := i;
		end;
	end;
	
	writeln(indiceMax, indiceMax); // Inciso B
end;

// C) Informar el precio promedio de los platos con más de 5 ingredientes.
procedure recorrerLista (l : lista; var l2: lista; nuevoPlato : infoNuevoPlato);
var

    vI : vecIngredientes;
    vC : vecCategorias;
    i : integer;
    
    cantPlatosConMasDe5Ing : integer;
    preciosTotales : real;
    
begin  

    cantPlatosConMasDe5Ing := 0;
    preciosTotales := 0;
    inicializarVectorCategorias(vC); // Pongo en 0 las 4 cateogorias.
    
    while (l<>nil) do // Analizo cada plato de la lista que se dispone.
    begin  
        vC[l^.dato.categoria] := vC[l^.dato.categoria] + 1;
        
        for i := 1 to l^.dato.cantIngredientes do
        begin  
            if (vI[i] = 'Perejil') then 
            begin  
                agregarAdelante(l2, nuevoPlato); // Inciso A
            end;
        end;
        
        if (l^.dato.cantIngredientes > 5) then
        begin
            cantPlatosConMasDe5Ing := cantPlatosConMasDe5Ing + 1;
            preciosTotales := preciosTotales +  l^.dato.precio;
        end;
        
        l := l^.sig;
    end;
    
    actualizarMaximo(vC); // Inciso B.
    
    // Inciso C.
    writeln('El precio promedio de los platos con mas de 5 ingredientes fue de = ', preciosTotales/cantPlatosConMasDe5Ing); 

end;

var
    l, l2 : lista;
    infPlato : infoNuevoPlato;
    p : plato;
begin  
    leerLista(p); // Se dispone
    cargarLista(l); // Se dispone
    recorrerLista(l, l2, infPlato);
end.
