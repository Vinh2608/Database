<?php
    error_reporting(E_ERROR | E_PARSE);
    $customerID = $_SESSION['id'];

    $datetime = date('Y-m-d H:i:s');
    $Export_bill_ID = $_GET['Export_bill_ID'];
    $sqlInsert = "SELECT * FROM cart_list WHERE Export_bill_ID = '$Export_bill_ID' AND STATUS = '0' AND Customer_ID = '$customerID'";
    $resultInsert = $conn->query($sqlInsert);
    
    $sql1 = "INSERT INTO export_bill(ID, Date, Name, Cashier_ID, Customer_ID, Saving_point_policy_ID) VALUES ('$Export_bill_ID','$datetime', 'Bill', '123456789', '$customerID' ,'134')";
    $result1 = $conn->query($sql1);

    if ($resultInsert->num_rows >0) {
        while ($rowInsert = $resultInsert->fetch_assoc()) {
            $rowInsertGoodsID = $rowInsert['GoodsID'];
            $rowInsertQuantity = $rowInsert['Quantity'];
            $sql2 = "CALL bill_has_goods_insert('$customerID', '$Export_bill_ID', '$rowInsertGoodsID', '$rowInsertQuantity', '123456789','$datetime')";
            $result1 = $conn->query($sql2);
        }
    }

    $sqlRestore = "UPDATE cart_list SET Status = 1 WHERE Export_bill_ID = '$Export_bill_ID' and Customer_ID=$customerID AND STATUS = '0'";
    $conn->query($sqlRestore);
    $_SESSION['export_count'] += 1;
    header ("location: index.php?page=home&category=home");    
?>
