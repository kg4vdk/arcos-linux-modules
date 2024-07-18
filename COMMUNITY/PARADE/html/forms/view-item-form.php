<?php include "../common/header.php"; ?>
<div class="container">
	<h3>View Item:</h3>
	<form action="view-item-form-2.php" method="post">
<?php $dir = '/var/www/html/items/'; ?>
<?php $files = array_diff(scandir($dir), array('..', '.', 'deleted')); ?>
		<div class="form-group form-group-lg">
			<select class="custom-select" name="item" required>
				<option value="">Select item to view...</option>
<?php foreach($files as $file): ?>
<?php $lines = file($dir . $file); ?>
<?php $id = trim($lines[0], "\n"); ?>
<?php $organization = trim($lines[1], "\n"); ?>
<?php $item = $id . " - " . $organization; ?>
				<option value="<?php echo $file; ?>"><?php echo $item; ?></option>	
<?php endforeach; ?>
			</select>
		</div>
		<button type="submit" class="btn btn-primary btn-lg btn-block">View</button>
	</form>
</div>
<?php include "../common/footer.php"; ?>
