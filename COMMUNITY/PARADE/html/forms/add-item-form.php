<?php include "../common/header.php"; ?>
<div class="container">
<h3>Add Item:</h3>
<form action="add-item-submit.php" method="post">
	<div class="form-group form-group-lg">
		<label for="id">ID:</label>
		<input class="form-control" type="number" name="id" placeholder="Placard #" required><br>
	</div>
	<div class="form-group form-group-lg">
		<label for="organization">Organization:</label>
        <input class="form-control" type="text" name="organization" placeholder="Organization Name" required><br>
    </div>
	<div class="form-group form-group-lg">
		<label for="contact">Contact:</label>
        <input class="form-control" type="text" name="contact" placeholder="Contact Person" required><br>
    </div>
	<div class="form-group form-group-lg">
		<label for="phone">Phone:</label>
        <input class="form-control" type="tel" name="phone" placeholder="555-555-5555" required><br>
    </div>
	<div class="form-group form-group-lg">
		<label for="vehicles">Vehicles:</label>
        <input class="form-control" type="number" name="vehicles" placeholder="# of Vehicles" required><br>
    </div>
    <div class="form-group form-group-lg">
		<label for="trailers">Trailers:</label>
        <input class="form-control" type="number" name="trailers" placeholder="# of Trailers" required><br>
    </div>
	<div class="form-group form-group-lg">
		<label for="walkers">Walkers:</label>
		<input class="form-control" type="number" name="walkers" placeholder="# of Walkers" required><br>
	</div>
	<div class="form-group form-group-lg">
		<label for="walkers">Notes:</label>
		<input class="form-control" type="text" name="notes" placeholder=""><br>
	</div>
	<input type="hidden" name="addtimestamp" value="<?php echo date('YmdHis'); ?>">
	<button type="submit" class="btn btn-success btn-lg btn-block">Add</button>
</form>
</div>
<?php include "../common/footer.php"; ?>
