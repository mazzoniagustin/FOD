program Parcial2;
type
    tProducto = record
        codigo: integer;
        nombre: string[50];
        presentacion: string[100];
    end;

    tArchProductos = file of tProducto;

procedure agregar(var a: tArchProductos; producto: tProducto);
var
    cabecera: tProducto;
begin
    reset(a);
    seek(a,0);
    read(a,cabecera);
    if (cabecera.codigo = 0) then begin
        seek(a,fileSize(a));
        write(a,producto);
    end
    else begin
        seek(a,cabecera.codigo * - 1);
        read(a,cabecera);
        seek(a,filePos(a)-1);
        write(a,producto);
        seek(a,0);
        write(a,cabecera);
    end;
    close(a);
end;

procedure eliminar (var a: tArchProductos ; producto: tProducto);
var
    cabecera,reg: tProducto;
    pos: integer;
    esta: boolean;
begin
    esta:= false;
    pos:= 1;
    reset(a);
    read(a,cabecera);
    while (not eof(a)) and (not esta) do begin
        read(a,reg);
        if (reg.codigo = producto.codigo) then begin
            esta:= true;
        end
        else begin
            pos:= pos + 1;
        end;
    end;
    if (esta) then begin
        seek(a,filePos(a)-1);
        write(a,cabecera);
        seek(a,0);
        cabecera.codigo:= pos * -1;
        write(a,cabecera);
    end
    else begin
        writeln('No se encontró el producto a eliminar');
    end;
    close(a);
end;
