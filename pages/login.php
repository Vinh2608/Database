<?php require "./components/head.php" ?>
<section class="col-md-10 col-12">
    <?php
    if (isset($_SESSION['login_error'])) {
        echo "<p> Wrong username or password !!!!</p>";
        unset($_SESSION["login_error"]);
    }
    ?>
    <form action="./index.php?page=login-processing" method="POST">
        <h2>LOGIN</h2>
        <label>Username</label>
        <input type="text" name="username" placeholder="Username" required><br>

        <label>Password</label>
        <input type="password" name="password" placeholder="Password" required><br>

        <button type="submit" name="submit">Login</button>
    </form>
</section>
<?php require "./components/foot.php" ?>