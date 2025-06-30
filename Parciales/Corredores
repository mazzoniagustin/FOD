program ParcialCorredores;
const 
    valorAlto = 999;
type
    maestro = record
        dni: integer;
        apellido: string;
        nombre: string;
        kmTotales: integer;
        carrerasGanadas: integer;
    end;

    detalle = record
        dni: integer;
        apellido: string;
        nombre: string;
        kmCorridos: integer;
        gano: integer;
    end;

    det = file of detalle;
    mae = file of maestro;

    vecD = array[1..5] of det;
    vecR = array[1..5] of detalle;

procedure leer(var d: det; reg: detalle);
begin
    if (not eof(d)) then begin
        read(d,reg);
    end
    else begin  
        reg.dni:= valorAlto;
    end;
end;

procedure minimo(var vD: vecD ; var vR: vecR ; var min: detalle);
var
    i, pos,minAct: integer;
begin
    pos:= 0;
    minAct:= 999999;
    for i:= 1 to 5 do begin
        if (vR[i].dni < minAct) then begin
            minAct:= vR[i].dni;
            pos:= i;
            min:= vR[i];
        end;
    end;
    leer(vD[pos],vR[pos]);
end;

procedure crearMaestro (var m: maestro ; var vD: vecD);
var
    regM: maestro;
    regD: vR;
    min: detalle;
    i: integer;
    cantGanadas,kmCorridos: integer;
begin
    for i:= 1 to 5 do begin
        reset(vD[i]);
        leer(vD[i],regD[i]);
    end;
    rewrite(m);
    minimo(vD,vR,min);
    while (min.dni <> valorAlto) do begin
        