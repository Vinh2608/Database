<?php require "./components/head.php"; ?>
<section class="col-md-10 col-12">
  <?php
  $title = '';
  if ($_GET['category'] == 'Foods and Beverages') {
    $title = 'Foods and Beverages';
  }
  if ($_GET['category'] == 'Electronics') {
    $title = 'Electronics';
  }
  if ($_GET['category'] == 'Sports') {
    $title = 'Sports';
  }
  if ($_GET['category'] == 'Clothes') {
    $title = 'Clothes';
  }
  if ($_GET['category'] == 'Health and Personal Care') {
    $title = 'Health and Personal Care';
  }
  ?>
  <h1><?=$title?></h1>
  <div class="row">
    <?php
    $catName = 'book';
    $query = "SELECT * from goods";
    if (isset($_GET['category'])) {
      $catName = strtolower($_GET['category']);
      if ($catName == "all") {
        $query = "SELECT * from goods";
      } else {
        $query = "SELECT * from goods
                    where Type='$catName'";
      }
    }
    $result = mysqli_query($conn, $query);
    $items = mysqli_fetch_all($result, MYSQLI_ASSOC);
    mysqli_free_result($result);
    // Print item
    foreach ($items as $item) {
      $id = $item['ID'];
      $brand = $item['Brand'];
      $name = $item["Name"];
      $price = $item["Price"];
      $Type = $item["Type"];
      $Description = $item["Description"];
      $imgurl = $item['imgurl'];
    ?>
      <div class="col-3 mb-4">
        <div class='card botder border-dark h-100'>
          <div class="card-header" style="height:30px">
            <h5 class='card-title'><?= $name ?></h5>
          </div>
          <div class='card-body'>
            <div class="row">
              <div class="col-12 d-flex align-items-center justify-content-center" style="height:200px">
                <img src='<?= $imgurl ?>' style="max-height:100%;max-width:100%">
              </div>
              <div class="col-12" style="height:120px">
                <dl class="row mt-2">
                  <dt class="col-sm-6">Price</dt>
                  <dd class="col-sm-6"><?= $price ?></dd>

                  <dt class="col-sm-6">Category</dt>
                  <dd class="col-sm-6"><?= $Type ?></dd>
                </dl>
                <div class="d-flex align-items-center justify-content-around mb-1">
                  <a href='./index.php?page=profile&id=<?= $id ?>' class='btn btn-sm rounded-pill btn-outline-success'>View</a>
                  <a href='./index.php?page=update&category=<?= $catName ?>&id=<?= $id ?>' class='btn btn-sm rounded-pill btn-outline-primary' style="<?php if (!(isset($_SESSION['role']) && $_SESSION['role'] == 'admin')) echo 'display: none !important;' ?>">UPDATE</a>
                  <a href='./index.php?page=delete-processing&category=<?= $catName ?>&name=<?= $name ?>' class='btn btn-sm rounded-pill btn-outline-danger' style="<?php if (!(isset($_SESSION['role']) && $_SESSION['role'] == 'admin')) echo 'display: none !important;' ?>">DELETE</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    <?php
    }
    ?>
  </div>
</section>
<?php require "./components/foot.php"; ?>