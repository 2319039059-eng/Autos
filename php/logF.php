<?php
session_start();
require 'conexion.php';

// 🔐 Limpiar datos
$correo = trim($_POST['correo']);
$password = trim($_POST['password']);

// 🛡️ Consulta mejorada (sin errores de espacios/mayúsculas)
$sql = "
SELECT * FROM (
    SELECT Correo_C AS correo, Contrasena_C AS pass, Id_tipo_usuario FROM Clientes
    UNION ALL
    SELECT Correo_V AS correo, Contrasena_V AS pass, Id_tipo_usuario FROM Vendedor
    UNION ALL
    SELECT Correo_J AS correo, Contrasena_J AS pass, Id_tipo_usuario FROM Jefe
) AS usuarios
WHERE LOWER(correo) = LOWER(?)
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $correo);
$stmt->execute();

$result = $stmt->get_result();

if ($result->num_rows > 0) {

    $user = $result->fetch_assoc();

    if ($user['pass'] === $password) {

        if ($user['Id_tipo_usuario'] == 1) {

            $_SESSION['usuario'] = $correo;

            header("Location: ../Interfaces/consultarG.html");
            exit();

        } else {
            echo "<script>
                alert('Acceso denegado: No eres administrador');
                window.location='../Interfaces/formularioG.html';
            </script>";
        }

    } else {
        echo "<script>
            alert('Contraseña incorrecta');
            window.location='../Interfaces/formularioG.html';
        </script>";
    }

} else {
    echo "<script>
        alert('Usuario no encontrado');
        window.location='../Interfaces/formularioG.html';
    </script>";
}

$stmt->close();
$conn->close();
?>