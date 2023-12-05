<?php

# Ejemplo de Conexion
#$conexion = new mysqli('localhost', 'root', 'root', 'prueba_tecnica', '3306');


function conexionphp(){
    $server = 'localhost';
    $user = 'root';
    $pass = '';
    $db = 'prueba_tecnica';
    $conectar = mysqli_connect($server, $user, $pass, $db) or die ("Error en la conexion");
    return $conectar;
}
$conexion = conexionphp();
 #Verificar la conexión
if (!$conexion) {
    die("Error de conexión: " . mysqli_connect_error());
}

# Esta es la "Consulta" obligatoria de la parte anterior.
$consulta = "SELECT alu.dni, alu.apellido, alu.nombres, cur.abreviatura AS curso_abreviatura, cur.cod_curso AS id_curso, cur.desccripcion AS nombre_curso
FROM alumnos alu
INNER JOIN inscripciones ins ON alu.dni = ins.dni_Alu
INNER JOIN cursos cur ON ins.cod_curso = cur.cod_curso
LEFT JOIN pagos pa ON alu.dni = pa.dni_alu AND ins.cod_curso = pa.cod_curso
WHERE cur.desccripcion = 'Desarrollo Back End'
AND (pa.mes <> 6 OR pa.anio <> 2023 OR pa.mes IS NULL)";

$resultado = mysqli_query($conexion, $consulta);

if ($resultado) {
    $arrayCursos = array();
    $arrayAlumnosCursos = array();

    while ($fila = $resultado->fetch_assoc()) {
        $abreviaturaCurso = $fila['curso_abreviatura'];
        $idCurso = $fila['id_curso'];
        $nombreCurso = $fila['nombre_curso'];
        $dni = $fila['dni'];
        $apellido = $fila['apellido'];
        $nombres = $fila['nombres'];

        // Estructura 1: Clave del array es la abreviatura del curso
        if (!isset($arrayCursos[$abreviaturaCurso])) {
            $arrayCursos[$abreviaturaCurso] = array(
                "id_curso" => $idCurso,
                "nombre_curso" => $nombreCurso,
                "alumnos" => array()
            );
            
        }

        // Estructura 2: Array con los datos de los alumnos
        $arrayCursos[$abreviaturaCurso]['alumnos'][$dni] = array(
            "dni" => $dni,
            "apellido" => $apellido,
            "nombres" => $nombres
        );

        // Estructura 3: Array de alumnos y cursos ordenados alfabéticamente
        $arrayAlumnosCursos[] = array(
            "abreviatura" => $abreviaturaCurso,
            "nombre_curso" => $nombreCurso,
            "dni" => $dni,
            "apellido" => $apellido,
            "nombres" => $nombres
        ); 
    }

    // Ordenar alfabéticamente por nombre_curso y luego por apellido y nombres
    usort($arrayAlumnosCursos, function ($a, $b) {
        return strcmp($a['nombre_curso'], $b['nombre_curso']) ?: strcmp($a['apellido'] . $a['nombres'], $b['apellido'] . $b['nombres']);
    });

    // Seleccionar la estructura de datos a enviar
    $arrayEjemplo = !empty($arrayCursos) ? $arrayCursos : $arrayAlumnosCursos;

    # Mostrado de datos en formato JSON para el endpoint
    echo json_encode(array(
        "codigo" => 0,
        "mensajes" => array("Datos obtenidos con éxito"),
        "data" => $arrayEjemplo
    ));

} else {
    echo json_encode(array(
        "codigo" => 1,
        "mensajes" => array("Error al ejecutar la consulta"),
        "data" => []
    ));
}

# Cerrar la conexión
$conexion->close();
?>
