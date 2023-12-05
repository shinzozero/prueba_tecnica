document.addEventListener("DOMContentLoaded", function() {
    fetch('endpoint.php')
        .then(response => response.json())
        .then(data => {
            const zonaTabla = document.getElementById('zona-tabla');

            /* Función para crear una tabla con los datos recibidos*/
            function crearTabla(datos) {
                const zonaTabla = document.getElementById('zona-tabla');
                zonaTabla.innerHTML = ''; // Limpiamos todo el contenido
            
                for (const curso in datos) {
                    if (datos.hasOwnProperty(curso)) {
                        const cursoData = datos[curso];
            
                        const titulo = document.createElement('h2');
                        titulo.textContent = cursoData.nombre_curso;
                        zonaTabla.appendChild(titulo);
            
                        const tablaCurso = document.createElement('table');
                        tablaCurso.classList.add('tabla-cursos');
            
                        const thead = document.createElement('thead');
                        const filaCabecera = thead.insertRow();
            
                        const th1 = document.createElement('th');
                        th1.textContent = 'DNI';
                        filaCabecera.appendChild(th1);
            
                        const th2 = document.createElement('th');
                        th2.textContent = 'Apellido';
                        filaCabecera.appendChild(th2);
            
                        const th3 = document.createElement('th');
                        th3.textContent = 'Nombres';
                        filaCabecera.appendChild(th3);
            
                        tablaCurso.appendChild(thead);
            
                        const tbody = document.createElement('tbody');
            
                        for (const alumno in cursoData.alumnos) {
                            if (cursoData.alumnos.hasOwnProperty(alumno)) {
                                const alumnoData = cursoData.alumnos[alumno];
                                const fila = tbody.insertRow();
            
                                const td1 = fila.insertCell();
                                td1.textContent = alumnoData.dni;
            
                                const td2 = fila.insertCell();
                                td2.textContent = alumnoData.apellido;
            
                                const td3 = fila.insertCell();
                                td3.textContent = alumnoData.nombres;
                            }
                        }
            
                        tablaCurso.appendChild(tbody);
                        zonaTabla.appendChild(tablaCurso);
                    }
                }
            }
            
            

            /*Llamo a la función para crear la tabla con los datos que se obtuvo.*/
            crearTabla(data.data);

            /* Modifico el titulo*/
            const titulo = document.getElementById('titulo');
            titulo.textContent = 'Tabla de Cursos y Alumnos';
        })
        .catch(error => console.error('Error:', error));
});
