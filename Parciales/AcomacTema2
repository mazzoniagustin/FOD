program Acomac;
const
    valorAlto = 9999;
type
    info = record
        cod: integer;
        tipo: String[12];
        altura: real;
        peso: real;
        desc: String[100];
        zona: String[15];
    end;

    maestro = file of info;

procedure leer(var m: maestro ; var i: info);
begin
    if (not eof(m)) then begin
        read(m,i);
    end
    else begin
        i.cod:= valorAlto;
    end;
end;

procedure marcarEliminados(var m: maestro ; var tipoDino: integer); 
var
    regM,cabecera: info;
    pos: integer;
begin
    reset(m);
    read(m,cabecera);
    pos:= 1;
    leer(m,regM);
    while (regM.cod <> valorAlto) and (regM.cod <> tipoDino) do begin
        pos:= pos + 1;
        leer(m,regM);
    end;
    if (regM.cod = tipoDino) then begin
        seek(m,filePos(m)-1);
        write(m,cabecera);
        seek(m,0);
        cabecera.cod:= pos * -1;
        write(m,cabecera);
    end
    else begin
        writeln('No se encontró el cod de dinosaurio a eliminar.');
    end;
    close(m);
end;

procedure obtenerEliminados(var m: maestro);
var
    cod: integer;
begin
    writeln('Ingrese el código del dinosaurio');
    readln(cod);
    while (cod <> 100000) do begin
        marcarEliminados(m,tipo);
        writeln('Ingrese el código del dinosaurio(100000 para cortar)');
        readln(cod);
    end;
end;

procedure informarTXT(var m: maestro ; var txt: text);
var
    regM: info;
begin
    reset(m);
    rewrite(txt);
    leer(m,regM);
    while (regM.cod <> valorAlto) do begin
        if (regM.cod > 0) then begin
            write(txt,'Codigo: ', regM.cod, '', 'Altura ', regM.altura, '', 'Peso ', regM.peso, '', 'Descripción: ', regM.desc);
            write(txt,'Tipo: ',regM.tipo);
            write(txt, 'Zona: ',regM.zona);
        end;
        leer(m,regM);
    end;
    close(m);
    close(txt);
end;
