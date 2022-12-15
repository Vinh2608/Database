<?php

if(isset($_POST))
{
    require_once 'database.php'; 

    $name = $_POST['product_name'];
    $category = $_POST['category'];
    $price = $_POST['price'];
    $imgurl = $_POST['imgurl'];
    $errors = array();

    $name = htmlspecialchars($name);
    $name = trim($name);
    $price = trim($price);
    $imgurl = trim($imgurl);
    

    $filteredPrice = filter_var($price, 
                          FILTER_VALIDATE_INT, 
                          array('options' => array('min_range' => 0)));

    if($name==""){
        array_push($errors,"Name is empty !!!");
    } 
    if(!$filteredPrice){
        array_push($errors,"Price is invalid !!!");
    }

    if(!empty($errors)){
        session_start();
        $_SESSION['insert_errors'] = $errors;
        header('Location:index.php?page=insert');
    } else {
        $price = (int) $price;
        $query = "SELECT * from products
                    where name='$name'";
    
        $result = mysqli_query($conn,$query);
        if(mysqli_num_rows($result) != 0){
            array_push($errors,"Duplicate items !!!");
            session_start();
            $_SESSION['insert_errors'] = $errors;;
            header('Location:index.php?page=insert');
            die();
        } else{
            $query="";
            if ($imgurl != ""){
                $query = "INSERT INTO products (name, category, price, imgurl)
                VALUES ('$name', '$category', '$price', '$imgurl')";
            }else{
                $query = "INSERT INTO products (name, category, price)
                VALUES ('$name', '$category', '$price')";
            }
    
            if(mysqli_query($conn,$query)){
                session_start();
                $_SESSION['insert_success'] = true;
            } else {
                session_start();
                $_SESSION['insert_success'] = false;
            }
            header('Location:index.php?page=product&category=all');
        }
    }
                         

    mysqli_close($conn);
}

?>