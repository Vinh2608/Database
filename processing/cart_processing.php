<?php require "./components/head.php"; ?>
<section class="col-md-10 col-12">

    <div class="row">
    <?php
        $goods_id = $_GET['id'];
        $quantity = $_POST['quantity'];
        $Export_bill_ID = random_int(1, 100000000);
        $query = "SELECT * from goods where ID = $goods_ID";
        $result = $conn->query($query);
        $row = $result -> fetch_array(MYSQLI_NUM)[0];
        $customerID = $_SESSION['id'];

        $sql1 = "INSERT INTO export_bill(Date, Name, Cashier_ID, Customer_ID, Saving_point_policy_ID) VALUES (date('Ymd h:i:s'), 'Bill',123456789, $customerID ,134)"; 
        $sql2 = "CALL bill_has_goods_insert($customerID, $Export_bill_ID, $goods_id, $quantity, 123456789, date('Ymd') )";
        $conn->multi_query($sql1);
        $conn->multi_query($sql2);
        $conn->multi_query($sql3);

        $query = "SELECT * from cart_list where Status = 0";
        $result = $conn->query($sqlSelect);

        if ($result->num_rows >0) {
            while ($row = $result->fetch_assoc()) {
            ?> 
                <div class='col-6 mb-4'>
                    <div class='card border border-dark h-100'>
                        <div class='card-body'>
                            <div class='row'>
                                <div class='col-5 d-flex align-items-center justify-content-center' style='height:300px'>
                                    <img src='<?= $imgurl ?>' style='max-height:100%;max-width:100%'>
                                </div>
                            <div class='col-7' style='height:120px'>
                                <dl class='row mt-2'>
                                    <dt class='col-sm-5'>Name</dt>
                                    <dd class='col-sm-7'>
                                        <?= $row['Name'] ?>
                                    </dd>

                                    <dt class='col-sm-5'>Price</dt>
                                    <dd class='col-sm-7'>
                                        <?= $row['Price'] ?>
                                    </dd>
                                    <dt class='col-sm-5'>Category</dt>
                                        <dd class='col-sm-7'>
                                            <?= $row["Type"] ?> 
                                        </dd>
                                    <dd class='col-sm-7'> <span class='btn btn-sm rounded-pill btn-outline-success'><?= $row['Price'] ?> </span></dd>
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
    </div>
</section>
<?php require "./components/foot.php"; ?>