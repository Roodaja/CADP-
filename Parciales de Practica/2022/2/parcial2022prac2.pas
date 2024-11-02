{
Una carnicería necesita analizar la información de las compras a frigorificos realizadas en el último año. 
a) Realizar un módulo que cargue en una estructura de datos adecuada la información de las compras. 
De cada compra se conoce el monto abonado, el mes en que se realizó la compra, 
la cantidad de kilos de carne comprados y el nombre del frigorífico. 
Por cada frigorífico puede haber más de una compra. La información de las compras debe 
quedar ordenada por nombre de frigorífico. 
La lectura finaliza al ingresar la compra con 100 kilos de carne, que debe procesarse 

b) Realizar un programa que utilice la información generada en el inciso a) e informe: > < 

i) Los nombres de los frigoríficos para los cuales el monto total facturado superó los 45.000 pesos. 

ii) Los dos meses en los que se realizaron menor cantidad de compras. 

iii) El monto promedio de las compras realizadas durante el mes de septiembre

    
    
}   

program PracParcial2022;
const
    mes = 12;

type
    rangoMeses = 1..mes;
    vecMeses = array [rangoMeses] of integer; // Aqui voy a meter las compras por mes.
    vecMontos = array [rangoMeses] of real; // Aqui voy a meter lo que se gano por mes en esas compras.
    
    compra = record
        montoAbonado : real;
        mesCompra : rangoMeses;
        cantKilos : real;
        nombreFrigorifico : string;
    end;
    
    lista = ^nodo;
    nodo = record
        dato : compra;
        sig : lista
    end;
    
    // Inciso A
    
    procedure leerLista (var c : compra);
    begin
        readln(c.montoAbonado);
        readln(c.mesCompra);
        readln(c.cantKilos);
        readln(c.nombreFrigorifico);
    end;
    
    procedure cargarLista (var l: lista; c : compra);
    var
        nuevo, ant, act : lista;
    begin
        new(nuevo);
        nuevo^.dato := c;
        act := l;
        ant := l;
        
        while (act <> nil) and (c.nombreFrigorifico < act^.dato.nombreFrigorifico) do
        begin
            ant := act;
            act := act^.sig;
        end;
        
        if (act = ant) then
        begin
            l:= nuevo
        end
        else
        begin
            ant^.sig := nuevo
        end;
        nuevo^.sig := act;
    end;
    
    // Inciso B
    
    procedure inicializarVectorMeses (var vM : vecMeses);
    var
        i : integer;
    begin
        for i := 1 to mes do
        begin
            vM[i] := 0;
        end;
    end;
    
        procedure inicializarVectorMontos (var vMon : vecMontos);
    var
        i : integer;
    begin
        for i := 1 to mes do
        begin
            vMon [i] := 0;
        end;
    end;
    
    procedure actualizarMinimo(vM : vecMeses; var minMes: integer; var minMes2);
    var
        i : integer;
    begin
        for i := 1 to mes do
        begin
            if (vM[i] < minMes) then
            begin
                minMes2 := minMes;
                minMes := i;
            end;
            if (vM[i] < minMes2) then
            begin
                minMes2 := i
            end
        end;
    end;
    
    procedure montoPromedio(vMe : vecMeses; vMo : vecMontos);
    var
        i : integer;
        MontoAux : real;
        MesAux : integer;
    begin
        MontoAux := vMo[9];
        MesAux := vMe[7];
        writeln ('El monto promedio de las compras realizadas en septiembre fue = ', MontoAux/MesAux);
    end;
    
    procedure procesarLista (l : lista);
    var
        montoTotal : real;
        nombreFri : string;
        
        minMesCompra, minMesCompra2 : integer;
        compraTotal : integer;
   
        vM : vecMeses;
        vMontos : vecMontos;
    begin
        inicializarVectorMeses(vM);
        inicializarVectorMontos(vMontos);
        
        minMesCompra2 := 999;
        minMesCompra := 999;
        
        while (l<>nil) do
        begin
            compraTotal := 0;
            montoTotal := 0;
            nombreFri := l^.dato.nombreFrigorifico;
            
            while (l<>nil) and (nombreFri = l^.dato.nombreFrigorifico) do
            begin
                compraTotal := compraTotal + 1;
                montoTotal := montoTotal + l^.dato.montoAbonado;
                
                vM[l^.dato.mesCompra] := vM[l^.dato.mesCompra] + compraTotal;
                vMontos[l^.dato.mesCompra] := vMontos[l^.dato.mesCompra] + montoTotal;
                
                l := l^.sig;
            end;
            
            if (montoTotal > 45000) then
            begin
                writeln('El frigorifico", nombreFri, "Vendio mas de 45000 pesos') // Inciso B, i)
            end
            
        end;
                
        actualizarMinimo(vM, minMesCompra, minMesCompra2); // Inciso B, ii)  
        writeln ('Los meses de menor compra fueron = ', minMesCompra, minMesCompra2); 
        
        montoPromedio(vM, vMontos); // Inciso B, iii)
    end;
    
    procedure informarListas(l: lista); // No obligatorio
    begin
        while (l<>nil) do
        begin
            writeln(l^.dato.montoAbonado:0:2);
            writeln(l^.dato.mesCompra);
            writeln(l^.dato.cantKilos:0:2);
            writeln(l^.dato.nombreFrigorifico);
            l := l^.sig;
        end;
    end;
    
    var
        c : compra;
        l : lista;
    begin
        l := nil;
        repeat
            leerLista(c);
            cargarLista(l, c);
        until (c.cantKilos = 100);
        
        procesarLista(l);
        
     // informarListas(l);
    end.
        
