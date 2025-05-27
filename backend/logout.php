<?php
session_start();
session_unset();
session_destroy();
header("Location: ../public/front-end.html"); // redirect to login or homepage
exit();
?>
