program Parcial30;
const 
    valorAlto = 999;
    DF = 30;
type
    subRango = 1..DF;
    maestro = record
        cod: integer;
        nombre: string[12];
        cant: integer;
    end;

    detalle = record
        cod: integer;
        cant: integer;
    end;

    mae = file of maestro;
    det = file of detalle;

    vDet = array[subRango] of det;
    vReg = array[subRango] of detalle:

procedure leer(var d: det ; var det: detalle);
begin
    if (not eof(d)) then begin
        read(d,det);
    end
    else begin
        det.cod:= valorAlto;
    end;
end;

procedure calcularMin(var vecD: vDet ; var regD: vReg ; var min: detalle);
var
    minAct,i,pos: integer;
begin
    minAct:= 9999;
    pos:= 0;
    for i:= 1 to DF do begin
        if (regD[i].cod < minAct) then begin
            minAct:= regD[i].cod;
            min:= regD[i];
            pos:= i;
        end;
    end;
    leer(vecD[pos],regD[pos]);
end;

procedure actMae(var m: mae; var vecD: vDet);
var
    i,codAct,cant: integer;
    min: detalle;
    regM: maestro;
    nombre: string;
    vR: vReg;
begin
    for i:= 1 to DF do begin
        writeln('Ingrese el nombre del archivo detalle');
        read(nombre);
        assign(vecD[i],nombre);
        reset(vecD[i]);
        leer(vecD[i],vR[i]);
    end;
    reset(m);
    read(m,regM);
    calcularMin(vecD,vR,min);
    while not (eof(m)) do begin
        while (min.cod <> valorAlto) and (min.cod = regM.cod) do begin
            codAct:= min.cod;
            cant:= 0;
            while (codAct = min.cod) do begin
                cant:= cant + min.cant;
                calcularMin(vecD,vR,min);
            end;
            seek(m,filePos(m)-1);
            regM.cant:= regM.cant + cant;
            write(m,regM);
        end;
        if (regM.cant > 15) then begin
            writeln('Municipio: ', regM.nombre, ' Casos: ', regM.cant);
        end;
        read(m,regM);
        calcularMin(vecD,vR,min);
    end;
    close(m);
    for i:= 1 to DF do begin
        close(vecD[i]);
    end;
end;

        

