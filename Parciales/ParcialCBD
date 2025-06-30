program Parcial23_5;
const
    valorAlto = 999;
type
    profesionales = record
        dni: integer;
        nombre: string;
        apellido: string;
        sueldo: real;
    end;

    tArchivo = file of profesionales;

procedure crearMaestro(var a: tArchivo ; var txt: text);
var
    p: profesionales;
begin
    reset(txt);
    rewrite(a);
    while (not eof(txt)) do begin
        readln(txt,p.dni,p.sueldo,p.nombre);
        readln(txt,p.apellido);
        write(a,p);
    end;
    close(txt);
    close(a);
end;

function existeEmpleado(var a: tArchivo , p: profesionales): boolean;
var
    ok: boolean;
    emp: profesionales;
begin
    ok:= false;
    while (not eof(a)) and (not ok) do begin
        read(a,emp);
        if (emp.dni = p.dni) then begin
            ok:= true;
        end;
    end;
    existeEmpleado:= ok;
end;



procedure alta(var a: tArchivo ; p: profesionales);
var
    cabecera: profesionales;    
begin
    reset(a);
    if (not existeEmpleado(a,p)) then begin
        seek(a,0);
        read(a,cabecera);
        if (cabecera.dni = 0) then begin
            seek(a,fileSize(a));
            write(a,p);
        end
        else begin
            seek(a,cabecera.dni * -1);
            read(a,cabecera);
            seek(a,filePos(a)-1);
            write(a,p);
            seek(a,0);
            write(a,cabecera);
        end;
    end;
    close(a);
end;


procedure baja(var a: tArchivo ; p: profesionales ; var bajas: txt);
var
    pos: integer;
    cabecera, emp: profesionales;
    esta: boolean;
begin
    reset(a);
    reset(bajas);
    read(a,cabecera);
    pos:= 1;
    esta:= false;
    while (not eof(a)) and (not esta) do begin
        read(a,emp);
        if (emp.dni = p.dni) then begin
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
        cabecera.dni:= pos * -1;
        write(a,cabecera);
        writeln(bajas, emp.dni, '', emp.sueldo, emp.nombre);
        writeln(bajas, emp.apellido);
    end;
    close(a);
    close(bajas);
end; 



