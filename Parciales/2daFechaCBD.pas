program Parcial;
const
    valorAlto = 9999;
type
    arMaestro = record
        cod: integer;
        nombre: String[16];
        descripcion: String[30];
        stockAct: integer;
        stockMin: integer;
        receta: boolean;
    end;

    arDet = record
        cod: integer;
        cantVendida: integer;
        nombre: String[16];
        domicilio: String[20];
    end;

    maestro = file of arMaestro;
    detalle = file of arDet;

    vectorDetalle = array[1..30] of detalle;
    vectorRegistro = array[1..30] of arDet;

procedure leer(var d: detalle ; var reg: arDet);
begin
    if (not eof(d)) then begin
        read(d,reg);
    end
    else begin
        reg.cod:= valorAlto;
    end;
end;

procedure calcularMin(var vD: vectorDetalle ; var vR: vectorRegistro ; var min: arDet);
var
    pos, i: integer;
begin
    min.cod:= valorAlto;
    pos:= -1;
    for i:= 1 to 30 do begin
        if (vR[i].cod < min.cod) then begin
            min:= vR[i];
            pos:= i;
        end;
    end;
    if (min.cod <> valorAlto) then begin
        leer(vD[pos],vR[pos]);
    end;
end;

procedure actualizarMaestro (var m: maestro);
var
    vD: vectorDetalle;
    vR: vectorRegistro;
    min: arDet;
    regM: arMaestro;
    i,codAct,cant: integer;
    txt: text;
    nombreCli,domicilioCli: string;
begin
    reset(m);
    rewrite(txt);
    for i:= 1 to 30 do begin
        reset(vD[i]);
        leer(vD[i],vR[i]);
    end;
    calcularMin(vD,vR,min);
    while (min.cod <> valorAlto) do begin
        read(m,regM);
        while (regM.cod <> min.cod) do begin
            read(m,regM);
        end;
        codAct:= regM.cod;
        cant:= 0;
        nombreCli:= min.nombre;
        domicilioCli:= min.domicilio;
        while (codAct = min.cod) do begin
            cant:= cant + min.cantidad;
            if (regM.receta) then begin
            write(txt, 'Codigo: ', regM.cod, ' Nombre: ', nombreCli);
            write(txt, 'Domicilio: ', domicilioCli);
            end;
            calcularMin(vD,vR,min);
        end;
        if (regM.stockAct - cant > 0) then begin
            regM.stockAct:= regM.stockAct - cant;
        end
        else begin // esto no es necesario, pero lo agrego.
            writeln('No hay stock para las ventas.'); 
            regM.stockAct:= 0;
        if (regM.stockAct < regM.stockMin) then begin
            writeln('Es necesario reponer el stock del siguiente producto: ', regM.nombre , regM.descripcion, regM.stockAct, regM.stockMin);
        end;
    end;
    for i:= 1 to 30 do begin
        close(vD[i]);
    end;
    close(m);
    close(txt);
end;

