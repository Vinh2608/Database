<?php

session_start();
if (!isset($_SESSION['weblab'])){
    $_SESSION['weblab'] = false;
}
// if(!$_SESSION['auth']){
//     header('location:login.php');
// }

$pageName ="product";
require_once 'database.php';
if (isset($_GET['page'])){
    $pageName = strtolower($_GET['page']);
    if (strpos($pageName, 'processing') == true){
        require "./processing/${pageName}.php";
    }
    else{
        require "./pages/${pageName}.php";
    }
}
else{
    header("location:index.php?page=product&category=all");
}
