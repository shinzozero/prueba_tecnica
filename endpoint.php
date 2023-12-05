<?php

function conexionphp(){
    $server = 'localhost';
    $user = 'root';
    $pass = '';
    $db = 'prueba_tecnica';
    $conectar = mysqli_connect($server, $user, $pass, $db);
    if (!$conectar) {
        throw new Exception("Error en la conexion: " . mysqli_connect_error());
    }
    return $conectar;
}

try {
    $conexion = conexionphp();
    
    $consulta = "SELECT alu.dni, alu.apellido, alu.nombres, cur.desccripcion AS curso FROM alumnos alu
    INNER JOIN inscripciones ins ON alu.dni = ins.dni_Alu
    INNER JOIN cursos cur ON ins.cod_curso = cur.cod_curso";

    $resultado = mysqli_query($conexion, $consulta);

    if ($resultado) {
        $arrayCursos = array();
        
        while ($fila = $resultado->fetch_assoc()) {
            $curso = $fila['curso'];
            $dni = $fila['dni'];
            $apellido = $fila['apellido'];
            $nombres = $fila['nombres'];
            
            if (!isset($arrayCursos[$curso])) {
                $arrayCursos[$curso] = array(
                    "nombre_curso" => $curso,
                    "alumnos" => array()
                );
            }
            
            $arrayCursos[$curso]['alumnos'][$dni] = array(
                "dni" => $dni,
                "apellido" => $apellido,
                "nombres" => $nombres
            );
        }
        
        header('Content-Type: application/json');
        echo json_encode(array(
            "codigo" => 0,
            "mensajes" => array("Datos obtenidos con éxito"),
            "data" => $arrayCursos
        ));
    } else {
        throw new Exception("Error al ejecutar la consulta");
    }
    
    $conexion->close();
} catch (Exception $e) {
    header('Content-Type: application/json');
    echo json_encode(array(
        "codigo" => 1,
        "mensajes" => array($e->getMessage()),
        "data" => []
    ));
}
?>
