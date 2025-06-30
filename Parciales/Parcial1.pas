program Parcial1;
const
    valorAlto = 999;
type
    producto = record
        codProd: integer;
        nombre: String[16];
        desc: String[30];
        codigoBarras: integer;
        cat: String[6];
        stockAct: integer;
        stockMin: integer;
    end;

    detalle = record
        codProd: integer;
        cantPedida: integer;
        desc: String[30];
    end;

    maestro = file of producto;
    detalles = file of detalle;


procedure leer (var det: detalles ; var d: detalle);
begin
    if (not eof(m)) then
        read(det,d);
    else
        d.codProd:= valorAlto;
end;

procedure minimos(var de1, det2, det3: detalles ; var r1,r2,r3: detalle ; var min: detalle);
begin
    if (r1.codProd < r2.codProd) then
        min:= r1;
        leer(de1,r1);
    else if (r2.codProd < r3.codProd) then
        min:= r2;
        leer(de2,r2);
    else
        min:= r3;
        leer(de3,r3);
end;

procedure actualizarMaestro(var m: maestro ; var d1,d2,d3: detalles);
var
    regM: producto;
    min,r1,r2,r3: detalle;
begin
    reset(m);
    reset(d1);
    reset(d2);
    reset(d3);
    leer(d1,r1);
    leer(d2,r2);
    leer(d3,r3);
    minimos(d1,d2,d3,r1,r2,r3,min);
    while (min.codProd <> valorAlto) do begin
        read(m,regM);
        while (regM.codProd <> min.codProd) do begin
            read(m,regM);
        end;
        while(regM.codProd = min.codProd) do begin
            if (min.cantPedida > regM.stockAct) then begin
                writeln('No se puede satisfacer la cantidad de pedidos solicitados');
                writeln('Satisfaciendo con la cantidad actual...');
                regM.stockAct:= 0;
            end
            else begin
                regM.stockAct:= regM.stockAct - min.cantPedida;
            end;
            minimos(d1,d2,d3,r1,r2,r3);
        if (regM.stockAct < regM.stockMin) then begin
            writeln('Categoria: ', regM.cat);
        end;
        seek(m,filePos(m)-1);
        write(m,regM);
    end;
end;
close(m);
close(d1);
close(d2);
close(d3);
end;


