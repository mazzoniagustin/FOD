program Parcial1;
const
    valorAlto = 9999;
type
    regMae = record
        cod: integer;
        nombre: String[16];
        desc: String[16];
        codBarras: String[16];
        categoria: String[20];
        stockAct: integer;
        stockMin: integer;
    end;

    regDet = record
        cod: integer;
        cantidad: integer;
        desc: String[16];
    end;

    maestro = file of regMae;
    detalle = file of regDet;

procedure leer(var d: detalle ; var r: regDet);
begin
    if (not eof(d)) then begin
        read(d,r);
    end
    else begin
        r.cod:= 9999;
    end;
end;

procedure calcularMinimos (var d1,d2,d3: detalle ; var r1,r2,r3: regDet ; var min: regDet);
begin
    IF (r1.cod < r2.cod) then begin
        min:= r1;
        leer(d1,r1);
    end
    else if (r2.cod < r3.cod) then begin
        min:= r2;
        leer(d2,r2);
    end
    else begin
        min:= r3;
        leer(d3,r3);
    end;
end;

procedure actMaestro (var m: maestro);
var
    d1,d2,d3: detalle;
    regM: regMae;
    r1,r2,r3: regDet;
    min: regDet;
    cant,codAct: integer;
begin
    reset(d1);
    reset(d2);
    reset(d3);
    reset(m);
    leer(d1,r1);
    leer(d2,r2);
    leer(d3,r3);
    calcularMin(d1,d2,d3,r1,r2,r3,min);
    while (min.cod <> valorAlto) do begin
        read(m,regM);
        while (regM.cod <> min.cod) do begin
            read(m,regM);
        end;
        codAct:= regM.cod;
        cant:= 0;
        while (codAct = min.cod) do begin
            cant:= cant + min.cantidad;
            calcularMin(d1,d2,d3,r1,r2,r3,min);
        end;
        if (regM.stockAct - cant < 0) then begin
            writeln('No se pudo satisfacer el stock del producto. La diferencia que existe es ', regM.stockAct - cant. ' Satisfaciendo con la existente...');
            regM.stockAct:= 0;
        end;
        regM.stockAct:= regM.stockAct - cant;
        if (regM.stockAct < regM.stockMin) then begin
            writeln('El producto con código ', regM.cod, ' de la categoría: ', regM.categoria, ' quedó por debajo del stock mínimo.');
        end;
        seek(m,filePos(m)-1);
        write(m,regM);
    end;
    close(d1);
    close(d2);
    close(d3);
    close(m);
end;