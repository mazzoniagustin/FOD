program dengue;
const
    valorAlto = 9999;
type
    info = record
        cod: integer;
        nombre: string;
        cantCasos: integer;
    end;

    meses = record
        cod: integer;
        casos: integer;
    end;

    maestro = file of info;

    detalle = file of meses;

    vectorDetalles = array[1..30] of detalle;
    vectorRegistros = array[1..30] of meses;

procedure leer(var d:detalle ; var m: meses);
begin
    if (not eof(d)) then begin
        read(d,m);
    end
    else begin
        m.cod:= valorAlto;
    end;
end;

procedure calcularMin(var d: vectorDetalles ; var m: vectorRegistros ; var min: meses);
var
    i,pos: integer;
begin
    min.cod:= valorAlto;
    for i:= 1 to 30 do begin
        if (m[i].cod < min.cod) then begin
            min:= m[i];
            pos:= i;
        end;
    end;
    read(d[pos],m[pos]);
end;

procedure actualizarMaestro(var m: maestro ; var d: vectorDetalles);
var
    nombre: string;
    cant, codAct: integer;
    regM: info;
    i: integer;
    nombreArch: string;
    min: meses;
    vectorReg: vectorRegistros;
begin
    writeln('Ingrese el nombre del archivo maestro');
    readln(nombre);
    assign(m,nombre);
    reset(m);
    for i:= 1 to 30 do begin
        writeln('Ingrese el nombre del detalle numero ',i);
        readln(nombre);
        assign(d[i],nombre);
        reset(d[i]);
        read(d[i],vectorReg[i]);
    end;
    calcularMin(d,vectorReg,min);
    while (not eof(m)) do begin
        read(m,regM);
        while (min.cod <> valorAlto) and (regM.cod = min.cod) do begin
            codAct:= min.cod;
            cant:= 0;
            while (codAct = min.codAct) do begin
                cant:= cant + min.casos;
                calcularMin(d,vectorReg,min);
            end;
            regM.casos:= regM.casos + cant;
            seek(m,filePos(m) -1);
            write(m,regM);
        end;
        if (regM.casos > 15) then begin
            writeln('Cantidad de casos para el municipio: ', regM.cod, '', regM.casos);
        end;
    end;
    




        
