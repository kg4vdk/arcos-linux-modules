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
	<?php $item = "<div class='item'>" .
	"<div class='item-id'>" . $id . "</div>" .
	"<div class='item-org'>" . $organization . "</div>" .
	'<div class="item-icon"><i class="fa-solid fa-car"></i> = ' . $vehicles . "</div>" .
	'<div class="item-icon"><i class="fa-solid fa-trailer"></i> = ' . $trailers . "</div>" .
	'<div class="item-icon"><i class="fa-solid fa-walking"></i> = ' . $walkers . "</div>" .
	"<div class='item-contact'>" . $contact . " @ " . $phone . "</div>" .
	"<div class='item-notes'>Notes: " . $notes . "</div>" .
	"</div>"; ?>
		<?php echo $item; ?>
	<?php endforeach; ?>
</div>
<?php include "../common/footer.php"; ?>
