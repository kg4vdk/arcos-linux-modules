<?php include "../common/header.php"; ?>
<style type="text/css">
body {
	background-color: #2a602a;
}
</style>
<div class="container">
<h3>Add Item:</h3>
<form action="add-item-submit.php" method="post">
	<div class="form-group form-group-lg">
		<label for="id">Placard Number:</label>
		<input class="form-control" type="number" name="id" placeholder="Placard Number" required><br>
	</div>
	<div class="form-group form-group-lg">
		<label for="organization">Organization Name:</label>
	        <input class="form-control" type="text" name="organization" placeholder="Organization Name" required><br>
    	</div>
	<div class="form-group form-group-lg">
		<label for="contact">Contact Person:</label>
        	<input class="form-control" type="text" name="contact" placeholder="Contact Person" required><br>
    	</div>
	<div class="form-group form-group-lg">
		<label for="phone">Phone Number:</label>
        	<input class="form-control" type="tel" name="phone" placeholder="555-555-5555" required><br>
    	</div>
	<div class="form-group form-group-lg">
		<label for="vehicles">Vehicles:</label>
        	<input class="form-control" type="number" name="vehicles" placeholder="Number of Vehicles" required><br>
    	</div>
    	<div class="form-group form-group-lg">
		<label for="trailers">Trailers/Floats:</label>
        	<input class="form-control" type="number" name="trailers" placeholder="Number of Trailers/Floats" required><br>
    	</div>
	<div class="form-group form-group-lg">
		<label for="walkers">Walkers (Approximate OK):</label>
		<input class="form-control" type="number" name="walkers" placeholder="Number of Walkers" required><br>
	</div>
	<div class="form-group form-group-lg">
		<label for="walkers">Notes:</label>
		<input class="form-control" type="text" name="notes" placeholder=""><br>
	</div>
	<p style="text-align:center; font-weight:bold;"><i>*** All fields (except "Notes") are REQUIRED! ***</i></p>
	<input type="hidden" name="addtimestamp" value="<?php echo date('Y-m-d_HisT'); ?>">
	<button type="submit" class="btn btn-success btn-lg btn-block" style="margin-bottom:50px;">Add</button>
</form>
</div>
<?php include "../common/footer.php"; ?>
