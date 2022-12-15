<?php require "./components/head.php"; ?>
<section class="col-md-10 col-12">
  <?php
  $title = '';
  if ($_GET['category'] == 'book') {
    $title = 'All books';
  }
  if ($_GET['category'] == 'movie') {
    $title = 'All movies';
  }
  if ($_GET['category'] == 'all') {
    $title = 'All books and movies';
  }
  if ($_GET['category'] == 'home') {
    $title = 'This is home page';
  }
  ?>
  <h1>$title</h1>
</section>
<?php require "./components/foot.php"; ?>