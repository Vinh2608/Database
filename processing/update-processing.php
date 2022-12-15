<?php

if (isset($_POST)) {
    require_once 'database.php';
    $target_dir = "./images/";
    $target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
    $uploadOk = 1;
    $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));
    // Check if image file is a actual image or fake image
    if (isset($_POST["submit"])) {
        $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
        if ($check !== false) {
            echo "File is an image - " . $check["mime"] . ".";
            $uploadOk = 1;
        } else {
            echo "File is not an image.";
            $uploadOk = 0;
        }
    }


    // Allow certain file formats
    if (
        $imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
        && $imageFileType != "gif"
    ) {
        echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
        $uploadOk = 0;
    }

    // Check if $uploadOk is set to 0 by an error
    if ($uploadOk == 0) {
        echo "Sorry, your file was not uploaded.";
        // if everything is ok, try to upload file
    } else {
        if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
            echo "The file " . htmlspecialchars(basename($_FILES["fileToUpload"]["name"])) . " has been uploaded.";
            $imgurl = "./images/" . htmlspecialchars(basename($_FILES["fileToUpload"]["name"]));
            $currcat = $_GET['category'];
            $id = $_GET['id'];
            $name = $_POST['product_name'];
            $category = $_POST['category'];
            $price = $_POST['price'];
            $errors = array();

            $id = htmlspecialchars($id);
            $id = trim($id);
            $price = trim($price);


            $filteredPrice = filter_var(
                $price,
                FILTER_VALIDATE_INT,
                array('options' => array('min_range' => 0))
            );

            if ($name == "") {
                array_push($errors, "Name is empty !!!");
            }
            if (!$filteredPrice) {
                array_push($errors, "Price is invalid !!!");
            }

            $query = "SELECT * FROM products
                      WHERE id='${id}'";
            $result = mysqli_query($conn, $query);
            $obj = mysqli_fetch_assoc($result);
            $result->free_result();
            $id = $obj['id'];
            $old_category = $obj['category'];

            if (!empty($errors)) {
                session_start();
                $_SESSION['insert_errors'] = $errors;
                $url = "Location:index.php?page=update&id=${id}";
                header($url);
            } else {
                $price = (int) $price;

                $query = "SELECT * from products
                    where id='$id'";

                $result = mysqli_query($conn, $query);
                $query = "UPDATE products 
                      SET name='$name', category='$category', price='$price', imgurl='$imgurl'
                      WHERE id = $id";
                $result = mysqli_query($conn, $query);
                $url = "Location:index.php?page=product&category=${currcat}";
                header($url);
            }
            mysqli_close($conn);
        } else {
            echo "Sorry, there was an error uploading your file.";
        }
    }
}
