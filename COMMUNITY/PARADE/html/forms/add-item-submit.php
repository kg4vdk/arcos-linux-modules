<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
?>

<?php
$id = sprintf('%03d', $_POST["id"]);
$filename = "/var/www/html/items/" . $id . "_" . $_POST["addtimestamp"];
$id = $id . "\n";
$organization = $_POST["organization"] . "\n";
$contact = $_POST["contact"] . "\n";
$phone = $_POST["phone"] . "\n";
$vehicles = $_POST["vehicles"] . "\n";
$trailers = $_POST["trailers"] . "\n";
$walkers = $_POST["walkers"] . "\n";
$notes = $_POST["notes"] . "\n";
$file = fopen($filename, "w") or die("Unable to open file!");
fwrite($file, $id);
fwrite($file, $organization);
fwrite($file, $contact);
fwrite($file, $phone);
fwrite($file, $vehicles);
fwrite($file, $trailers);
fwrite($file, $walkers);
fwrite($file, $notes);
fclose($file);
?>

<?php header('Location: ../index.php'); ?>
