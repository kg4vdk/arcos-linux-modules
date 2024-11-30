<?php include "../common/header.php"; ?>
<style type="text/css">
body {
	background-color: #6a6a42;
}
</style>
<div class="container">
<h3>Modify Item:</h3>
<?php $file = "/var/www/html/items/" . $_POST["item"]; ?>
<?php $lines = file($file); ?>
<?php $id = trim($lines[0], "\n"); ?>
<?php $organization = trim($lines[1], "\n"); ?>
<?php $contact = trim($lines[2], "\n"); ?>
<?php $phone = trim($lines[3], "\n"); ?>
<?php $vehicles = trim($lines[4], "\n"); ?>
<?php $trailers = trim($lines[5], "\n"); ?>
<?php $walkers = trim($lines[6], "\n"); ?>
<?php $notes = trim($lines[7], "\n"); ?>
<?php $addtimestamp = trim($lines[8], "\n"); ?>
<form action="modify-item-submit.php" method="post">
	<div class="form-group form-group-lg">
		<label for="id">Placard Number:</label>
		<input class="form-control" type="number" name="id" value="<?php echo $id; ?>" required><br>
	</div>
	<div class="form-group form-group-lg">
		<label for="organization">Organization Name:</label>
	        <input class="form-control" type="text" name="organization" value="<?php echo $organization; ?>" required><br>
	</div>
	<div class="form-group form-group-lg">
		<label for="contact">Contact Person:</label>
        	<input class="form-control" type="text" name="contact" value="<?php echo $contact; ?>" required><br>
    	</div>
	<div class="form-group form-group-lg">
		<label for="phone">Phone Number:</label>
        	<input class="form-control" type="tel" name="phone" value="<?php echo $phone; ?>" required><br>
    	</div>
	<div class="form-group form-group-lg">
		<label for="vehicles">Vehicles:</label>
        	<input class="form-control" type="number" name="vehicles" value="<?php echo $vehicles; ?>" required><br>
    	</div>
    	<div class="form-group form-group-lg">
		<label for="trailers">Trailers/Floats:</label>
        	<input class="form-control" type="number" name="trailers" value="<?php echo $trailers; ?>" required><br>
    	</div>
	<div class="form-group form-group-lg">
		<label for="walkers">Walkers (Approximate OK):</label>
		<input class="form-control" type="number" name="walkers" value="<?php echo $walkers; ?>" required><br>
	</div>
	<div class="form-group form-group-lg">
		<label for="notes">Notes:</label>
		<input class="form-control" type="text" name="notes" value="<?php echo $notes; ?>"><br>
	</div>
	<p style="text-align:center; font-weight:bold;"><i>*** All fields (except "Notes") are REQUIRED! ***</i></p>
	<input type="hidden" name="addtimestamp" value="<?php echo $addtimestamp; ?>">
	<input type="hidden" name="item" value="<?php echo $file; ?>">
	<button type="submit" class="btn btn-warning btn-lg btn-block" style="margin-bottom:50px;">SAVE</button>
</form>
</div>
<?php include "../common/footer.php"; ?>

