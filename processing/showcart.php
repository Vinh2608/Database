<?php require "./components/head.php"; ?>
<section class="col-md-10 col-12">
    <div class="row">
    <?php
        error_reporting(E_ERROR | E_PARSE);

        $goods_id = $_GET['id'];
        $quantity = $_POST['quantity'];
        $customerID = $_SESSION['id'];
        $Export_bill_ID = 123 - $_SESSION['id'] - $_SESSION['export_count'];
        $_SESSION['goods_id'] = $goods_id;
        $datetime = date('Y-m-d H:i:s');

        // $datetime = date('Ymd h:i:s');
        $sql4 = "";
        $sqlSearchUnique = "SELECT ID FROM cart_list WHERE Status = 0 AND GoodsID = '$goods_id' AND Export_bill_ID = '$Export_bill_ID'";
        $result = $conn->query($sqlSearchUnique);
        if ($result->num_rows >0) {
            while ($rowSearch = $result->fetch_assoc())
            {
                $quantityUpdate = $quantity + $rowSearch['Quantity'];
                $sql4 = "UPDATE cart_list SET Quantity = '$quantityUpdate' WHERE GoodsID = '$goods_id'";
            } 
        }
        else {
            $sql4 = "INSERT INTO cart_list(GoodsID, Quantity, Status, DateTimeOrdered, Export_bill_ID, Supermarket_Scode_in, Customer_ID,Total_cost) VALUES ('$goods_id', '$quantity', '0','$datetime', $Export_bill_ID, 70000,$customerID,0)";
        }
        $curTotalCost = 0;
        $sqlTotalCost = "SELECT Total_cost FROM cart_list WHERE Export_bill_ID = '$Export_bill_ID' AND Customer_ID= '$customerID' AND Status = 0";
        $resultTotalCost = $conn->query($sqlTotalCost);
        if ($resultTotalCost->num_rows > 0) {
            while ($rowTotalCost = $resultTotalCost->fetch_assoc()) {
                $curTotalCost += $rowTotalCost['Total_cost'];
            }
        }
        $sqlCheckDiscount = "SELECT check_if_qualify_for_discount('$customerID', '70000', '$datetime', '$curTotalCost')";
        $resultCheckDiscount = $conn->query($sqlCheckDiscount)->fetch_array(MYSQLI_NUM);

        if (!empty($resultCheckDiscount))
            $curTotalCost = $curTotalCost - $resultCheckDiscount[0] / 100 * $curTotalCost;
        $_SESSION['curTotalCost'] = $curTotalCost;
        
        $sql5 = "SELECT * from goods join cart_list on goods.ID = cart_list.GoodsID Where Export_Bill_ID = '$Export_bill_ID' AND Status ='0'";
        $conn->query($sql4);
        $result = $conn->query($sql5);

        if ($result->num_rows >0) {
            while ($row2 = $result->fetch_assoc()) {
            ?> 
                <div class='col-6 mb-4'>
                    <div class='card border border-dark h-100'>
                        <div class='card-body'>
                            <div class='row'>
                                <div class='col-5 d-flex align-items-center justify-content-center' style='height:300px'>
                                    <img src='<?= $row2['imgurl'] ?>' style='max-height:100%;max-width:100%'>
                                </div>
                            <div class='col-7' style='height:120px'>
                                <dl class='row mt-2'>
                                    <dt class='col-sm-5'>Name</dt>
                                    <dd class='col-sm-7'>
                                        <?= $row2['Name'] ?>
                                    </dd>

                                    <dt class='col-sm-5'>Price</dt>
                                    <dd class='col-sm-7'>
                                        <?= number_format($row2['Price']) ?>
                                    </dd>
                                    <dt class='col-sm-5'>Category</dt>
                                        <dd class='col-sm-7'>
                                            <?= $row2["Type"] ?> 
                                        </dd>
                                    <dt class='col-sm-5'>Quantity</dt>
                                        <dd class='col-sm-7'>
                                            <?= $row2["Quantity"] ?> 
                                        </dd>
                                    <dd class='col-sm-7'> <span class='btn btn-sm rounded-pill btn-outline-success'><?= number_format($row2['Price']) ?> </span></dd>
                                </dl>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
    <?php
            }
        }
    ?>
    <div class = "col-9">
    </div>
    <div class = "col-3 float-right">
        <div class="card" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title"><?php
                echo "Total cost is $" . number_format($_SESSION['curTotalCost']);
                                ?></h5>
                <a href="index.php?page=checkout&Export_bill_ID=<?=(123-$_SESSION['id'] - $_SESSION['export_count'])?>"> <button class="btn btn-primary">Checkout </button></a>
            </div>
        </div>
    </div>    
    </div>
</section>
<!-- <?php require "./components/foot.php"; ?> -->