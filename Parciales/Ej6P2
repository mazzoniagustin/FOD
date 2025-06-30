program Punto6;
const
    valorAlto = 99999;
type
    maestro = record
        cod: integer;
        nombre: integer;
        codCepa: integer;
        nombreCepa: integer;
        casosActivos: integer;
        casosNuevos: integer;
        recuperados: integer;
        fallecidos: integer;
    end;

    detalle = record
        cod: integer;
        codCepa: integer;
        casosActivos: integer;
        casosNuevos: integer;
        recuperados: integer;
        fallecidos: integer;
    end;

    det = file of detalle;
    mae = file of maestro;

    vectorDetalles = array [1..10] of det;
    vectorRegistros = array [1..10] of detalle;

procedure leer(var d: det ; var det: detalle);
begin
    if (not eof(d)) then begin
        read(d,det);
    end
    else begin
        det.cod:= valorAlto;
    end;
end;

procedure minimo(var vec: vecDetalles; var vecReg: vecRegistros; var min: infoDetalle);
var
    i, pos: integer;
begin
    min.cod := valorAlto;
    for i:= 1 to 10 do
        begin
            if (vecReg[i].cod <= min.cod) and (vecReg[i].codCepa < min.codCepa) then
                begin
                    min:= vecReg[i];
                    pos:= i;
                end;
        end;
    if(min.cod <> valoralto) then
        leer(vec[pos], vecReg[pos]);
end;


procedure actualizarMaestro(var m: mae ; var d: vectorDetalles);
var
    min: detalle;
    regM: maestro;
    vR: vectorRegistros;
    cantFallecidos, cantRecuperados,codAct: integer;
begin
    for i:= 1 to 10 do begin
        assign(d[i], 'detalle'+i);
        reset(d[i]);
        read(d[i],vR[i]);
    end;
    reset(m);
    minimo(d,vR,min);
    while not (eof(m)) do begin
        read(m,regM);
        while (min.cod <> valorAlto) and (regM.cod = min.cod) do begin
            codAct:= min.cod;
            cantRecuperados:= 0;
            cantFallecidos:= 0;
            while (codAct = min.cod) do begin
                cantRecuperados:= cantRecuperados + min.recuperados;
                cantFallecidos:= cantFallecidos + min.fallecidos;
                cantActivos:= cantActivos + min.casosActivos;
                cantNuevos:= cantNuevos + min.casosNuevos
                minimo(d,vR,min);
            end;
            regM.casosActivos:= cantActivos;
            regM.casosNuevos:= cantNuevos;
            regM.fallecidos:= regM.fallecidos + cantFallecidos;
            regM.recuperados:= regM.fallecidos + cantRecuperados;
            seek(m,filePos(m)-1);
            write(m,regM);
        end;
        if (regM.casosActivos > 50) then begin
            writeln('Localidad: ', regM.cod, ' Cantidad de casos: ', regM.cantCasos);
        end;

