program Parcial;
cont
    valorAlto = 99999;
type
    prestamo = record
        num: integer;
        dni: integer;
        numPres: integer;
        fecha: integer;
        monto: real;
    end;

    archivo = file of prestamo;


procedure leer(var a: archivo ; var p: prestamo);
begin
    if (not eof(a)) then begin
        read(a,p);
    end
    else begin
        p.num:= valorAlto;
    end;
end;

procedure corteControL(var a: archivo ; var txt: text);
var
    reg: prestamo;
    sucAct, empAct, anioAct, cantVentas, ventasSuc, cantidadEmpresa: integer;
    montoEmpresa, montoEmpleado, montoSucursal: real;
begin
    reset(a);
    rewrite(txt);
    leer(a,reg);
    cantVentas:= 0;
    while (reg.num <> valorAlto) do begin
        ventasSuc:= 0;
        montoPorSuc:= 0;
        sucAct:= reg.num;
        writeln(txt, 'Sucursal: ', sucAct)
        while (reg.num = sucAct) do begin
            empAct:= reg.dni;
            montoEmpleado:= 0;
            ventasEmp:= 0;
            writeln('Empleado: ', empAct);
            while (reg.num = sucAct) and (reg.dni = empAct) do begin
                anioAct:= reg.fecha;
                writeln(txt,'Fecha: ', anioAct);
                montoEmpleado:= montoEmpleado + reg.monto;
                ventasEmp:= ventasEmp + 1
                while (reg.num = sucAct) and (reg.dni = empAct) and (reg.anio = anioAct) do begin
                    ventasSuc:= ventasSuc + 1;
                    montoSucursal:= montoSucursal + montoEmpleado;
                    cantVentas:= cantVentas + ventasSuc;
                    leer(a,reg);
                end;
                writeln(txt,'Monto empleado: ', montoEmpleado);
                writeln(txt, 'Ventas empleado: ', ventasEmpleado);
            end;
            writeln(txt,'Monto sucursal: ',montoSucursal);
            writeln(txt,'Ventas sucursal: ',ventasSuc);
        end;
    end;
    writeln(txt, 'Ventas totales: ', cantVentas);
    close(a);
    close(txt);
end;
