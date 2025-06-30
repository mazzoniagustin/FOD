program Parcial;
const
    valorAlto = 9999;
type
    producto = record
        cod: integer;
        nombre: String[16];
        precio: real;
        stockAct: integer;
        stockMin: integer;
    end;

    venta = record
        cod: integer;
        cantidad: integer;
    end;

    maestro = file of producto;
    detalle = file of venta;

    vectorDetalle = array [1..25] of detalle;
    vectorRegistro = array [1..25] of venta;

procedure leer (var d: detalle ; var v: venta);
begin
    if (not eof(d)) then begin
        read(d,v);
    end
    else begin
        v.cod:= valorAlto;
    end;
end;


procedure calcularMinimos (var d: vectorDetalle ; var v: vectorRegistro ; var min: venta);
var
    pos, i: integer;
begin
    min.cod:= valorAlto;
    pos:= -1;
    for i:= 1 to 25 do begin
        if (v[i].cod < min.cod) then begin
            min:= v[i];
            pos:= i;
        end;
    end;
    if (min.cod <> valorAlto) then begin
        leer(d[pos],v[pos]);
    end;
end;

procedure actualizarMaestro (var m: maestro);
var
    regM: producto;
    vR: vectorRegistro;
    vD: vectorDetalle;
    montoProd: real;
    txt: Text;
    i,cantVendidos: integer;
    min: venta;
begin
    reset(m);
    rewrite(txt);
    for i:= 1 to 25 do begin
        reset(vD[i]);
        leer(vD[i],vR[i]);
    end;
    calcularMinimos(vD,vR,min);
    while (min.cod <> valorAlto) do begin
        read(m,regM);
        while (regM.cod <> min.cod) do begin
            read(m,regM);
        end;
        while (regM.cod = min.cod) do begin
            cantVendidos:= cantVendidos + min.cantidad;
            calcularMinimos(vD,vR,min);
        end;
        regM.stockAct:= regM.stockAct - cantVendidos;
        montoTotal:= cantVendidas * regM.precio;
        seek(m,filePos(m)-1);
        write(m,regM);
        if (montoTotal > 10000) then begin
            write(txt,'Código: ', regM.cod, , ' Stock actual: ', regM.stockAct, ' Monto total: ', montoTotal, ' stockMin ', regM.stockMin, ' precio unitario: ', regM.precio, ' Nombre del articulo: ', regM.nombre);
        end;
    end;
    close(m);
    close(txt);
    for i:= 1 to 25 do begin
        close(vD[i]);
    end;
end;
