/*********************************PRIMERA PARTE - punto N1***************************************/
SELECT alu.dni, alu.apellido, alu.nombres, cur.desccripcion AS curso FROM alumnos alu
INNER JOIN inscripciones ins ON alu.dni = ins.dni_Alu
INNER JOIN cursos cur ON ins.cod_curso = cur.cod_curso;

/*********************************PRIMERA PARTE - punto N2***************************************/
SELECT alu.dni, alu.apellido, alu.nombres FROM alumnos alu
INNER JOIN inscripciones ins ON alu.dni = ins.dni_Alu
INNER JOIN cursos cur ON ins.cod_curso = cur.cod_curso
LEFT JOIN pagos pa ON alu.dni = pa.dni_alu AND ins.cod_curso = pa.cod_curso WHERE cur.desccripcion = 'Desarrollo Back End'
AND (pa.mes <> 6 OR pa.anio <> 2023 OR pa.mes IS NULL)

