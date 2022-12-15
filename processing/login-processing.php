<?php

if(isset($_POST))
{
    require_once 'database.php'; 

    $username = $_POST['username'];
    $password = $_POST['password'];

    $query = "SELECT * from users
            where username='$username' and password='$password'";

    $result = mysqli_query($conn,$query);
    $user = mysqli_fetch_assoc($result);
    if(mysqli_num_rows($result) == 1){
        session_start();
        $_SESSION['weblab'] = true;
        $_SESSION['username'] = $username;
        $_SESSION['role'] = $user["role"];


        $cookie_name = "user";
        $cookie_value = $username;
        setcookie($cookie_name, $cookie_value, time() + (86400 * 30), "/");
        
        header('location:index.php?page=product&category=all');
    } else{
        session_start();
        $_SESSION['weblab'] = false;
        $_SESSION['login_error'] = "Wrong username or password";
        header('location:index.php?page=login');
    }
    mysqli_close($conn);
}

?>