<?php
  if (isset($_POST['word1']) && isset($_POST['word2'])) {
    echo $_POST['word1'] . ' ' . $_POST['word2'];
  } else {
    echo 'No data sent.';
  }
?>