<?php
    require_once 'database.php';
    $name ='*';
    $cat = 'movie';
    if (isset($_GET['name'])){
        $name = strtolower($_GET['name']);
    }
    if (isset($_GET['category'])){
        $cat = strtolower($_GET['category']);
    }
    $query = "DELETE FROM products
    where name='$name'";

    $result = mysqli_query($conn,$query);
    $conn->close();
    $url = "Location:index.php?page=product&category=${cat}";
    header($url);
?>