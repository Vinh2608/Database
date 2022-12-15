<?php require "./components/head.php"; ?>

<section class="col-md-10 col-12">
    <h2>THIS IS UPDATE PAGE</h2>
    <?php
    if (isset($_SESSION['insert_errors'])) {
        foreach ($_SESSION['insert_errors'] as $error) {
            echo "<p> ${error} </p>";
        }
        unset($_SESSION['insert_errors']);
    }

    ?>
    <?php
    require_once 'database.php';
    $id = '';
    $cat = 'movie';
    $currcat = 'movie';
    if (isset($_GET['category'])) {
        $currcat = strtolower($_GET['category']);
    }
    if (isset($_GET['id'])) {
        $id = strtolower($_GET['id']);
    }
    $query = "SELECT * FROM products
                WHERE id='${id}'";
    $result = mysqli_query($conn, $query);
    $obj = mysqli_fetch_assoc($result);
    $category = $obj['category'];
    $price = $obj['price'];
    $imgurl = $obj['imgurl'];
    $name = $obj['name'];
    ?>
    <img src='<?= $imgurl ?>' style="max-height:300px;max-width:300px">
    <form action='./index.php?page=update-processing&category=<?= $currcat ?>&id=<?= $id ?>' enctype="multipart/form-data" method='POST' class='row g-3'>
        <div class='col-12'>
            <label for='product_name' class='form-label'>Name</label>
            <input type='text' class='form-control' name='product_name' value='<?= $name ?>' required>
        </div>
        <div class='col-md-4'>
            <label for='category' class='form-label'>Category</label>
            <select name='category' class='form-select' required>
                <option value="movie">Movie</option>
                <option value="book">Book</option>
            </select>
        </div>
        <div class='col-md-5'>
            <label for='price' class='form-label'>Price</label>
            <input type='text' value='<?= $price ?>' class='form-control' name='price' required>
        </div>
        <fieldset>
            <div class="input-group">
                <input type="file" name="fileToUpload" id="fileToUpload inputGroupFile04" class="form-control" aria-describedby="inputGroupFileAddon04" aria-label="Upload" required>
            </div>
        </fieldset>
        <div class='col-12'>
            <button type='submit' class='btn btn-primary'>Submit</button>
        </div>
    </form>

</section>
<?php require "./components/foot.php"; ?>