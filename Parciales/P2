program P2;
type
    tProducto = record
        codigo: integer;
        nombre: String[50];
        presentacion: String[100];
    end;

    tArchProductos = file of tProducto;

procedure leer(var arch: tArchProductos; var reg: tProducto);
begin
    if not eof(arch) then
        read(arch, reg)
    else
        reg.cod := valorAlto;
end;


procedure agregar(var a: tArchProductos ; p: tProducto);
var
    cabecera: tProducto;
begin
    reset(a);
    read(a,cabecera);
    if (cabecera.codigo = 0) then begin
        seek(a,fileSize(a));
        write(a,p);
    end
    else begin
        seek(a,cabecera.cod * -1);
        read(a,cabecera);
        seek(a,filePos(a)-1);
        write(a,p);
        seek(a,0);
        write(a,cabecera);
    end;
    close(a);
end;

procedure eliminar (var a:tArchProductos ; p: tProducto);
var
    cabecera,regM: tProducto;
    pos: integer;
begin
    reset(a);
    read(a,cabecera);
    pos:= 1;
    leer(a,regM);
    while (regM.cod <> valorAlto) and (regM.cod <> p.cod) do begin
        pos:= pos + 1;
        leer(a,regM);
    end;
    if (regM.cod = p.cod) then begin
        seek(a,filePos(a)-1);
        write(a,cabecera);
        seek(a,0);
        cabecera.cod:= pos * -1;
        write(a,cabecera);
    end;
    close(a);
end;

