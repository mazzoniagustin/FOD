program Ej7p2;
const
    valorAlto = 9999;
type
    info = record
        cod: integer;
        nombre: String[16];
        familia: String[16];
        descripcion: String[16];
        zona: String[16];
    end;

    maestro = file of info;

procedure leer (var m: maestro ; var i: info);
begin
    if (not eof(m)) then begin
        read(m,i);
    end
    else begin
        i.cod:= valorAlto;
    end;
end;


procedure marcarEliminados (var m: maestro ; cod: integer);
var
    regM: info;
begin
    reset(m);
    leer(m,regM);
    while (regM.cod <> valorAlto) and (regM.cod <> cod) do begin
        leer(m,regM);
    end;
    if (regM.cod = cod) then begin
        seek(m,filePos(m)-1);
        regM.cod:= -1;
        write(m,regM);
    end
    else begin
        writeln('El código de ave ingresada no existe.');
    end;
    close(m);
end;


procedure compactacion (var m: maestro);
var
    regM: info;
    ultimoReg: info;
    posUltimo,pos: integer;
begin
    reset(m);
    pos:= 0;
    posUltimo:= fileSize(m)-1;
    while (pos <= posUltimo) do begin
        seek(m,pos);
        leer(m,regM);
        if (regM.cod < 0) then begin
            repeat
                seek(m,posUltimo);
                read(m,ultimoReg);
                posUltimo:= posUltimo -1;
            until (ultimoReg.cod >= 0) or (posUltimo < pos);
            
            if (pos <= posUltimo) then begin
                seek(m,pos);
                write(m,ultimoReg);
            end;
        end;
        pos:= pos + 1;
    end;
    seek(m,posUltimo+1);
    truncate(m);
    close(m);
end;