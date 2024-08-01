<?php include "../common/header.php"; ?>
<div class="container">
<h3>View Item:</h3>
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
<form action="view-item-submit.php" method="post">
	<div class="form-group form-group-lg">
		<label for="id">ID:</label>
		<input class="form-control" type="number" name="id" value="<?php echo $id; ?>" readonly><br>
	</div>
	<div class="form-group form-group-lg">
		<label for="organization">Organization:</label>
        <input class="form-control" type="text" name="organization" value="<?php echo $organization; ?>" readonly><br>
    </div>
	<div class="form-group form-group-lg">
		<label for="contact">Contact:</label>
        <input class="form-control" type="text" name="contact" value="<?php echo $contact; ?>" readonly><br>
    </div>
	<div class="form-group form-group-lg">
		<label for="phone">Phone:</label>
        <input class="form-control" type="tel" name="phone" value="<?php echo $phone; ?>" readonly><br>
    </div>
	<div class="form-group form-group-lg">
		<label for="vehicles">Vehicles:</label>
        <input class="form-control" type="number" name="vehicles" value="<?php echo $vehicles; ?>" readonly><br>
    </div>
    <div class="form-group form-group-lg">
		<label for="vehicles">Trailers:</label>
        <input class="form-control" type="number" name="trailers" value="<?php echo $trailers; ?>" readonly><br>
    </div>
	<div class="form-group form-group-lg">
		<label for="walkers">Walkers:</label>
		<input class="form-control" type="number" name="walkers" value="<?php echo $walkers; ?>" readonly><br>
	</div>
	<div class="form-group form-group-lg">
		<label for="walkers">Notes:</label>
		<input class="form-control" type="text" name="notes" value="<?php echo $notes; ?>" readonly><br>
	</div>	
	<input type="hidden" name="item" value="<?php echo $file; ?>" >
	<button type="submit" class="btn btn-primary btn-lg btn-block">CLOSE</button>
</form>
</div>
<?php include "../common/footer.php"; ?>

