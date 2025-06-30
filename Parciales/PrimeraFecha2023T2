program Parcial;
const
    valorAlto = 99990; // valor para indicar que no hay mas registros
type
    empleado = record 
        dni: integer;
        nombre: string[30];
        apellido: string[30];
        edad: integer;
        domicilio: string[50];
        fecha: integer // mas facilidad
    end;

    maestro = file of empleado;


procedure leer(var m: maestro; var emp: empleado);
begin
    if not eof(m) then begin
        read(m, emp);
    end
    else begin
        emp.dni := valorAlto; // valor para indicar que no hay mas registros
    end;
end;

procedure agregarEmpleado(var m: maestro);
var
    emp,cabecera: empleado;
begin
    reset(m);
    writeln('Ingrese el DNI del empleado:');
    readln(emp.dni);
    writeln('Ingrese el nombre del empleado:');
    readln(emp.nombre);
    writeln('Ingrese el apellido del empleado:');
    readln(emp.apellido);
    writeln('Ingrese la edad del empleado:');
    readln(emp.edad);
    writeln('Ingrese el domicilio del empleado:');
    readln(emp.domicilio);
    writeln('Ingrese la fecha de ingreso (en formato AAAAMMDD):');
    readln(emp.fecha);
    if (not existeEmpleado(m, emp.dni)) then begin
        seek(m,1);
        read(m,cabecera);
        if (cabecera.dni = 0) then begin
            seek(m,fileSize(m));
            write(m,emp);
        end
        else begin
            seek(m,cabecera.dni * -1);
            read(m,cabecera);
            seek(m,filePos(m)-1);
            write(m,emp);
            seek(m,0);
            write(m,cabecera);
        end;
    end;
    else begin
        writeln('El empleado con DNI ', emp.dni, ' ya existe.');
    end;
    close(m);
end;


procedure darBaja(var m: maestro);
var
    dni: integer;
    pos: integer;
    emp,cabecera: empleado;
begin
    writeln('Ingrese el DNI del empleado a dar de baja:');
    readln(dni);
    reset(m);
    read(m,cabecera);
    if (existeEmpleado(m,dni)) then begin
        pos:= 1;
        leer(m, emp);
        while (emp.dni <> valorAlto) and (emp.dni <> dni) do begin
            pos := pos + 1;
            leer(m, emp);
        end;
        if (emp.dni = dni) then begin
            seek(m,filePos(m) - 1);
            write(m, cabecera); // marcar como eliminado
            seek(m,0);
            cabecera.dni := pos * -1; // actualizar cabecera
            write(m, cabecera);
        end;
    end
    else begin
        writeln('El empleado con DNI ', dni, ' no existe.');
    end;
    close(m);
end;


