program Parcial3;
const
    valorAlto = 9999;
type
    productos = record
        cod: integer;
        desc: string;
        existencia: integer;
        stockMin: integer;
        precio: real;
    end;

    cajas = record
        numTicket: integer;
        cod: integer;
        cantUnidades: integer;
    end;

    maestro = file of productos;
    detalle = file of cajas;

    vectorDetalle = array[1..25] of detalle;
    vectorRegistro = array[1..25] of cajas;

procedure leer (var m: maestro ; var p: producto);
begin
    if not (eof(m)) then begin
        read(m,p);
    end
    else begin
        p.cod:= valorAlto;
    end;
end;

procedure leerD(var d: detalle ; var c: cajas);
begin
    if not (eof(d)) then begin
        read(d,c);
    end
    else begin
        c.cod:= valorAlto;
    end;
end;

procedure calcularMinimos(var vD: vectorDetalle ; var vR: vectorRegistro ; var min: cajas);
var
    i, pos: integer;
begin
    pos:= 0;
    min.cod:= valorAlto;
    for i:= 1 to 25 do begin
        if (vR[i].cod < min.cod) then begin
            pos:= i;
            min:= vR[i];
        end;
    end;
    if (min.cod <> valorAlto) then begin
        leer(vD[pos],vR[pos]);
    end;
end;

procedure actMaestro(var m: maestro);
var
    vD: vectorDetalle;
    vR: vectorRegistro;
    regM: productos;
    min: cajas;
    i,codAct,cantVendidas: integer;
    montoTotal,montoProductos: real;
begin
    reset(m);
    montoProductos:= 0;
    for i:= 1 to 25 do begin
        reset(vD[i]);
        leer(vD[i],vR[i]);
    end;
    calcularMinimos(vD,vR,min);
    while (min.cod <> valorAlto) do begin
        read(m,regM);
        while (regM.cod <> min.cod) do begin
            writeln('El producto con código ', regM.cod, ' no tuvo productos vendidos.');
            read(m,regM);
        end;
        codAct:= regM.cod;
        cantVendidas:= 0;
        montoTotal:= 0;
        while (codAct = min.cod) do begin
            cantVendidas:= cantVendidas + min.cantUnidades;
            calcularMinimos(vD,vR,min);
        end;
        if (cantVendidas > regM.stockMin) then begin
            writeln('El producto con código ', codAct, ' quedó por stock debajo del mínimo.');
        end;
        regM.existencia:= regM.existencia - cantVendidas;
        montoTotal:= cantVendidas * regM.precio;
        writeln('Código: ',codAct, ' Nombre: ', regM.desc, ' Monto total: ', montoTotal);
        seeK(m,filePos(m)-1);
        write(m,regM);
        montoProductos:= montoProductos + montoTotal;
    end;
    writeln('Facturado en el día: ',montoProductos);
    for i:= 1 to 25 do begin
        close(vD[i]);
    end;
    close(m);
end;

