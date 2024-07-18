<?php include "../common/header.php"; ?>
<div class="container">
	<h3>Delete Item:</h3>
	<form action="delete-item-submit.php" method="post">
<?php $dir = '/var/www/html/items/'; ?>
<?php $files = array_diff(scandir($dir), array('..', '.', 'deleted')); ?>
		<div class="form-group form-group-lg">
			<select class="custom-select" name="item" required>
				<option value="">Select item to delete...</option>
<?php foreach($files as $file): ?>
<?php $lines = file($dir . $file); ?>
<?php $id = trim($lines[0], "\n"); ?>
<?php $organization = trim($lines[1], "\n"); ?>
<?php $item = $id . " - " . $organization; ?>
				<option value="<?php echo $file; ?>"><?php echo $item; ?></option>
<?php endforeach; ?>
			</select>
		</div>
		<input type="hidden" name="deltimestamp" value="<?php echo date('YmdHis'); ?>">
		<button type="submit" class="btn btn-danger btn-lg btn-block">Delete</button>
	</form>
</div>
<?php include "../common/footer.php"; ?>
