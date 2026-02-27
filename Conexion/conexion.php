<?php
    $usuario="root";
    $password="";
    $servidor="localhost";
    $baseDeDatos="	autoselect1";

    $conexion= mysqli_connect($servidor,$usuario,$password) or die ("no su realizo la conexion");

    $bd= mysqli_select_db($conexion,$baseDeDatos) or die ("no se ha establecido el acceso a la base de datos");
?>