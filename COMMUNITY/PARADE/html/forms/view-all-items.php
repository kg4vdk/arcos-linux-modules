<?php include "../common/header.php"; ?>
<div class="container">
	<h3>View All Items:</h3>
	<?php $dir = '/var/www/html/items/'; ?>
	<?php $files = array_diff(scandir($dir), array('..', '.', 'deleted')); ?>

	<?php foreach($files as $file): ?>
	<?php $lines = file($dir . $file); ?>
	<?php $id = trim($lines[0], "\n"); ?>
	<?php $organization = trim($lines[1], "\n"); ?>
	<?php $contact = trim($lines[2], "\n"); ?>
	<?php $phone = trim($lines[3], "\n"); ?>
	<?php $vehicles = trim($lines[4], "\n"); ?>
	<?php $trailers = trim($lines[5], "\n"); ?>
	<?php $walkers = trim($lines[6], "\n"); ?>
	<?php $notes = trim($lines[7], "\n"); ?>
	<?php $item = "<span style='font-size: 1.5em; font-weight: bold; padding: 8px 150px; background-color: #404040; color: #ffffff; border-radius: 15px;'>" . $id . "</span>" . "<br>" . "<span style='font-weight: bold; font-size: 1.5em'>" . $organization . "</span>" . "<br>" . $contact . " @ " . $phone . "<br>" . '<span style="background-color: #ffffff; color: #000000; border-radius: 15px; padding: 5px 10px;"><i class="fa-solid fa-car"></i> = ' . $vehicles . "</span>   " . '<span style="background-color: #ffffff; color: #000000; border-radius: 15px; padding: 5px 10px;"><i class="fa-solid fa-trailer"></i> = ' . $trailers . "</span>   " . '<span style="background-color: #ffffff; color: #000000; border-radius: 15px; padding: 5px 10px;"><i class="fa-solid fa-walking"></i> = ' . $walkers . "</span><br>" . "Notes: " . $notes; ?>
		<p class="view-all-items" style="text-transform: uppercase;"><?php echo $item; ?></p>
	<?php endforeach; ?>
</div>
<?php include "../common/footer.php"; ?>
