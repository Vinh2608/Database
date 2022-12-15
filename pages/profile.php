<?php require "./components/head.php"; ?>

<section class="col-md-10 col-12">

  <div class="row">
    <?php
    $id = $_GET['id'];
    $query = "SELECT * from goods WHERE ID = '$id'";
    $result = $conn->query($query)->fetch_all(MYSQLI_ASSOC)[0];
    $imgurl = $result['imgurl'];
    ?>
    <div class="col-6 mb-4">
      <div class='card border border-dark h-100'>
        <div class='card-body'>
          <div class="row">
            <div class="col-5 d-flex align-items-center justify-content-center" style="height:300px">
              <img src='<?= $imgurl ?>' style="max-height:100%;max-width:100%">
            </div>
            <div class="col-7" style="height:120px">
              <dl class="row mt-2">
                <dt class="col-sm-5">Name</dt>
                <dd class="col-sm-7"><?= $result['Name'] ?></dd>

                <dt class="col-sm-5">Price</dt>
                <dd class="col-sm-7"><?= $result['Price'] ?></dd>

                <dt class="col-sm-5">Category</dt>
                <dd class="col-sm-7"><?= $result["Type"] ?></dd>

                <dd class="col-sm-7"><a href='./index.php?page=showcart&id=<?= $id ?>' class='btn btn-sm rounded-pill btn-outline-success onclick = "add_to_cart()"'>Place order</a></dd>
              </dl>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<?php require "./components/foot.php"; ?>