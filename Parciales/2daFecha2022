program Parcial;
const
    valorAlto = 'ZZZZ';
type
    municipio = record
        nombre: string[30];
        descripcion: string[100];
        cantidadHabitantes: integer;
        extension: real;
        creacion: integer;
    end;

    maestro = file of municipio;

procedure leer(var m: maestro; var reg: municipio);
begin
    if not eof(m) then begin
        read(m, reg);
    end
    else begin
        reg.nombre := valorAlto; // para indicar que no hay mas registros
    end;
end;

function existeMunicipio(var m: maestro; nombre: string): boolean;
var
    reg: municipio;
    ok: boolean;
begin
    ok:= false;
    seek(m,1);
    leer(m, reg);
    while (reg.nombre <> valorAlto) and (not ok) do begin
        if (reg.nombre = nombre) then begin
            ok := true;
        end
        else begin
            leer(m, reg);
        end;
    end;
    existeMunicipio := ok;
end;

procedure altaMunicipio(var m: maestro);
var
    cabecera: municipio;
    nuevoMun: municipio;
begin
    reset(m);
    writeln('Ingrese el nombre del municipio:');
    readln(nuevoMun.nombre);
    write('ingrese la descripcion del municipio:');
    readln(nuevoMun.descripcion);
    write('Ingrese la cantidad de habitantes:');
    readln(nuevoMun.cantidadHabitantes);
    write('Ingrese la extension del municipio:');
    readln(nuevoMun.extension);
    write('Ingrese la fecha de creacion del municipio (AAAAMMDD):');
    readln(nuevoMun.creacion);
    read(m,cabecera);
    if (not existeMunicipio(m,nuevoMun.nombre)) then begin
        if (cabecera.cantidadHabitantes = 0) then begin
            seek(m,fileSize(m));
            write(m,nuevoMun);
        end
        else begin
            seek(m,cabecera.cantidadHabitantes * -1);
            read(m,cabecera);
            seek(m,filePos(m)-1);
            write(m,nuevoMun);
            seek(m,0);
            write(m,cabecera);
        end;
    end
    else begin
        writeln('El municipio ', nuevoMun.nombre, ' ya existe.');
    end;
    close(m);
end;

procedure bajaMunicipio(var m: maestro);
var
    nombre: string;
    pos: integer;
    reg, cabecera: municipio;
begin
    writeln('Ingrese el nombre del municipio a dar de baja:');
    readln(nombre);
    reset(m);
    read(m, cabecera);
    if (existeMunicipio(m,nombre)) then begin
        pos:= 1;
        leer(m,reg);
        while (reg.nombre <> valorAlto) and (reg.nombre <> nombre) do begin
            pos:= pos + 1;
            leer(m,reg);
        end;
        if (reg.nombre <> valorAlto) then begin
            seek(m,filePos(m)-1);
            write(m,cabecera);
            seek(m,0);
            cabecera.cantidadHabitantes := pos * -1;
            write(m,cabecera);
            writeln('Municipio ', nombre, ' dado de baja correctamente.');
        end
        else begin
            writeln('Municipio ', nombre, ' no encontrado.');
        end;
    end;
    close(m);
end;
 