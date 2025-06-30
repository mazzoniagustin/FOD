program Parcial4;
const 
    valorAlto = 9999;
type
    ventas = record
        codSuc: integer;
        idAutor: integer;
        isbn: integer;
        idEj: integer;
    end;

    archivo = file of ventas;

procedure lectura (var a: archivo ; var v: ventas);
begin
    if (not eof(a)) then begin
        read(a,v);
    end
    else begin
        v.codSuc:= valorAlto;
    end;
end;

procedure corteDeControl(var a: archivo ; var txt: text ; var nom: string);
var
    totalSucursal, totalGeneral, totalLibro, totalAutor, autorAct, codAct, isbnAct, ejAct: integer;
    v: ventas;
begin
    assign(txt,nom);
    rewrite(txt);
    reset(a);
    leer(a,v);
    totalGeneral:= 0;
    while (v.codSuc <> valorAlto) do begin
        writeln(txt, 'Codigo de sucursal: ', v.codSuc);
        codAct:= v.codSuc;
        totalSucursal:= 0;
        while (codAct = v.codSuc) do begin
            writeln(txt,'Identificacion de autor ',v.idAutor);
            autorAct:= v.idAutor;
            totalAutor:= 0;
            while (codAct = v.codSuc) and (autorAct = v.idAutor) do begin
                isbnAct = v.isbn;
                totalLibro:= 0;
                while (codAct = v.codSuc) and (autorAct = v.idAutor) and (isbnAct = v.isbn) do begin
                    totalLibro:= totalLibro + 1;
                    leer(a,v);
                end;
                writeln(txt, 'ISBN: ',isbnAct, ' Total ejemplares del libro: ', totalLibro);
                totalAutor:= totalAutor + totalLibro;
            end;
            writeln(txt, 'Total ejemplares vendidos del autor: ', totalAutor);
            totalSucursal:= totalSucursal + totalAutor;
        end;
        writeln(txt, 'Total vendidos en la sucursal: ',totalSucursal);
        totalGeneral:= totalGeneral + totalSucursal;
    end;
    writeln(txt,'Total vendidos en la cadena: ', totalGeneral);
    close(txt);
    close(a);
end;

