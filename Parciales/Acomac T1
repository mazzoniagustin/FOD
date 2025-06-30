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

procedure agregarDinos(var m: maestro ; dino: info);
var
    cabecera: info;
begin
    reset(m);
    read(m,cabecera);
    if (cabecera.cod = 0) then begin
        seek(m,fileSize(m));
        write(m,dino);
    end
    else begin
        seek(m,cabecera.cod * -1);
        read(m,cabecera);
        seek(m,filePos(m)-1);
        write(m,dino);
        seek(m,0);
        write(m,cabecera);
    end;
    close(m);
end;

procedure listarContenido(var m: maestro ; var txt: text);
var
    regM: info;
begin
    reset(m);
    rewrite(txt);
    seek(m,1); // en la posición 0 esta la cabecera.
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