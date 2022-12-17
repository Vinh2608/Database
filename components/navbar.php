<nav class="navbar navbar-expand-md">
  <div class="container-fluid">
    <a class="navbar-brand" href="./index.php?page=product&category=all">
      <img src="https://upload.wikimedia.org/wikipedia/commons/d/de/HCMUT_official_logo.png" alt="">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">

        <li class="nav-item">
          <a class="nav-link" href="./index.php?page=product&category=all">Home</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Products
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="./index.php?page=product&category=all">All</a></li>
            <li><a class="dropdown-item" href="./index.php?page=product&category=Foods%20and%20Beverages">Foods and Beverages</a></li>
            <li><a class="dropdown-item" href="./index.php?page=product&category=Electronics">Electronics</a></li>
            <li><a class="dropdown-item" href="./index.php?page=product&category=Sports">Sports</a></li>
            <li><a class="dropdown-item" href="./index.php?page=product&category=Clothes">Clothes</a></li>
            <li><a class="dropdown-item" href="./index.php?page=product&category=Health%20and%20Personal%20Care">Health and Personal Care</a></li>
            <li>
              <hr class="dropdown-divider">
            </li>
            <li><a href='./index.php?page=insert' class='dropdown-item' style="<?php if (!(isset($_SESSION['role']) && $_SESSION['role'] == 'admin')) echo 'display: none !important;' ?>">Insert</a></li>

          </ul>
        </li>
        <li class="nav-item">
            <span class="glyphicon glyphicon-shopping-cart"> </span> <a class="nav-link" href="./index.php?page=showcart">My cart</a>
        </li>

      </ul>
      <span>Hello <?php
                  if ($_SESSION['weblab']) {
                    echo $_SESSION['username'];
                  } else {
                    echo 'guest';
                  } ?>&nbsp&nbsp&nbsp&nbsp</span>
      <a href="./index.php?page=signup" <?php if (isset($_SESSION['username'])) echo "hidden" ?>>Signup</a><br>&nbsp&nbsp&nbsp&nbsp
      <a href="./index.php?page=login" <?php if (isset($_SESSION['username'])) echo "hidden" ?>>Login</a><br>&nbsp&nbsp&nbsp&nbsp
      <a href="./index.php?page=logout-processing" <?php if (!isset($_SESSION['username'])) echo "hidden" ?>>Logout</a>&nbsp&nbsp&nbsp&nbsp
    </div>
  </div>
</nav>
