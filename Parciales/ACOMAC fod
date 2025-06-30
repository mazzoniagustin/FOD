program acomac;
const
    valorAlto = 9999;
type
    info = record
        codigo: integer;
        tipo: string[10];
        altura: real;
        peso: real;
        desc: string;
        zona: string;
    end;

    archivo = file of info;


procedure leer(var a: archivo ; var i: info);
begin
    if (not eof(a)) then begin
        read(a,i);
    end
    else begin
        i.codigo:= valorAlto;
    end;
end;

procedure bajas(var a: archivo);
var
    codIngresado,pos: integer;
    i,cabecera: info;
begin
    reset(a);
    writeln('Ingrese el código del dinosaurio a eliminar');
    readln(codIngresado);
    read(a,cabecera);
    while (codIngresado <> -1) do begin
        pos:= 1;
        leer(a,i);
        while (i.codigo <> valorAlto) and (i.codigo <> codIngresado) do begin
            leer(a,i);
            pos:= pos + 1;
        end;
        if (i.codigo = codIngresado) then begin
            seek(a,filePos(a) - 1);
            write(a,cabecera);
            seek(a,0);
            cabecera.codigo:= pos * -1;
            write(a,cabecera);
        end
        else begin
            writeln('El codigo ingresado no existe.');
        end;
        writeln('Ingrese el código a eliminar');
        readln(codIngresado);
        seek(a,1);
    end;
end;


procedure alta (var a: archivo ; reg: info);
var
    cabecera: info;
begin
    reset(a);
    read(a,cabecera);
    if (cabecera.codigo = 0) then begin
        seek(a,fileSize(a));
        write(a,reg);
    end
    else begin
        seek(a,cabecera.codigo*-1);
        read(a,cabecera);
        seek(a,filePos(a)-1);
        write(a,reg);
        seek(a,0);
        write(a,cabecera);
    end;
end;