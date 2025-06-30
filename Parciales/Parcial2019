program Parcial;
const
    valorAlto = 99999; // valor para indicar que no hay mas registros
type
    profesional = record
        dni: integer;
        nombre: string[30];
        apellido: string[30];
        sueldo: real;
    end;

    tArchivo = file of profesional;

procedure leer(var arch: tArchivo; var reg: profesional);
begin
    if not eof(arch) then begin
        read(arch, reg);
    end
    else begin
        reg.dni := valorAlto; // para indicar que no hay mas registros
    end;
end;

procedure crear(var arch: tArchivo ; var info: text);
var
    reg: profesional;
begin
    rewrite(arch);
    reset(info);
    seek(arch,1); // El 0 se usa para la cabecera.
    while (not eof(info)) do begin
        readln(info, reg.dni, reg.sueldo, reg.apellido);
        readln(info, reg.nombre);
        write(arch, reg);
    end;
    close(arch);
    close(info);
end;

function existeProfesional(var arch: tArchivo ; dni: integer): boolean;
var
    reg: profesional;
    esta: boolean;
begin
    esta := false;
    leer(arch, reg);
    while (reg.dni <> valorAlto) and (not esta) do begin
        if (reg.dni = dni) then begin
            esta := true;
        end
        else begin
            leer(arch, reg);
        end;
    end;
    existeProfesional := esta;
end;

procedure agregar (var arch: tArchivo; p: profesional);
var
    cabecera: profesional;
begin
    reset(arch);
    if (not existeProfesional(arch,p.dni)) then begin
        read(arch, cabecera);
        if (cabecera.dni = 0) then begin
            seek(arch,fileSize(arch));;
            write(arch, p);
        end
        else begin
            seek(arch,cabecera.dni * -1);
            read(arch, cabecera);
            seek(arch,filePos(arch)-1);
            write(arch, p);
            seek(arch,0);
            write(arch, cabecera);
        end;
    end
    else begin
        writeln('El profesional con DNI ', p.dni, ' ya existe.');
    end;
    close(arch);
end;

procedure bajaEmpleado (var arch: tArchivo ; p: profesional);
var
    pos: integer;
    cabecera,reg: profesional;
begin
    reset(arch);
    if (existeProfesional(arch,p.dni)) then begin
        read(arch,cabecera);
        leer(arch,reg);
        pos:= filePos(arch);
        while (reg.dni <> p.dni) do begin
            pos:= pos + 1;
            leer(arch,reg);
        end;
        if (reg.dni = p.dni) then begin
            seek(arch,filePos(arch)-1);
            write(arch,cabecera);
            seek(arch,0);
            cabecera.dni:= pos * -1;
            write(arch,cabecera);
        end;
    end
    else begin
        writeln('El empleado no existe.');
    end;
    close(arch);
end;
        
