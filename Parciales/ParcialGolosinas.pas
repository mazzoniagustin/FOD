program ParcialGolosinas;
const
    valorAlto = 9999;
    df = 20;
type
    maestro = record
        cod: integer;
        nombre: string;
        precio: real;
        stockAct: integer;
        stockMin: integer;
    end;

    detalle = record
        cod: integer;
        cant: integer;
    end;

    det = file of detalle;
    mae = file of maestro;

    vectorDetalles = array [1..df] of det;
    vectorRegistro = array [1..df] of detalle;

procedure leer(var d: det ; var r: detalle);
begin
    if (not eof(d)) then begin
        read(d,r);
    end
    else begin
        r.cod:= valorAlto;
    end;
end;


procedure minimo (var d: vectorDetalles ; var r: vectorRegistro ; var min: detalle);
var
    i,pos: integer;
begin
    min.cod;= valorAlto;
    for i:= 1 to df do begin
        if (d[i].codigo < min) then begin
            min:= d[i];
            pos:= i;
        end;
    end;
    if (min.cod <> valorAlto) then begin
        leer(d[pos],r[pos]);
    end;
end;

procedure actualizarMaestro(var m: mae ; var d: vectorDetalles);
var
    txt: text;
    min: detalle;
    regM: maestro;
    r: vectorDetalles;
    i: integer;
begin
    assign(txt,'exportado.txt');
    rewrite(txt);
    for i:= 1 to df do begin
        reset(d[i]);
        leer(d[i],r[i]);
    end;
    reset(m);
    minimo(d,r,min);
    while (min.cod <> valorAlto) do begin
        read(m,regM);
        while (regM.cod <> min.cod) do begin
            read(m,regM);
        end;
        cantVentas:= 0
        while (regM.cod = min.cod) do begin
            cantVentas:= cantVentas + min.cant;
            min(d,r,min);
        end;
        seek(m,filePos(m)-1);
        regM.stockAct:= regM.stockAct -cantVentas;
        write(m,regM);
        if (min.cant * regM.precio > 10000) then begin
            writeln(txt, 'Producto: ', regM.cod, '', 'Vendidos: ', cantVentas);
        end;
        minimo(d,r,min);
    end;
    close(m);
    close(txt);
    for i:= 1 to df do begin
        close(d[i]);
    end;
end;


