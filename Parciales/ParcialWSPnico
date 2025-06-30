program Parcial;
const
    valorAlto = 9999;
type
    producto = record
        cod: integer;
        nom: String;
        desc: String;
        codBarra: String;
        cat: String;
        stockAct: integer;
        stockMin: integer;
    end;

    pedido = record
        cod: integer;
        cantPedida: integer;
        desc: String;
    end;


    maestro = file of producto;
    detalle = file of pedido;

    
procedure leer (var d: detalle ; var p: pedido);
begin
    if (not eof(d)) then begin
        read(d,p);
    end
    else begin
        p.cod:= valorAlto;
    end;
end;

procedure calcularMinimos (var d1,d2,d3: detalle ; var r1,r2,r3,min: pedido);
begin
    if (r1.cod < r2.cod) then begin
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

procedure actualizarMaestro(var m: maestro);
var
    d1,d2,d3: detalle;
    r1,r2,r3: pedido;
    min: pedido;
    regM: producto;
    cant: integer;
begin
    reset(d1);
    reset(d2);
    reset(d3);
    reset(m);
    leer(d1,r1);
    leer(d2,r2);
    leer(d3,r3);
    calcularMinimos(d1,d2,d3,r1,r2,r3,min);
    while (min.cod <> valorAlto) do begin
        read(m,regM);
        while (regM.cod <> min.cod) do begin
            read(m,regM);
        end;
        cant:= 0;
        while (regM.cod = min.cod) do begin
            cant:= cant + min.cantPedida;
            calcularMinimos(d1,d2,d3,r1,r2,r3,min);
        end;
        if (regM.stockAct < cant) then begin
            writeln('No se puede satisfacer la cantidad de stock');
            regM.stockAct:= 0;
        end
        else begin
            regM.stockAct:= regM.stockAct - cant;
        end;
        if (regM.stockMin > regM.stockAct) then begin
            writeln('Categoria ', regM.cat, ' debajo de stock minimo.');
        end;
        seek(m,filePos(m)-1);
        write(m,regM);
    end;
    close(m);
    close(d1);
    close(d2);
    close(d3);
end;
        