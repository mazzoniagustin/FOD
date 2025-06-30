program Parcial2daFecha2024;
const
    valorAlto = 99999;
    dimF = 30;
type
    municipio = record
        cod: integer; // orden
        nombre: string[30];
        casosPositivos: integer;
    end;

    detalle = record
        cod: integer; // orden, puede aparecer varias veces
        casosPositivos: integer;
    end;
    maestro = file of municipio;
    det = file of detalle;

    vectorDetalle = array[1..dimF] of det;
    vectorRegistro = array[1..dimF] of detalle;

procedure leer(var m: maestro ; var reg: municipio);
begin
    if not eof(m) then begin
        read(m,reg);
    end
    else begin
        reg.cod := valorAlto; // para indicar que no hay mas registros
    end;
end;


procedure calcularMinimos(var vD: vectorDetalle; var vR: vectorRegistro; var minimo: detalle);
var
    i: integer;
    pos: integer;
begin
    minimo.cod := valorAlto;
    pos := -1;
    for i := 1 to dimF do begin
        if (vR[i].cod < minimo.cod) then begin
            minimo := vR[i];
            pos := i;
        end;
    end;

    if pos <> -1 then begin
        leer(vD[pos], vR[pos]);
    end;
end;

procedure actualizarEInformar(var m: maestro);
var
    vD: vectorDetalle;
    vR: vectorRegistro;
    regM: municipio;
    min: detalle;
    i: integer;
begin
    for i := 1 to dimF do begin
        reset(vD[i]);
        leer(vD[i], vR[i]);
    end;
    reset(m);
    leer(m, regM);
    calcularMinimos(vD,vR,min);
    while (regM.cod <> valorAlto) do begin
        while (regM.cod <> min.cod) do begin
            leer(m, regM);
        end;
        while (regM.cod = min.cod) do begin
            regM.casosPositivos := regM.casosPositivos + min.casosPositivos;
            calcularMinimos(vD, vR, min);
        end;
        seek(m, filepos(m) - 1); // Volver al registro actual
        write(m, regM); // Actualizar el registro en el archivo maestro
        if (regM.casosPositivos > 15) then begin
            writeln('Municipio: ', regM.nombre, ' - Casos Positivos: ', regM.casosPositivos);
        end;
    end;
    close(m);
    for i := 1 to dimF do begin
        close(vD[i]);
    end;
end;

