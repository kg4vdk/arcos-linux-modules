<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
?>

<?php
$filename = "/var/www/html/items/" . $_POST["item"];
$newfilename = "/var/www/html/items/deleted/" . $_POST["item"];
rename($filename, $newfilename);
?>

<?php header('Location: ../index.php'); ?>
