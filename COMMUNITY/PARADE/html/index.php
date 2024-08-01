<?php 
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
?>

<?php include "common/header.php"; ?>
<div class="container">
	<!--<a class="btn btn-primary btn-lg btn-block" href="forms/view-item-form.php" role="button">View</a>-->
	<a class="btn btn-primary btn-lg btn-block" href="forms/view-all-items.php" role="button">View All</a>
	<a class="btn btn-success btn-lg btn-block" href="forms/add-item-form.php" role="button">Add</a>
	<a class="btn btn-warning btn-lg btn-block" href="forms/modify-item-form.php" role="button">Modify</a>
	<a class="btn btn-danger btn-lg btn-block" href="forms/delete-item-form.php" role="button">Delete</a>
</div>

<?php include "common/footer.php"; ?>
