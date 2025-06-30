program Parcial;
const
    valorAlto = 9999;
type
    producto = record
        cod: integer;
        nombre: String[10];
        desc: String[30];
        precioCompra: real;
        precioVenta: real;
        ubicacion: integer // numLote, n o se utiliza para nada.
    end;

    maestro = file of producto;

procedure leer (var m: maestro ; var p: producto);
begin
    if (not eof(m)) then begin
        read(m,p);
    end
    else begin
        p.cod:= valorAlto;
    end;
end;

procedure agregarProducto (var m: maestro ; p: producto);
var
    cabecera: maestro;
begin
    reset(m);
    if (not existeProducto(m,p.cod)) then begin
        read(m,cabecera);
        if (cabecera.cod = 0) then begin
            seek(m,fileSize(m));
            write(m,p);
        end
        else begin
            seek(m,cabecera.dni * -1);
            read(m,cabecera);
            seek(m,filePos(m)-1);
            write(m,p);
            seek(m,0);
            write(m,cabecera);
        end;
    end
    else begin
        writeln('El producto ya se encuentra.');
    end;
    close(m);
end;



procedure quitarProducto (var m: maestro);
var
    cod,pos: integer;
    regM, cabecera: producto;
begin
    reset(m);
    writeln('Ingrese el código a eliminar');
    readln(cod);
    if (existeProducto(m,cod)) then begin
        read(m,cabecera);
        pos:= 1;
        leer(m,regM);
        while (regM.cod <> cod) then begin
            leer(m,regM);
            pos:= pos + 1;
        end;
        if (regM.cod = cod) then begin
            seek(m,filePos(m)-1);
            write(m,cabecera);
            seek(m,0);
            cabecera.cod:= pos * -1;
            write(m,cabecera);
        end;
    end
    else begin
        writeln('El producto a eliminar no existe');
    end;
    close(m);
end;

            
