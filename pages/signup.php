<?php

if ($_POST) {
    // $host = "localhost:3307";
    // $user = 'root';
    // $pass = '';
    // $db_name = 'auth';
    // $conn = mysqli_connect($host,$user,$pass,$db_name);
    require_once 'database.php';

    $username = $_POST['username'];
    $password = $_POST['password'];

    $password_regex = "/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$/";



    $query = "SELECT * from users
                where username='$username'";

    $result = mysqli_query($conn, $query);
    if (mysqli_num_rows($result) != 0) {
        echo '
        <script>
            alert("Username exists");
        </script>';
    } elseif (!preg_match($password_regex, $password)) {
        echo '
        <script>
            alert("Invalidate password, min. length 8 chars, at least 1 number, at least 1 letter(at leaset one uppercase letter)");
        </script>';
    } else {
        $query = "INSERT INTO users (username, password)
        VALUES ('$username', '$password')";

        if (mysqli_query($conn, $query)) {
            header("location:index.php?page=login");
        }
    }


    mysqli_close($conn);
}

?>
<?php require "./components/head.php"; ?>
<section class="col-md-10 col-12">
    <form method="POST">
        <h2>SIGNUP</h2>
        <label>username</label>
        <input type="email" name="username" placeholder="Username" required><br>

        <label>Password</label>
        <input type="password" name="password" placeholder="Password" required><br>

        <button type="submit" name="submit">Sign up</button>
    </form>
</section>
<?php require "./components/foot.php"; ?>