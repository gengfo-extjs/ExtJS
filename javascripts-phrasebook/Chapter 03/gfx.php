<?php
  if (isset($_GET['wait']) &&
      (int)$_GET['wait'] < 15) {
    sleep((int)$_GET['wait']);   
  }
  header('Content-type: image/png');
  $img = imagecreate(10, 10);
  $color = imagecolorallocate($img, rand(0, 255), rand(0, 255), rand(0, 255));
  imagepng($img);
  imagedestroy($img);
?>