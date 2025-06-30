program Parcial;
const
    valorAlto = 99999;
    DF = 20;
type
    empresa = record 
        cod: integer;
        nombre: string[30];
        precio: real;
        stockAct: integer;
        stockMin: integer;
    end;

    sucursales = record
        cod: integer;
        cantVendida: integer;
    end;

    maestro = file of empresa;
    detalle = file of sucursales;
    vectorDetalle = array[1..DF] of detalle;
    vectorRegistro = array[1..DF] of sucursales;

procedure leer (var det: detalle ; var s: sucursales);
begin
    if not eof(det) then begin
        read(det, s);
    end
    else begin
        s.cod := valorAlto; // para indicar que no hay mas registros
    end;
end;

procedure calcularMin(var vD: vectorDetalle ; var vR: vectorRegistro; var min: sucursales);
var
    i, pos: integer;
begin
    min.cod := valorAlto;
    pos := -1;
    for i := 1 to DF do begin
        if (vR[i].cod < min.cod) then begin
            min := vR[i];
            pos := i;
        end;
    end;

    if pos <> -1 then begin
        leer(vD[pos], vR[pos]);
    end;
end;

procedure actualizarYCrearTXT(var m: maestro);
var
    txt: text;
    vD: vectorDetalle;
    vR: vectorRegistro;
    regM: empresa;
    min: sucursales;
    i: integer;
    cantVendida: integer;
    monto: real;
begin
    for i:= 1 to DF do begin
        reset(vD[i]);
        leer(vD[i], vR[i]);
    end;
    reset(m);
    rewrite(txt);
    read(m,regM);
    calcularMin(vD, vR, min);
    while (min.cod <> valorAlto) do begin
        read(m,regM);
        while (regM.cod <> min.cod) do begin
            read(m, regM);
        end;
        cantVendida := 0;
        while (regM.cod = min.cod) do begin
            cantVendida := cantVendida + min.cantVendida;
            calcularMin(vD, vR, min);
        end;
        regM.stockAct := regM.stockAct - cantVendida;
        seek(m,filePos(m) - 1);
        write(m, regM);
        monto:= cantVendida * regM.precio;
        if (monto > 10000) then begin
            writeln(txt, 'Empresa: ', regM.nombre, ' - Monto vendido: ', monto:0:2);
        end;
    end;
    